class OrganizationPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def new?
    true
  end

  def edit?
    record.users.include?(user)
  end

  def create?
    true
  end

  def update?
    record.users.include?(user)
  end

  def destroy?
    record.users.include?(user)
  end
end
