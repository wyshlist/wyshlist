class WishPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def create?
    true
  end

  def show?
    true
  end

  def update?
    user.admin? || user_is_team_member?
  end

  def destroy?
    user.admin? || user_is_record_owner? || user_is_team_member?
  end
end
