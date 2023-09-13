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
    user.admin? || user.is_team_member_of(record) && user.is_super_team_member?
  end

  def update?
    user.admin? || user.is_team_member_of(record) && user.is_super_team_member?
  end

  def destroy?
    user.admin? || user.is_team_member_of(record) && user.is_super_team_member?
  end

  def feedback?
    user.admin? || user.is_team_member_of(record)
  end

  def members?
    user.is_team_member_of(record)
  end

  def remove_member?
    user.admin? || user.is_team_member_of(record) && user.is_super_team_member?
  end
end
