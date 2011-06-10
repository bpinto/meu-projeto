class DealsController < ApplicationController
  
  def new
    @deal = Deal.new
  end

  def create
    @deal  = current_user.deals.build(params[:deal])
    if @deal.save
      redirect_to root_path, :success => "Deal created with success!"
    else
      render :new
    end
  end
end
