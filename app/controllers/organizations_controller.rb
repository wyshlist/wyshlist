# rubocop:disable Metrics/ClassLength
class OrganizationsController < ApplicationController
  before_action :set_organization, only: %i[show edit update destroy]
  before_action :check_team_member_subdomain, only: %i[feedback boards members edit]
  before_action :order_column_whitelist,
                :order_direction_whitelist,
                :set_stages,
                :set_wishlists, only: :feedback

  def new
    @organization = Organization.new
    @organization_search = ""
    authorize @organization
  end

  def show
    @wishlists = @organization.wishlists.sort { |a, b| b.wishes.count <=> a.wishes.count }
    @wishlist = @organization.wishlists.first
    authorize @organization
  end

  # rubocop:disable Metrics/MethodLength
  def create
    if params[:organization_search] && params[:organization_search] != ""
      handle_existing_organization(params[:organization_search])
    else
      @organization = Organization.new(organization_params)
      authorize @organization
      respond_to do |format|
        if @organization.save
          SubdomainCreator.new(@organization.subdomain).call if Rails.env.production?
          current_user.update(organization: @organization, role: 'super_team_member', super_team_member_since: Time.now)
          format.html { update_user_and_redirect(@organization) }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
        format.json
      end
    end
  end
  # rubocop:enable Metrics/MethodLength

  def edit
    authorize @organization
  end

  def update
    authorize @organization
    if @organization.update(organization_params)
      flash[:notice] = "Organization updated successfully"
      redirect_to authenticated_root_url(subdomain: @organization.subdomain), allow_other_host: true
    else
      flash[:alert] = "Organization not updated, try again later"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @organization
    if @organization.destroy && current_user.update(organization: nil, role: 'user')
      flash[:notice] = "Organization deleted successfully"
    else
      flash[:alert] = "Organization not deleted, try again later"
      render :edit, status: :unprocessable_entity
    end
    redirect_to authenticated_root_path
  end

  def feedback
    @organization = @current_organization
    @wishlists = @organization.wishlists
    authorize @organization
    @wish = Wish.new
    @wishes = @organization.wishes
    return unless params[:filter].present?

    @wishes = Wishes::FeedbackFilterer.new(filter_params:, scope: @wishes).call
  end

  def boards
    @organization = @current_organization
    @wishlists = @organization.wishlists
    authorize @organization
  end

  def members
    @organization = Organization.find_by(subdomain: request.subdomain)
    authorize @organization
    @members = @organization.users.order(:first_name)
  end

  def remove_member
    @organization = Organization.find_by(subdomain: request.subdomain)
    authorize @organization
    @member = User.find(params[:user_id])
    @member.update(organization: nil, role: 'user')
    redirect_to members_path
    flash[:notice] = "#{@member.email} has been removed from organization"
  end

  private

  def order_column_whitelist
    @order_column_whitelist ||=
      Wishes::FeedbackFilterer::ORDER_COLUMN_WHITELIST.map { [_1.titleize, _1] }
  end

  def order_direction_whitelist
    @order_direction_whitelist ||=
      Wishes::FeedbackFilterer::ORDER_DIRECTION_WHITELIST.map { [_1.titleize, _1] }
  end

  def set_stages
    @stages = Wish.distinct.pluck(:stage)
  end

  def set_wishlists
    @wishlists = @current_organization.wishlists
  end

  def filter_params
    params[:filter].permit(:stage, :wishlist_id, :order_column, :order_direction)
  end

  def check_team_member_subdomain
    if current_user.organization.nil?
      redirect_to new_organization_path
    elsif request.subdomain != current_user.organization.subdomain
      redirect_to authenticated_root_url(subdomain: current_user.organization.subdomain), allow_other_host: true
    end
  end

  def set_organization
    @organization = Organization.find(params[:id]) if params[:id]
    @organization = Organization.find_by(subdomain: request.subdomain)
    authorize @organization
  end

  def organization_params
      params.require(:organization).permit(:name, :logo, :color, :subdomain)
  end

  def order_direction_whitelist
    @order_direction_whitelist ||=
      Wishes::FeedbackFilterer::ORDER_DIRECTION_WHITELIST.map { [_1.titleize, _1] }
  end

  def set_stages
    @stages = Wish.distinct.pluck(:stage)
  end

  def filter_params
    params[:filter].permit(:stage, :wishlist_id, :order_column, :order_direction)
  end

  def set_organization
    @organization = Organization.find(params[:id])
    authorize @organization
  end

  def handle_existing_organization(organization_name)
      @organization = Organization.where('LOWER(name) ILIKE ?', organization_name.downcase).first || @organization = Organization.new
      if @organization.id
          update_user_and_redirect(@organization)
          authorize @organization
      else
          redirect_to new_organization_path, alert: "Team not found, maybe you should create it?"
          authorize @organization
      end
  end

  def update_user_and_redirect(organization)
      current_user.update(organization: organization, role: 'super_team_member', super_team_member_since: Time.now)
      redirect_to authenticated_root_url(subdomain: current_user.organization.subdomain), allow_other_host: true
  end
end
# rubocop:enable Metrics/ClassLength
