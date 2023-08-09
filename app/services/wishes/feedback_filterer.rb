module Wishes
  class FeedbackFilterer
    DEFAULT_COLUMN_DIRECTION = 'desc'.freeze
    DEFAULT_ORDER_COLUMN = 'votes_count'.freeze
    ORDER_COLUMN_WHITELIST = %w[votes_count created_at updated_at].freeze
    ORDER_DIRECTION_WHITELIST = %w[ASC DESC].freeze

    def initialize(filter_params:, scope:)
      @stage = filter_params[:stage]
      @wishlist_id = filter_params[:wishlist_id]
      @order_column = filter_params[:order_column]
      @order_direction = filter_params[:order_direction]
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

      @scope = scope.where(stage: stage)
    end

    def apply_wishlist_filter
      return unless wishlist_id.present?

      wishlist = Wishlist.find_by(id: wishlist_id)
      @scope = scope.where(wishlist: wishlist) if wishlist
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
