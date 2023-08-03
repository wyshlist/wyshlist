module Wishes
  class Filterer

    DEFAULT_ORDER_COLUMN = 'votes_count'.freeze
    DEFAULT_COLUMN_DIRECTION = 'desc'

    ORDER_COLUMN_WHITELIST = %w[votes_count].freeze
    ORDER_DIRECTION_WHITELIST = %w[ASC DESC].freeze

    def initialize(filter_params:, scope:)
      @stage = filter_params.fetch(:stage, nil)
      @order_column = filter_params.fetch(:order_column, nil)
      @order_direction = filter_params.fetch(:order_direction, nil)

      @scope = scope
    end

    def call
      apply_stage_filter

      apply_order

      scope
    end

    private

    def apply_stage_filter
      return scope if stage.blank?

      @scope = scope.where(stage:)
    end

    def apply_order
      return scope if order_column.blank?

      if order_column == 'votes_count'
        @scope = scope.joins(:votes)
                      .group('wishes.id')
                      .order("COUNT(votes.id) #{order_direction}")
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

    attr_reader :stage, :scope
  end
end
