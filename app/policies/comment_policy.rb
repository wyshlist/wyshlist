class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def edit?
    user.admin? || user_is_record_owner?
  end

  def create?
    true
  end

  def update?
    user.admin? || user_is_record_owner?
  end

  def destroy?
    user.admin? || user_is_record_owner?
  end
end
