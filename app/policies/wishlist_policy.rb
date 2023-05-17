class WishlistPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope = user.all_wishlists
    end
  end

  def index?
    record.private == false || user_is_owner_or_team_member_or_admin?
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

  def update?
    user_is_owner_or_admin?
  end

  def destroy?
    user_is_owner_or_admin?
  end
end
