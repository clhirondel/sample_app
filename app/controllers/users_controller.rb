#Encoding: UTF-8
class UsersController < ApplicationController

  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy

  load_and_authorize_resource
  
  def index
    @title = "Tous les utilisateurs"
    @users = User.paginate(:page => params[:page])
    
  end
  
  def show
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.firstname + " " + @user.lastname
  end
  
  def new
     @title = "Inscription"
  end

  def create
    if @user.save
      sign_in @user
      flash[:success] = "Bienvenue dans l'Application Exemple!"
      redirect_to @user
    else
      @title = "Inscription"
      render 'new'
    end
  end
  
  def edit
    @title = "Édition profil"
  end
  
  def update
    if params[:user][:password].nil?
      # password not edited
      params[:user][:password] = @user.password
      params[:user][:password_confirmation] = @user.password
    end
    if @user.update_attributes(params[:user])
      flash[:success] = "Profil actualisé."
      redirect_to @user
    else
      @title = "Édition profil"
      render 'edit'
    end
  end
  
  def destroy
    flash[:success] = "Utilisateur supprimé."
    redirect_to users_path
  end  
  
  private

    def authenticate
      deny_access unless signed_in?
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
