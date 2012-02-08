# coding: UTF-8
class DealsController < AuthorizedController
  skip_before_filter :authenticate_user!, :only => [:index, :show, :today]
  prepend_before_filter :find_deals, :only => [:index, :today]
  before_filter :define_title, :only => :show
  before_filter :populate_cities_name, :only => [:new, :share]

  def index
    flash.now[:notice] = "Não foi encontrada nenhuma oferta com '#{params[:search]}'" if @deals.empty? && params[:search]
    @title = Deal.i18n_category(Deal::CATEGORIES_DICTIONARY[params[:category]]) if params[:category]
  end

  def new
  end

  def create
    @deal.user = current_user
    if @deal.save
      if current_user.provider? && current_user.facebook_share_offer
        me = FbGraph::User.me(current_user.access_token)
        me.feed!( :message => current_user.name + " acabou de compartilhar uma oferta no DealWit.Me", :link => deal_url(@deal), :description => @deal.description)
      end
      redirect_to root_path, :notice => "Oferta criada com sucesso!"
    else
      populate_cities_name

      flash.now[:error] = "Foram encontrados erros ao criar a oferta."
      render :new
    end
  end

  def show
    @comment = Comment.new
    @title = @deal.title
  end

  def today
    flash.now[:notice] = "Não foi encontrada nenhuma oferta com '#{params[:search]}'" if @deals.empty? && params[:search]
    @title = "Ofertas do dia"
    @title = Deal.i18n_category(Deal::CATEGORIES_DICTIONARY[params[:category]]) if params[:category]
  end

  def share
    @deal = Share.create_deal params[:share]

    render :new
  rescue Errno::ETIMEDOUT
    flash.now[:alert] = "Não foi possível ler as informações da oferta no site indicado."
    @deal = Deal.new :link => params[:share]
    render :new
  end

  def unvote
    current_user.unvote!(@deal)
    redirect_to deal_path(@deal), :notice => "Voto apagado com sucesso!"
  end

  def upvote
    current_user.up_vote(@deal)
    if current_user.provider? && current_user.facebook_vote_offer
      me = FbGraph::User.me(current_user.access_token)
      me.feed!(:message => current_user.name + " gostou de uma oferta no DealWit.Me", :link => deal_url(@deal), :description => @deal.description)
    end
    redirect_to deal_path(@deal), :notice => "Voto computado com sucesso!"
  rescue MakeVoteable::Exceptions::AlreadyVotedError
    redirect_to deal_path(@deal), :error => "Voto já computado anteriormente."
  end

  def downvote
    current_user.down_vote(@deal)
    if current_user.provider? && current_user.facebook_vote_offer
      me = FbGraph::User.me(current_user.access_token)
      me.feed!(:message => current_user.name + " não gostou de uma oferta no DealWit.Me", :link => deal_url(@deal), :description => @deal.description)
    end
    redirect_to deal_path(@deal), :notice => "Voto computado com sucesso!"
  rescue MakeVoteable::Exceptions::AlreadyVotedError
    redirect_to deal_path(@deal), :error => "Voto já computado anteriormente."
  end

  private

  def find_deals
    @deals = Deal.paginate(:page => params[:page])
    @deals = search_order(@deals, params)
    @deals = @deals.by_category_string(params[:category]) if params[:category]
    @deals = @deals.search(params[:search]) if params[:search]
    @deals = @deals.by_cities(user_cities_ids) if user_cities_ids.try(:any?)

    case action_name
    when "index"
      @deals = @deals.active
    when "today"
      @deals = @deals.today
    end
  end

  def populate_cities_name
    @cities_state_hash = City.hash_by_states
    @cities_name = City.order_by_state#.collect { |c| [c.name, c.id] }
  end

  def search_order(scope, params)
    case params[:search_order]
    when "most_recent"
      scope.recent
    when "lowest_price"
      scope.lowest_price
    when "highest_price"
      scope.highest_price
    when "highest_discount"
      scope.highest_discount
    else
      scope.recent
    end
  end

  def define_title
    title = @deal.title
  end
end
