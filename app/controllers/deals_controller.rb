class DealsController < ApplicationController
  
  def new
    @deal = Deal.new
  end

  def create
    @deal  = current_user.deals.build(params[:deal])
    if @deal.save
      flash[:success] = "Oferta cadastrada com sucesso!"
      redirect_to root_path
    else
      render "new"
    end
  end

end
