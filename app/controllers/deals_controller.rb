# coding: UTF-8
class DealsController < AuthorizedController
  skip_before_filter :authenticate_user!, :only => [:index, :show, :today]
  prepend_before_filter :find_active_deals, :only => :index
  prepend_before_filter :find_todays_deals, :only => :today
  prepend_before_filter :initialize_comment, :only => :show
  before_filter :populate_cities_name, :only => :new

  def index
    flash.now[:notice] = "Não foi encontrada nenhuma oferta com '#{params[:search]}'" if @deals.empty? && params[:search]
  end

  def new
  end

  def create
    @deal.user = current_user
    if @deal.save
      redirect_to root_path, :notice => "Oferta criada com sucesso!"
    else
      flash.now[:error] = "Foram encontrados erros ao criar a oferta."
      populate_cities_name
      render :new
    end
  end

  def show
  end

  def today
  end

  private

  def find_todays_deals
    @deals = Deal.today
    @deals = @deals.by_category_string(params[:category]) if params[:category]
  end

  def find_active_deals
    @deals = Deal.active
    @deals = @deals.search(params[:search]) if params[:search]
    @deals = @deals.by_cities(user_cities_ids) if user_cities_ids
  end

  def populate_cities_name
    @cities_name = City.all.collect { |c| [c.name, c.id] }
  end

  def initialize_comment
    @comment = Comment.new
  end
end
