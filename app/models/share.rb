# encoding: UTF-8

require 'open-uri'

class Share
  XPATH_ADDRESS = 'address'
  XPATH_CATEGORY = 'type'
  XPATH_COMPANY = []
  XPATH_DESCRIPTION = 'description'
  XPATH_DISCOUNT = []
  XPATH_END_DATE = []
  XPATH_IMAGE = 'image'
  XPATH_KIND = []
  XPATH_PRICE = []
  XPATH_REAL_PRICE = []
  XPATH_TITLE = 'title'

  AMERICANAS = "americanas.com"
  GROUPON = "groupon.com"
  PEIXE_URBANO = "peixeurbano.com"
  PONTO_FRIO = "pontofrio.com"
  SUBMARINO = "submarino.com"

  AMERICANAS_CATEGORIES = {
    "ELETRODOMÉSTICOS" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "INFORMÁTICA" => Deal::CATEGORY_COMPUTER,
    "CELULARES E TELEFONES" => Deal::CATEGORY_ELECTRONICS,
    "CÂMERAS E FILMADORAS" => Deal::CATEGORY_ELECTRONICS,
    "ELETRÔNICOS" => Deal::CATEGORY_ELECTRONICS,
    "ELETROPORTÁTEIS" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "UTILIDADES DOMÉSTICAS" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "MÓVEIS E DECORAÇÃo" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "CAMA, MESA E BANHO" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "FERRAMENTAS E JARDIM" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "DVDS E BLU-RAY" => Deal::CATEGORY_CULTURE,
    "LIVROS" => Deal::CATEGORY_CULTURE,
    "BELEZA E SAÚDE" => Deal::CATEGORY_BEAUTY_AND_HEALTH,
    "BRINQUEDOS" => Deal::CATEGORY_KIDS,
    "BEBÊS" => Deal::CATEGORY_KIDS,
    "ESPORTE E LAZER" => Deal::CATEGORY_FITNESS,
    "AUTOMOTIVO" => Deal::CATEGORY_CAR
  }

  PONTO_FRIO_CATEGORIES = {
    "Automotivo" => Deal::CATEGORY_CAR,
    "Bebês" => Deal::CATEGORY_KIDS,
    "Beleza & Saúde" => Deal::CATEGORY_BEAUTY_AND_HEALTH,
    "Brinquedos" => Deal::CATEGORY_KIDS,
    "Cama, Mesa e Banho" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Cine & Foto" => Deal::CATEGORY_CULTURE,
    "DVDs e Blu-Ray" => Deal::CATEGORY_CULTURE,
    "Eletrodomésticos" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Eletrônicos" => Deal::CATEGORY_ELECTRONICS,
    "Eletroportáteis" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Esporte & Lazer" => Deal::CATEGORY_FITNESS,
    "Ferramentas" => Deal::CATEGORY_OTHER,
    "Flores" => Deal::CATEGORY_OTHER,
    "Futebol" => Deal::CATEGORY_OTHER,
    "Games" => Deal::CATEGORY_OTHER,
    "Informática" => Deal::CATEGORY_COMPUTER,
    "Livros" => Deal::CATEGORY_CULTURE,
    "Malas" => Deal::CATEGORY_OTHER,
    "Móveis" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Papelaria" => Deal::CATEGORY_OTHER,
    "Perfumaria" => Deal::CATEGORY_BEAUTY_AND_HEALTH,
    "Telefones & Celulares" => Deal::CATEGORY_ELECTRONICS,
    "Relógios" => Deal::CATEGORY_OTHER,
    "Utilidades Domésticas" => Deal::CATEGORY_HOME_AND_APPLIANCE
  }

  CATEGORIES = {
    "bares-e-baladas" => Deal::CATEGORY_RESTAURANT,
    "cursos-e-aulas" => Deal::CATEGORY_CULTURE,
    "entretenimento" => Deal::CATEGORY_FITNESS,
    "esporte" => Deal::CATEGORY_FITNESS,
    "hoteis-e-viagens" => Deal::CATEGORY_TRAVEL,
    "produtos" => nil,
    "restaurantes" => Deal::CATEGORY_RESTAURANT,
    "saude-e-beleza" => Deal::CATEGORY_BEAUTY_AND_HEALTH,
    "servicos-locais" => Deal::CATEGORY_OTHER
  }

  def self.create_deal(link)
    @deal = Deal.new :link => link

    begin
      if @deal.link.match(AMERICANAS)
        populate_americanas_deal(@deal)
      elsif @deal.link.match(GROUPON)
        populate_groupon_deal(@deal)
      elsif @deal.link.match(PEIXE_URBANO)
        populate_peixeurbano_deal(@deal)
      elsif @deal.link.match(PONTO_FRIO)
        populate_pontofrio_deal(@deal)
      elsif @deal.link.match(SUBMARINO)
        populate_submarino_deal(@deal)
      else
        populate_deal(@deal)
      end
    rescue Errno::ENOENT => wrong_link_exception
      @deal = Deal.new
    end

    @deal
  end

  #Open the link with 'utf-8' encoding.
  def self.open_page(link)
    page = Nokogiri::HTML(open(link).read) #Nokogiri bug: You need to use .read method in order to use encoding.
    page.encoding = 'utf-8'
    page
  end

  def self.populate_deal(deal)
    page = open_page(deal.link)

    deal.title = page.at_css(XPATH_TITLE).try(:text).try(:strip)
    
  end

  def self.populate_americanas_deal(deal)
    page = open_page(deal.link)

    deal.title = page.at_css(XPATH_TITLE).try(:text).try(:strip)
    deal.price_mask = page.at_css(".sale").try(:text).try(:strip)[7..-1].try(:strip)
    deal.real_price_mask = page.at_css(".regular").try(:text).try(:strip)[6..-1].try(:strip)
    deal.description = page.at_css(".infoProdBox").try(:text).try(:strip)[0,1200]
    deal.category = AMERICANAS_CATEGORIES[page.at_css(".category").try(:text).try(:strip).sub(">","")]
    deal.company = "Americanas"
    #if deal.price
      deal.kind = Deal::KIND_OFFER
    #else
    #  deal.kind = Deal::KIND_ON_SALE
    #end
  end

  def self.populate_groupon_deal(deal)
    page = open_page(deal.link)

    deal.title = page.at_css("#contentDealTitle").try(:text).try(:strip)
    deal.price_mask = page.at_css(".noWrap").try(:text).try(:strip)[3..-1].try(:strip)
    #deal.real_price_mask = page.at_css(".regular").try(:text).try(:strip)[6..-1].try(:strip)
    deal.description = page.at_css(".contentDealDescriptionFacts").try(:text).try(:strip)[0,1200]
    deal.company = "Groupon"
    #TODO: O método consegue setar city_id da oferta, mas não consegue exibir corretamente já na tela de cadastro de nova oferta
    deal.city = City.find_by_name(page.at_css("#headerCityButton").try(:text).try(:strip)).first
    if deal.city
      deal.city_id = deal.city.id
    end
    deal.kind = Deal::KIND_DAILY_DEAL
  end

  def self.populate_peixeurbano_deal(deal)
    page = open_page(deal.link)

    deal.title = page.at_css(XPATH_TITLE).try(:text).try(:strip)
    if page.at_css(".new_price").try(:text)
      deal.price_mask = page.at_css(".new_price").try(:text).try(:strip)[2..-1].try(:strip)
      if not deal.price_mask.match(",")
        deal.price_mask = deal.price_mask + ",00"
      end
      deal.real_price_mask = page.at_css(".old_price").try(:text).try(:strip)[2..-1].try(:strip)
      if not deal.real_price_mask.match(",")
        deal.real_price_mask = deal.real_price_mask + ",00"
      end
      deal.description = page.at_css(".deal_details").try(:text).try(:strip)[0,1200]
      deal.company = page.at_css("#CompanyName").try(:text).try(:strip)
    #TODO: O método consegue setar city_id da oferta, mas não consegue exibir corretamente já na tela de cadastro de nova oferta
      deal.city = City.find_by_name(page.at_css("#city_name").try(:text).try(:strip)).first
      if deal.city
        deal.city_id = deal.city.id
      end
    end
    deal.kind = Deal::KIND_DAILY_DEAL
  end

  def self.populate_pontofrio_deal(deal)
    page = open_page(deal.link)

    deal.title = page.at_css(".produtoNome").try(:text).try(:strip)
    deal.price_mask = page.at_css(".sale").try(:text).try(:strip)[7..-1].try(:strip)
    deal.real_price_mask = page.at_css(".regular").try(:text).try(:strip)[6..-1].try(:strip)
    deal.description = page.at_css(".descricao").try(:text).try(:strip)[0,1200]
    deal.category = PONTO_FRIO_CATEGORIES[page.at_css(".selected").try(:text).try(:strip)]
    deal.company = "Ponto Frio"
    #if deal.price
      deal.kind = Deal::KIND_OFFER
    #else
    #  deal.kind = Deal::KIND_ON_SALE
    #end
  end

  def self.populate_submarino_deal(deal)
    page = open_page(deal.link)

    deal.title = page.at_css(XPATH_TITLE).try(:text).try(:strip)
    deal.price_mask = page.at_css(".for").try(:text).try(:strip)[7..-1].try(:strip)
    deal.real_price_mask = page.at_css(".from").try(:text).try(:strip)[6..-1].try(:strip)
    deal.description = page.at_css(".ficheTechnique").try(:text).try(:strip)[0,1200]
    #deal.category = PONTO_FRIO_CATEGORIES[page.at_css(".selected").try(:text).try(:strip)]
    deal.company = "Submarino"
    #if deal.price
      deal.kind = Deal::KIND_OFFER
    #else
    #  deal.kind = Deal::KIND_ON_SALE
    #end
  end
end
