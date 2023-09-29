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

  def create?
    true
  end

  def show?
    true
  end

  def edit?
    # super_team_member is a team_member
    user.admin? || (user.team_member_of(record) && user.super_team_member?)
  end

  def update?
    user.admin? || (user.team_member_of(record) && user.super_team_member?)
  end

  def destroy?
    user.admin? || (user.team_member_of(record) && user.super_team_member?)
  end

  def feedback?
    user.admin? || user.team_member_of(record)
  end

  def members?
    user.team_member_of(record)
  end

  def remove_member?
    user.admin? || (user.team_member_of(record) && user.super_team_member?)
  end
end
