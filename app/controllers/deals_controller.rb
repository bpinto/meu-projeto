class DealsController < ApplicationController
  def new
    @deal = Deal.new
  end

  def create
    @deal  = current_user.deals.build(params[:deal])
    if @deal.save
      redirect_to root_path, :notice => "Oferta criada com sucesso!"
    else
      flash.now[:alert] = "Foram encontrados erros ao criar a oferta."
      render :new
    end
  end

  def today
    @deals = Deal.today
  end
end
