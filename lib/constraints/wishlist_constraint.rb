class WishlistConstraint
  def self.matches?(request)
    if request.controller_class == WishesController
      organization = Wishlist.find(request.params[:wishlist_id]).organization if request.params[:wishlist_id]
      organization = Wish.find(request.params[:id]).organization if request.params[:id]
    elsif request.controller_class == WishlistsController
      organization = Wishlist.find(request.params[:id]).organization
    else
    end

    (request.subdomain == organization.subdomain)
  end
end
