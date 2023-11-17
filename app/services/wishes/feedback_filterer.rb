module Wishes
  class FeedbackFilterer
    DEFAULT_COLUMN_DIRECTION = 'desc'
    DEFAULT_ORDER_COLUMN = 'created_at'

    ORDER_COLUMN_WHITELIST = %w[votes_count created_at updated_at]
    ORDER_DIRECTION_WHITELIST = %w[ASC DESC]

    attr_reader :stage, :board, :start_date, :end_date, :query, :scope

    def initialize(filter_params:, scope:)
      @stage = filter_params.fetch(:stage, nil)
      @board = filter_params.fetch(:board, nil)
      @start_date = filter_params.fetch(:start_date, nil)
      @end_date = filter_params.fetch(:end_date, nil)
      @query = filter_params.fetch(:query, nil)
      @order_column = filter_params.fetch(:order_column, nil)
      @order_direction = filter_params.fetch(:order_direction, 'DESC')
      @scope = scope
    end

    def call
      apply_stage_filter
      apply_date_filter
      apply_wishlist_filter
      apply_query_filter

      apply_order
      scope
    end

    private

    def apply_stage_filter
      return unless stage.present?

      @scope = scope.where(stage:)
    end

    def apply_wishlist_filter
      return unless board.present?

      @scope = scope.search_by_board_name(board)
    end

    def apply_date_filter
      return unless start_date.present? || end_date.present?

      @scope = scope.where(created_at: (start_date.to_date)...(end_date.to_date + 1.day))
    end

    def apply_query_filter
      return unless query.present?

      @scope = scope.search_by_title_and_description(query)
    end

    def apply_order
      return unless order_column.present?

      @scope = scope.reorder(order_column => order_direction)
    end

    def order_column
      @order_column.presence_in(ORDER_COLUMN_WHITELIST) || DEFAULT_ORDER_COLUMN
    end

    def order_direction
      @order_direction.presence_in(ORDER_DIRECTION_WHITELIST) || DEFAULT_COLUMN_DIRECTION
    end
  end
end
