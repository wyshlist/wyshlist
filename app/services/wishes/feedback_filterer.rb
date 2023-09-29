module Wishes
  class FeedbackFilterer
    DEFAULT_COLUMN_DIRECTION = 'desc'
    DEFAULT_ORDER_COLUMN = 'votes_count'

    ORDER_COLUMN_WHITELIST = %w[votes_count created_at updated_at]
    ORDER_DIRECTION_WHITELIST = %w[ASC DESC]

    def initialize(filter_params:, scope:)
      @stage = filter_params.fetch(:stage, nil)
      @wishlist_id = filter_params.fetch(:wishlist_id, nil)
      @order_column = filter_params.fetch(:order_column, nil)
      @order_direction = filter_params.fetch(:order_direction, nil)
      @scope = scope
    end

    def call
      apply_stage_filter
      apply_wishlist_filter

      apply_order

      scope
    end

    private

    def apply_stage_filter
      return unless stage.present?

      @scope = scope.where(stage:)
    end

    def apply_wishlist_filter
      return unless wishlist_id.present?

      wishlist = Wishlist.find_by(id: wishlist_id)
      @scope = scope.where(wishlist:) if wishlist
    end

    def apply_order
      return unless order_column.present?

      if order_column == 'votes_count'
        @scope = scope.order("votes_count #{order_direction}")
      else
        @scope = scope.order(order_column => order_direction)
      end
    end

    def order_column
      @order_column.presence_in(ORDER_COLUMN_WHITELIST) || DEFAULT_ORDER_COLUMN
    end

    def order_direction
      @order_direction.presence_in(ORDER_DIRECTION_WHITELIST) || DEFAULT_COLUMN_DIRECTION
    end

    attr_reader :stage, :wishlist_id, :scope
  end
end
