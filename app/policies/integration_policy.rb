class IntegrationPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def new?
    record.wishlist.user == user
  end

  def create?
    record.wishlist.user == user
  end

  def destroy?
    record.wishlist.user == user
  end
end
