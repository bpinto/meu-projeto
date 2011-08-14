class DealsController < AuthorizedController
  skip_before_filter :authenticate_user!, :only => :today
  prepend_before_filter :find_todays_deals, :only => :today

  def new
  end

  def create
    if @deal.save
      redirect_to root_path, :notice => "Oferta criada com sucesso!"
    else
      flash.now[:alert] = "Foram encontrados erros ao criar a oferta."
      render :new
    end
  end

  def today
  end

  private

  def find_todays_deals
    @deals = Deal.today
  end
end
