# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end

  private

  def user_is_super_team_member?
    # super_team_member is a team_member
    user.super_team_member? && user_is_team_member?
  end

  def user_is_team_member?
    user.team_member_of(record.user.organization)
  end

  def user_is_record_owner?
    user.owner_of(record)
  end
end
