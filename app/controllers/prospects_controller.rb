#Encoding: UTF-8
class ProspectsController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]

  load_and_authorize_resource
  
  include ProspectsHelper   
  
  helper_method :sort_column, :sort_direction
  
  def index
    @title = "Tous les prospects" 

    #@search = Prospect.search do
     # fulltext params[:search]
  @prospects =  Prospect.search(params[:search])

       # with :prospect_status, params[:prospect_status].humanize
       @prospects = @prospects.selected_status(params[:prospect_status])
      if  !params[:min_updated_date].to_s.empty?
        # with(:updated_at).greater_than(params[:min_updated_date])
        @prospects = @prospects.where("updated_at >= ?",Time.parse(params[:min_updated_date]))  
      end
      if !params[:max_updated_date].to_s.empty?
       #with(:updated_at).less_than(params[:max_updated_date])
       @prospects = @prospects.where("updated_at <= ?",Time.parse(params[:max_updated_date]))  
      end
     # order_by sort_column, sort_direction
    #end
    #@prospects = @search.results
    @prospects = @prospects.order(sort_column + " " + sort_direction)
    @prospects = @prospects.paginate(:per_page => 5, :page => params[:page]) 
  end
  
  def show
    if !@prospect.birthyear.nil?
      @prospect.birthyear = Time.now.year - @prospect.birthyear 
    end
    @title = @prospect.first_name + " " + @prospect.last_name
  end
  
  def new
     @title = "Création d'un prospect"
     @prospect.timespent = "00:00:00"
  end
  
  def create
    @prospect.user  = current_user
    if @prospect.save
      flash[:success] = "Prospect created!"
      if @prospect.prospect_status == "to_classify"
          @client = Client.new
          @client.prospect_id = @prospect.id
          @client.save
      end
      redirect_to root_path
    else
      @title = "Création d'un prospect"
      render 'new'
    end
  end
  
  def edit
    @titre = "Édition du prospect"
    @prospect.birthyear = get_age @prospect.birthyear
    @prospect.timespent = @prospect.timespent.strftime('%H:%M:%S')
  end

  def update
    if @prospect.update_attributes(params[:prospect])
      flash[:success] = "Prospect actualisé."

      @client = Client.where("prospect_id = ?", @prospect.id)
      
      if @prospect.prospect_status == "To classify" && @client.empty?
          @client = Client.new  
          @client.prospect_id = @prospect.id
          @client.save
      end
      redirect_to @prospect
    else
      @title = "Édition du prospect"
      render 'edit'
    end
  end
  
  def destroy
    @prospect.destroy    
    redirect_to prospects_path
  end
  
  private
  
  def sort_column
    Prospect.column_names.include?(params[:sort]) ? params[:sort] : "updated_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end  
end