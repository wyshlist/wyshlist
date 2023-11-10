class WishPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
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

  def edit?
    user.admin? || user_is_record_owner? 
  end

  def update?
    user.admin? || user_is_record_owner?
  end

  def destroy?
    user.admin? || user_is_record_owner?
  end
end
