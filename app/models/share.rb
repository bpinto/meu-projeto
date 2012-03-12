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
  COMPRA_FACIL = "comprafacil.com"
  GROUPON = "groupon.com"
  HOTEL_URBANO = "hotelurbano.com.br"
  LEADER = "leader.com.br"
  LIVRARIA_CULTURA = "livrariacultura.com.br"
  MAGAZINE = "magazineluiza.com.br"
  PEIXE_URBANO = "peixeurbano.com"
  PONTO_FRIO = "pontofrio.com"
  SARAIVA = "saraiva.com"
  SUBMARINO = "submarino.com"

  AMERICANAS_CATEGORIES = {
    "AUTOMOTIVO" => Deal::CATEGORY_CAR,
    "BELEZA E SAÚDE" => Deal::CATEGORY_BEAUTY_AND_HEALTH,
    "BEBÊS" => Deal::CATEGORY_KIDS,
    "BRINQUEDOS" => Deal::CATEGORY_KIDS,
    "CAMA, MESA E BANHO" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "CÂMERAS E FILMADORAS" => Deal::CATEGORY_ELECTRONICS,
    "CELULARES E TELEFONES" => Deal::CATEGORY_ELECTRONICS,
    "DVDS E BLU-RAY" => Deal::CATEGORY_CULTURE,
    "ELETRODOMÉSTICOS" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "ELETRÔNICOS" => Deal::CATEGORY_ELECTRONICS,
    "ELETROPORTÁTEIS" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "ESPORTE E LAZER" => Deal::CATEGORY_FITNESS,
    "FERRAMENTAS E JARDIM" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "INFORMÁTICA" => Deal::CATEGORY_COMPUTER,
    "LIVROS" => Deal::CATEGORY_CULTURE,
    "MÓVEIS E DECORAÇÃo" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "UTILIDADES DOMÉSTICAS" => Deal::CATEGORY_HOME_AND_APPLIANCE  
  }

  COMPRAFACIL_CATEGORIES = {
    "Ar & Ventilação" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Automotivos" => Deal::CATEGORY_CAR,
    "Brinquedos" => Deal::CATEGORY_KIDS,
    "Bebês" => Deal::CATEGORY_KIDS,
    "Cama & Banho" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Celulares" => Deal::CATEGORY_ELECTRONICS,
    "Cine & Foto" => Deal::CATEGORY_ELECTRONICS,
    "Colchões" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Computadores" => Deal::CATEGORY_COMPUTER,
    "Eletrodomésticos" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Eletrônicos" => Deal::CATEGORY_ELECTRONICS,
    "Eletroportáteis" => Deal::CATEGORY_ELECTRONICS,
    "Esportes & Lazer" => Deal::CATEGORY_FITNESS,
    "Ferramentas" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Fitness" => Deal::CATEGORY_FITNESS,
    "Games" => Deal::CATEGORY_KIDS,
    "Home Center" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Industriais" => Deal::CATEGORY_OTHER,
    "Informática" => Deal::CATEGORY_COMPUTER,
    "Malas" => Deal::CATEGORY_OTHER,
    "Móveis & Estofados" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Perfumes" => Deal::CATEGORY_BEAUTY_AND_HEALTH,
    "Relógios" => Deal::CATEGORY_OTHER,
    "Saúde & Beleza" => Deal::CATEGORY_BEAUTY_AND_HEALTH,
    "Telefonia" => Deal::CATEGORY_ELECTRONICS,
    "Tênis" => Deal::CATEGORY_BEAUTY_AND_HEALTH,
    "U. Domésticas" => Deal::CATEGORY_HOME_AND_APPLIANCE
  }

  LEADER_CATEGORIES = {
    "Bebês" => Deal::CATEGORY_KIDS,
    "Beleza & Saúde" => Deal::CATEGORY_BEAUTY_AND_HEALTH,
    "Brinquedos" => Deal::CATEGORY_KIDS,
    "Calçados e Acessórios" => Deal::CATEGORY_CLOTHES,
    "Cama, Mesa e Banho" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Cine e Foto" => Deal::CATEGORY_ELECTRONICS,
    "Eletrodomésticos" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Eletrônicos" => Deal::CATEGORY_ELECTRONICS,
    "Esporte e Lazer" => Deal::CATEGORY_FITNESS,
    "Eletroportáteis" => Deal::CATEGORY_ELECTRONICS,
    "Games" => Deal::CATEGORY_KIDS,
    "Informática" => Deal::CATEGORY_COMPUTER,
    "Moda" => Deal::CATEGORY_CLOTHES,
    "Mode Íntima" => Deal::CATEGORY_CLOTHES,
    "Móveis" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Relógios" => Deal::CATEGORY_OTHER,
    "Telefonia" => Deal::CATEGORY_ELECTRONICS,
    "Utilidades Domésticas" => Deal::CATEGORY_HOME_AND_APPLIANCE
  }

  MAGAZINE_CATEGORIES = {
    "Automotivo" => Deal::CATEGORY_CAR,
    "Bebês" => Deal::CATEGORY_KIDS,
    "Beleza e Saúde" => Deal::CATEGORY_BEAUTY_AND_HEALTH,
    "Brinquedos" => Deal::CATEGORY_KIDS,
    "Cama, Mesa e Banho" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Casa e Jardim" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Celulares e Telefones" => Deal::CATEGORY_ELECTRONICS,
    "Cine e Foto" => Deal::CATEGORY_ELECTRONICS,
    "Eletrodomésticos" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Eletrônicos" => Deal::CATEGORY_ELECTRONICS,
    "Eletroportáteis" => Deal::CATEGORY_ELECTRONICS,
    "Esporte e Lazer" => Deal::CATEGORY_FITNESS,
    "Ferramentas e Segurança" => Deal::CATEGORY_OTHER,
    "Informática" => Deal::CATEGORY_COMPUTER,
    "Informática Acessórios" => Deal::CATEGORY_COMPUTER,
    "Instrumentos Musicais" => Deal::CATEGORY_OTHER,
    "Móveis" => Deal::CATEGORY_HOME_AND_APPLIANCE,
    "Perfumaria e Cosméticos" => Deal::CATEGORY_BEAUTY_AND_HEALTH,
    "Relógios" => Deal::CATEGORY_OTHER,
    "Utilidades Domésticas" => Deal::CATEGORY_HOME_AND_APPLIANCE
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
      elsif @deal.link.match(COMPRA_FACIL)
        populate_comprafacil_deal(@deal)
      elsif @deal.link.match(GROUPON)
        populate_groupon_deal(@deal)
      elsif @deal.link.match(HOTEL_URBANO)
        populate_hotelurbano_deal(@deal)
      elsif @deal.link.match(LEADER)
        populate_leader_deal(@deal)
      elsif @deal.link.match(MAGAZINE)
        populate_magazine_deal(@deal)
      elsif @deal.link.match(PEIXE_URBANO)
        populate_peixeurbano_deal(@deal)
      elsif @deal.link.match(PONTO_FRIO)
        populate_pontofrio_deal(@deal)
      elsif @deal.link.match(SARAIVA)
        populate_saraiva_deal(@deal)
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

    deal.title = page.at_css(XPATH_TITLE).try(:text).try(:strip)[0,255]
    
  end

  def self.populate_americanas_deal(deal)
    page = open_page(deal.link)

    deal.title = page.at_css(XPATH_TITLE).try(:text).try(:strip)[0,255]
    if page.at_css(".sale").try(:text) && page.at_css(".infoProdBox").try(:text) && page.at_css(".category").try(:text)
      deal.price_mask = page.at_css(".sale").try(:text).try(:strip)[7..-1].try(:strip)
      deal.real_price_mask = page.at_css(".regular").try(:text).try(:strip)[6..-1].try(:strip)
      deal.description = page.at_css(".infoProdBox").try(:text).try(:strip)[0,1200]
      deal.category = AMERICANAS_CATEGORIES[page.at_css(".category").try(:text).try(:strip).sub(">","")]
      deal.image_url = page.at_css("#imgProduto")["src"].try(:strip)
    end
    deal.company = "Americanas"
    #if deal.price
      deal.kind = Deal::KIND_OFFER
    #else
    #  deal.kind = Deal::KIND_ON_SALE
    #end
  end

  def self.populate_comprafacil_deal(deal)
    page = open_page(deal.link)

    
    if page.at_css(".produto-titulo").try(:text) && page.at_css(".produto-de").try(:text) && page.at_css("#produto-caracteristicas").try(:text)
      deal.title = page.at_css(".produto-titulo").try(:text).try(:strip)[0,255]
      deal.price_mask = page.at_css(".produto-por").try(:text).try(:strip)[7..-1].try(:strip)
      deal.real_price_mask = page.at_css(".produto-de").try(:text).try(:strip)[6..-1].try(:strip)
      deal.description = page.at_css("#produto-caracteristicas").try(:text).try(:strip)[0,1200]
      deal.category = COMPRAFACIL_CATEGORIES[page.at_css("#breadCrumb").at_xpath(".//ul/li/a").try(:text).try(:strip)]
      deal.image_url = page.at_css(".imagens-maisInfo").at_xpath(".//img")[:src].try(:strip)
    end
    deal.company = "Compra Fácil"
    #if deal.price
      deal.kind = Deal::KIND_OFFER
    #else
    #  deal.kind = Deal::KIND_ON_SALE
    #end
  end

  def self.populate_groupon_deal(deal)
    page = open_page(deal.link)

    deal.title = page.at_css("#contentDealTitle").try(:text).try(:strip)[0,255]
    deal.price_mask = page.at_css(".noWrap").try(:text).try(:strip)[3..-1].try(:strip)
    #deal.real_price_mask = page.at_css(".regular").try(:text).try(:strip)[6..-1].try(:strip)
    deal.description = page.at_css(".contentDealDescriptionFacts").try(:text).try(:strip)[0,1200]
    deal.company = "Groupon"
    deal.image_url = page.at_css(".nobg").at_xpath(".//img")[:src].try(:strip)
    #TODO: O método consegue setar city_id da oferta, mas não consegue exibir corretamente já na tela de cadastro de nova oferta
    #deal.city = City.find_by_name(page.at_css("#headerCityButton").try(:text).try(:strip))
    #if deal.city
    #  deal.city_id = deal.city.id
    #end
    deal.kind = Deal::KIND_DAILY_DEAL
  end

  def self.populate_hotelurbano_deal(deal)
    page = open_page(deal.link)

    if page.at_css("title").try(:text) && page.at_css("#{preco-oferta}").try(:text) && page.at_css("#que-saber").try(:text)
      deal.title = page.at_css("title").try(:text).try(:strip)[0,255]
      precos = page.at_css("#preco-oferta").try(:text).try(:strip).split("R$").map(&:strip)
      deal.price_mask = precos[2]
      deal.real_price_mask = precos[1]
      deal.description = page.at_css("#que-saber").try(:text).try(:strip)[0,1200]
      deal.category = Deal::CATEGORY_TRAVEL
      deal.company = "Hotel Urbano"
      deal.image_url = page.at_css("#imagem-oferta").at_xpath(".//img")[:src].try(:strip)
    #  #TODO: O método consegue setar city_id da oferta, mas não consegue exibir corretamente já na tela de cadastro de nova oferta
    #  deal.city = City.find_by_name(page.at_css("#headerCityButton").try(:text).try(:strip))
    #  if deal.city
    #    deal.city_id = deal.city.id
    #  end
    end
    deal.kind = Deal::KIND_DAILY_DEAL

    #puts "-"*100
    #puts "INICIO DA BUSCA NA PAGINA"
    #puts "-"*100
    #puts "TITULO = " + page.at_css("title").try(:text).try(:strip)
    #puts "PRECO PROMOCIONAL = " + page.at_css("#preco-oferta").try(:text).try(:strip).split("R$").map(&:strip)
    #puts "PRECO REAL = " + page.at_css("#preco-oferta").try(:text).try(:strip).split("R$").map(&:strip)
    #puts "DESCRICAO = " + page.at_css("#que-saber").try(:text).try(:strip)[0,1200]
    ##puts "CATEGORIA = " + MAGAZINE_CATEGORIES[page.at_css("#breadCrumb").try(:text).try(:strip).split("›").map(&:strip)[1].chop].to_s
    #puts "LINK DA IMAGEM = " + page.at_css("#imagem-oferta").at_xpath(".//img")[:src].try(:strip)
    #puts "-"*100
    #puts "FIM DA BUSCA NA PAGINA"
    #puts "-"*100
  end

  def self.populate_leader_deal(deal)
    page = open_page(deal.link)

    
    if page.at_css(".name").try(:text) && page.at_css(".sale").try(:text) && page.at_css("#descricao").try(:text)
      deal.title = page.at_css(".name").try(:text).try(:strip)[0,255]
      deal.price_mask = page.at_css(".sale").try(:text).try(:strip)[7..-1].try(:strip)
      deal.real_price_mask = page.at_css(".regular").try(:text).try(:strip)[6..-1].try(:strip)
      deal.description = page.at_css("#descricao").try(:text).try(:strip)[0,1200]
      deal.category = LEADER_CATEGORIES[page.at_css("#ctl00_BreadCrumb_lnkDepartamento").try(:text).try(:strip)]
      deal.image_url = page.at_css(".fotoPrincipal").at_xpath(".//img")[:src].try(:strip)
    end
    deal.company = "Leader"
    #if deal.price
      deal.kind = Deal::KIND_OFFER
    #else
    #  deal.kind = Deal::KIND_ON_SALE
    #end
  end

  def self.populate_magazine_deal(deal)
    page = open_page(deal.link)

    
    if page.at_css(".description").try(:text) && page.at_css(".prodPor").try(:text) && page.at_css("#descricaoProduto").try(:text)
      deal.title = page.at_css(".description").try(:text).try(:strip)[0,255]
      deal.price_mask = page.at_css(".prodPor").try(:text).try(:strip)[7..-1].try(:strip)
      deal.real_price_mask = page.at_css(".prodDe").try(:text).try(:strip)[6..-1].try(:strip)
      deal.description = page.at_css("#descricaoProduto").try(:text).try(:strip)[0,1200]
      deal.category = MAGAZINE_CATEGORIES[page.at_css("#breadCrumb").try(:text).try(:strip).split("›").map(&:strip)[1].chop]
      deal.image_url = page.at_css(".imagem_produto").at_xpath(".//img")[:src].try(:strip)
    end
    deal.company = "Magazine Luiza"
    #if deal.price
      deal.kind = Deal::KIND_OFFER
    #else
    #  deal.kind = Deal::KIND_ON_SALE
    #end
  end

  def self.populate_peixeurbano_deal(deal)
    page = open_page(deal.link)

    deal.title = page.at_css(XPATH_TITLE).try(:text).try(:strip)[0,255]
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
      deal.image_url = page.at_css(".deal_photo").at_xpath(".//img")["src"].try(:strip)
    #TODO: O método consegue setar city_id da oferta, mas não consegue exibir corretamente já na tela de cadastro de nova oferta
    #  deal.city = City.find_by_name(page.at_css("#city_name").try(:text).try(:strip))
    #  if deal.city
    #    deal.city_id = deal.city.id
    #  end
    end
    deal.kind = Deal::KIND_DAILY_DEAL
  end

  def self.populate_pontofrio_deal(deal)
    page = open_page(deal.link)

    if page.at_css(".sale").try(:text) && page.at_css(".produtoNome").try(:text) && page.at_css(".descricao").try(:text) && page.at_css(".selected").try(:text)
      deal.title = page.at_css(".produtoNome").try(:text).try(:strip)[0,255]
      deal.price_mask = page.at_css(".sale").try(:text).try(:strip)[7..-1].try(:strip)
      deal.real_price_mask = page.at_css(".regular").try(:text).try(:strip)[6..-1].try(:strip)
      deal.description = page.at_css(".descricao").try(:text).try(:strip)[0,1200]
      deal.category = PONTO_FRIO_CATEGORIES[page.at_css(".selected").try(:text).try(:strip)]
      deal.image_url = page.at_css("#divFullImage").at_xpath(".//img")["src"].try(:strip)
    end
    deal.company = "Ponto Frio"
    #if deal.price
      deal.kind = Deal::KIND_OFFER
    #else
    #  deal.kind = Deal::KIND_ON_SALE
    #end
  end

  def self.populate_saraiva_deal(deal)
    page = open_page(deal.link)

    
    if page.at_css("#tituloprod").try(:text) && page.at_css(".precoDe").try(:text) && page.at_css("#PassosConteudo").try(:text)
      deal.title = page.at_css("#tituloprod").try(:text).try(:strip)[0,255]
      deal.price_mask = page.at_css(".precoPor").try(:text).try(:strip)[6..-1].try(:strip)
      deal.real_price_mask = page.at_css(".precoDe").try(:text).try(:strip)[5..-1].try(:strip)
      deal.description = page.at_css("#PassosConteudo").try(:text).try(:strip)[0,1200]
      #deal.category = PONTO_FRIO_CATEGORIES[page.at_css(".selected").try(:text).try(:strip)]
      deal.image_url = page.at_css("#imgProd")[:src].try(:strip)
    end
    
    deal.company = "Saraiva"
    #if deal.price
      deal.kind = Deal::KIND_OFFER
    #else
    #  deal.kind = Deal::KIND_ON_SALE
    #end
  end

  def self.populate_submarino_deal(deal)
    page = open_page(deal.link)

    deal.title = page.at_css(XPATH_TITLE).try(:text).try(:strip)[0,255]
    if page.at_css(".for").try(:text) && page.at_css(".ficheTechnique").try(:text)
      deal.price_mask = page.at_css(".for").try(:text).try(:strip)[7..-1].try(:strip)
      deal.real_price_mask = page.at_css(".from").try(:text).try(:strip)[6..-1].try(:strip)
      deal.description = page.at_css(".ficheTechnique").try(:text).try(:strip)[0,1200]
      #deal.category = PONTO_FRIO_CATEGORIES[page.at_css(".selected").try(:text).try(:strip)]
      deal.image_url = page.at_css("#baseImg")[:src].try(:strip)
    end
    deal.company = "Submarino"
    #if deal.price
      deal.kind = Deal::KIND_OFFER
    #else
    #  deal.kind = Deal::KIND_ON_SALE
    #end
  end  

  private

  def self.drop_product_name_from_breadcrumb(breadcrumb, char)
    new_breadcrumb = ""
    breadcrumb.each_char do |c|
      if c == char
        return new_breadcrumb.try(:strip)
      else
        new_breadcrumb = new_breadcrumb + c
      end
    end
    new_breadcrumb.strip
  end
end
