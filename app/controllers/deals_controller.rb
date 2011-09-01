# coding: UTF-8
class DealsController < AuthorizedController
  skip_before_filter :authenticate_user!, :only => [:index, :show, :today]
  prepend_before_filter :find_todays_deals, :only => :today
  prepend_before_filter :find_deals, :only => :index
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

  def find_deals
    @deals = Deal.active
    @deals = @deals.search(params[:search]) if params[:search]
  end

  def populate_cities_name
    @cities_name = City.all.collect { |c| [c.name, c.id] }
  end
end
