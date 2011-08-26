class DealsController < AuthorizedController
  skip_before_filter :authenticate_user!, :only => [:show, :today]
  prepend_before_filter :find_todays_deals, :only => :today

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
    if params[:category]
      @deals = Deal.today.by_category(params[:category])
    else
      @deals = Deal.today
    end
  end
end
