class WishPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def edit?
    user_is_owner_or_admin?
  end

  def new?
    true
  end

  def create?
    true
  end

  def show?
    true
  end

  def update?
    user_is_owner_or_admin?
  end

  def destroy?
    user_is_owner_or_admin?
  end
end
