#Encoding: UTF-8
class CampaignsController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]

  load_and_authorize_resource
    
  helper_method :sort_column, :sort_direction
  
  def index
    @title = "Toutes les campagnes" 

    #@search = Prospect.search do
     # fulltext params[:search]
    @campaigns =  Campaign.search(params[:s])

       # with :prospect_status, params[:prospect_status].humanize
       @campaigns = @campaigns.selected_type(params[:type])
      if  !params[:min_date].to_s.empty?
        # with(:updated_at).greater_than(params[:min_updated_date])
        @campaigns = @campaigns.where("updated_at >= ?",Time.parse(params[:min_date]))  
      end
      if !params[:max_date].to_s.empty?
       #with(:updated_at).less_than(params[:max_updated_date])
       @campaigns = @campaigns.where("updated_at <= ?",Time.parse(params[:max_date]))  
      end
     # order_by sort_column, sort_direction
    #end
    #@prospects = @search.results
    @campaigns = @campaigns.order(sort_column + " " + sort_direction)
    @campaigns = @campaigns.paginate(:per_page => 5, :page => params[:page]) 
  end
  
  def show
    @title = "Campagne: "+@campaign.name
  end
  
  def new
     @title = "Création d'une campagne"
  end
 
  def create
    @campaign.user  = current_user
    if @campaign.save
      flash[:success] = "Campaign created!"
      redirect_to root_path
    else
      @title = "Création d'une campagne"
      render 'new'
    end
  end
  
  def destroy
    @campaign.destroy
    respond_to do |format|  
      format.html { redirect_to(campaigns_path) }  
      format.js
    end
  end

  private
  
  def sort_column
    Campaign.column_names.include?(params[:sort]) ? params[:sort] : "updated_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:dir]) ? params[:dir] : "desc"
  end  
  
end
