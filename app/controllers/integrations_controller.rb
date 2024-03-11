class IntegrationsController < ApplicationController
  def new
    @wishlist = Wishlist.find(params[:wishlist_id])
    @integration = Integration.new(wishlist: @wishlist)
    authorize @integration
  end

  # rubocop:disable Metrics/MethodLength
  def create
    @wishlist = Wishlist.find(params[:wishlist_id])
    @integration = Integration.new(integration_params)
    @integration.wishlist = @wishlist
    @integration.user = current_user
    authorize @integration
    if @integration.save!
      redirect_to wishlist_path(@wishlist)
      flash[:notice] = t('flash.integration.success')
    else
      render :new, status: :unprocessable_entity
    end
  end
  # rubocop:enable Metrics/MethodLength

  def destroy
    @integration = Integration.find(params[:id])
    @integration.destroy
    redirect_to wishlist_wishes_path(@integration.wishlist)
  end

  private

  def integration_params
    params.require(:integration).permit(:name, :action, :workspace, :api_token, :project)
  end
end
