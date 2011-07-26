# -*- coding: utf-8 -*-
module DealsHelper
  #TODO: O link de ver detalhes ainda não funciona.
  def default_deal(deal, index)
    html = <<-EOS
      <div class="offer">
        #{link_to(image_tag('http://dealwit.me/images/3551-19051120356canvasmenor3.logo.png', :alt => deal.title, :title => deal.title, :class => "offer_img", :width => '200', :height => '150'), deal.link, :rel => "nofollow", :target => '_blank')}
        <div class="offer_text">
          <div class="offer_desc">
            <h2>#{link_to(deal.title, deal.link, :rel => "nofollow", :target => '_blank')}
            <h3>#{deal.address}</h3>
          </div>

          #{link_to(image_tag('http://imagem.zipme.com.br/css/images/ver-detalhes.gif', :alt => 'Ver detalhes', :title => deal.title), user_deal_path(:id => deal.id, :user_id => deal.user_id), :class => 'link-detalhes')}
          <h4>
            <strong>Em:</strong> #{I18n.t "models.deal.kind.#{deal.kind}"}<br/>
            <strong>Oferta por:</strong>#{deal.company}
            <a class="offer_mail" href="javascript:void(0);" onclick="box_email(this,343017)"></a>
            <a class="offer_facebook" href="http://www.facebook.com/sharer.php?u=http%3A%2F%2Fwww.clubedodesconto.com.br%2Frio-de-janeiro%2Fpousada-encanto-dos-anjos-buzios-desconto.htm&t=Oferta%20SaveMe" target="_blank"></a>
            <a class="offer_twitter" href="http://twitter.com/?status=@sigasaveme B%C3%BAzios%3A+2+di%C3%A1rias+p%2F+3+pessoas+%2B+caf%C3%A9+da+manh%C3%A3+%2B+pizza+%2B+refrigerante http://www.clubedodesconto.com.br/rio-de-janeiro/pousada-encanto-dos-anjos-buzios-desconto.htm" target="_blank"></a>
          </h4>
        </div>
        <div class="offer_values">
          <div class="offer_value">#{link_to(price_to_currency(deal.price), deal.link, :rel => "nofollow", :target => '_blank')}</div>
          <div class="offer_discount"><strong>#{number_to_percentage(deal.discount_to_percentage, :precision => 0) || "--"}</strong><br/>desconto</div>
          <div class="offer_real">De:<br/><strong>#{number_to_currency(deal.real_price) || "--"}</strong></div>
          <div class="offer_economy">Economia:<br/><strong>#{number_to_currency(deal.discount) || "--"}</strong></div>
          <div class="offer_time contador#{index}" data-time="#{deal.end_date.try(:to_s, :deal)}">Não informado</div>
          <div class="offer_go">#{link_to "Ir para o site", deal.link, :rel => "nofollow", :target => "_blank"}</div>
        </div>
      </div>
    EOS
    html.html_safe
  end

  include ActionView::Helpers::NumberHelper
  def price_to_currency(number, options = {})
    return nil if number.nil?

    options.symbolize_keys!

    defaults  = I18n.translate(:'number.format', :locale => options[:locale], :default => {})
    currency  = I18n.translate(:'number.currency.format', :locale => options[:locale], :default => {})

    defaults  = DEFAULT_CURRENCY_VALUES.merge(defaults).merge!(currency)
    defaults[:negative_format] = "-" + options[:format] if options[:format]
    options   = defaults.merge!(options)

    unit      = options.delete(:unit)
    format    = options.delete(:format)

    if number.to_f < 0
      format = options.delete(:negative_format)
      number = number.respond_to?("abs") ? number.abs : number.sub(/^-/, '')
    end

    begin
      value = number_with_precision(number, options.merge(:raise => true))
      integer = value.split(defaults[:separator])[0]
      decimal = value.split(defaults[:separator])[1]

      format.gsub(/%n/, "<strong>#{integer}</strong>#{defaults[:separator]}#{decimal}").gsub(/%u/, unit).html_safe
    rescue InvalidNumberError => e
      if options[:raise]
        raise
      else
        formatted_number = format.gsub(/%n/, e.number).gsub(/%u/, unit)
        e.number.to_s.html_safe? ? formatted_number.html_safe : formatted_number
      end
    end
  end
end
