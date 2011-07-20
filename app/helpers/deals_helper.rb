# -*- coding: utf-8 -*-
module DealsHelper
  def default_deal(deal)
    html = <<-EOS
      <div class="offer">
        #{link_to(image_tag(deal.image, :alt => deal.title, :class => "offer_img", :width => '200', :height => '150'), deal.link, :rel => "nofollow", :target => '_blank')}
        <div class="offer_text">
          <div class="offer_desc">
            <h2>#{link_to(deal.title, deal.link, :rel => "nofollow", :target => '_blank')}
          </div>

          <h4>
            <strong>Em:</strong>#{deal.kind}<br/>
            <strong>Oferta por:</strong>#{deal.company}
            <a class="offer_mail" href="javascript:void(0);" onclick="box_email(this,343017)"></a>
            <a class="offer_facebook" href="http://www.facebook.com/sharer.php?u=http%3A%2F%2Fwww.clubedodesconto.com.br%2Frio-de-janeiro%2Fpousada-encanto-dos-anjos-buzios-desconto.htm&t=Oferta%20SaveMe" target="_blank"></a>
            <a class="offer_twitter" href="http://twitter.com/?status=@sigasaveme B%C3%BAzios%3A+2+di%C3%A1rias+p%2F+3+pessoas+%2B+caf%C3%A9+da+manh%C3%A3+%2B+pizza+%2B+refrigerante http://www.clubedodesconto.com.br/rio-de-janeiro/pousada-encanto-dos-anjos-buzios-desconto.htm" target="_blank"></a>
          </h4>
        </div>
        <div class="offer_values">
          <div class="offer_value">#{link_to(" R$ <strong>189</strong>,90", deal.link, :rel => "nofollow", :target => '_blank')}</div>
          <div class="offer_real">De:<br/><strong>R$ #{deal.real_price}</strong></div>
          <div class="offer_economy">Economia:<br/><strong>R$ #{deal.economy}</strong></div>
          <div class="offer_time_contador0"></div>
          <div class="offer_go">#{link_to "Ir para o site", deal.link, :rel => "nofollow", :target => "_blank"}</div>
        </div>
      </div>
    EOS
    html.html_safe
  end
end
