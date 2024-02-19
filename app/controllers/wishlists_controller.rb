class WishlistsController < ApplicationController
    add_breadcrumb "home", :authenticated_root_path
    before_action :set_organization, only: [:index]
    skip_before_action :authenticate_user!, only: [:index]

  def index
    @wishlists = policy_scope(@organization.wishlists).includes(:wishes)
  end

  def new
    # @organization = Organization.find(params[:organization]) if params[:organization]
    @organization = current_user.organization
    @wishlist = Wishlist.new
    authorize @wishlist
  end

  def create
    @wishlist = Wishlist.new(wishlist_params)
    @wishlist.user = current_user
    authorize @wishlist
    if @wishlist.save
      flash[:notice] = "Board created successfully"
      redirect_to boards_path
    else
      flash[:alert] = "There was a problem creating your board, try again later: #{@wishlist.errors.full_messages.join(", ")}"
      redirect_to new_wishlist_path
    end
  end

  def destroy
    @wishlist = Wishlist.find(params[:id])
    authorize @wishlist
    if @wishlist.destroy
      flash[:notice] = "Board deleted successfully"
      redirect_to wishlists_path
    else
      flash[:alert] = "Board not deleted, try again later"
      redirect_to wishlist_wishes_path(@wishlist)
    end
  end

  def edit
    @wishlist = Wishlist.find(params[:id])
    authorize @wishlist
  end

  # rubocop:disable Metrics/MethodLength
  def update
    @wishlist = Wishlist.find(params[:id])
    if wishlist_params[:organization_id]
      wishlist_params[:organization_id] =
        current_user.organization.id
    else
      wishlist_params[:organization_id] = nil
    end
    authorize @wishlist
    if @wishlist.update(wishlist_params)
      flash[:notice] = "Board updated successfully"
      redirect_to wishlist_wishes_path(@wishlist)
    else
      flash[:alert] = "There was a problem updating your board, try again later"
      render :edit
    end
  end
  # rubocop:enable Metrics/MethodLength

  private

  def wishlist_params
    params.require(:wishlist).permit(:title, :description, :color, :private, :organization_id)
  end

  def set_organization
    subdomain = request.subdomain
    @organization = Organization.find_by(subdomain:)
    redirect_to authenticated_root_url(subdomain: 'www'), allow_other_host: true unless @organization
  end
end
