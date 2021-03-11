class StaticPagesController < ApplicationController
  def home
    redirect_to 'http://localhost:3000/restaurants'
  end
end
