class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home privacy_policy terms_of_service]

  def home
  end

  def privacy_policy
  end

  def terms_of_service
  end
end
