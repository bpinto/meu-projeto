# coding: UTF-8
class DealsController < AuthorizedController
  skip_before_filter :authenticate_user!, :only => [:index, :show, :today]
  prepend_before_filter :find_active_deals, :only => :index
  prepend_before_filter :find_todays_deals, :only => :today
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
      populate_cities_name

      flash.now[:error] = "Foram encontrados erros ao criar a oferta."
      render :new
    end
  end

  def show
    @comment = Comment.new
  end

  def today
  end

  private

  def find_todays_deals
    @deals = Deal.today.paginate(:page => params[:page])
    @deals = @deals.by_category_string(params[:category]) if params[:category]
  end

  def find_active_deals
    @deals = Deal.active.paginate(:page => params[:page])
    @deals = @deals.search(params[:search]) if params[:search]
    @deals = @deals.by_cities(user_cities_ids) if user_cities_ids.try(:any?)
  end

  def populate_cities_name
    @cities_name = City.all.collect { |c| [c.name, c.id] }
  end
end
