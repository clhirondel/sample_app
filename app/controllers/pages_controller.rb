#Encoding: UTF-8
class PagesController < ApplicationController
  def home
    @title = "Accueil"
    if signed_in?
      @micropost = Micropost.new
      @feed_items = current_user.feed.paginate(:page => params[:page])
   end
  end
  
  def contact
    @title = "Contact"
  end

  def about
    @title = "À Propos"
  end
  
  def help
    @title = "Aide"
  end
end
