#Encoding: UTF-8
class ClientsController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :authorized_user, :only => :destroy
  
  load_and_authorize_resource
  
  def index
    @title = "Tous les clients"
    @clients = Client.paginate(:page => params[:page]) 
  end
  
  def show
    @prospect = Prospect.find(@client.prospect_id)
    @title = @prospect.first_name + " " + @prospect.last_name
  end
  
  def edit
    @titre = "Édition du client"
  end

  def update
    if @client.update_attributes(params[:client])
      flash[:success] = "Client actualisé."
      redirect_to @client
    else
      @title = "Édition du client"
      render 'edit'
    end
  end
  
  def destroy
    @client.destroy
    respond_to do |format|  
      format.html { redirect_back_or clients_path }  
      format.js
    end
  end
    
  def authorized_user
    @client = Client.find(params[:id])
    redirect_to root_path unless current_user?(@client.prospect.user)
  end
end

