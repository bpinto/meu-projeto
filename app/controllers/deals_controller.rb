class DealsController < ApplicationController
  def new
    @deal = Deal.new
  end

  def create
    puts params[:deal][:type]
    @deal  = current_user.deals.build(params[:deal])
    if @deal.save
      redirect_to root_path, :notice => "Deal created with success!"
    else
      render :new
    end
  end
end
