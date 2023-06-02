class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :privacy_policy, :terms_of_service, :pricing ]

  def home
  end

  def privacy_policy
  end

  def terms_of_service
  end

  def pricing
  end
end
