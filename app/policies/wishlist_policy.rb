class WishlistPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      organization = scope.first.user.organization
      user.is_team_member(organization) ? scope.all : scope.where(private: false)
    end
  end

  def index?
    true
  end

  def new?
    organization = user.organization
    user.admin? || user.is_team_member_of(organization) && user.is_super_team_member?
  end

  def create?
    new?
  end

  def edit?
    new?
  end

  def update?
    new?
  end

  def destroy?
    new?
  end
end
