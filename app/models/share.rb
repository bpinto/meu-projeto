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
end
