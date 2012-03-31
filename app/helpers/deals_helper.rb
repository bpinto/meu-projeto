# -*- coding: utf-8 -*-
module DealsHelper
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

  def search_options(selected = nil)
    options_for_select({"Mais Recente" => "most_recent", "Menor Preço" => "lowest_price",
    "Maior Preço" => "highest_price", "Maior Desconto" => "highest_discount"}, selected)
  end

  def search_city_options(selected = nil)
    body = 'Todas'
    body << content_tag(:option, "Todas Cidades", { :value => "" }, true)
    
    City.hash_by_states.each do |group|
      body << content_tag(:optgroup, options_for_select(group[1], selected), :label => group[0])
    end

    body.html_safe
  end

  def truncate_title(title)
    truncate(title, :length => 60)
  end

  def truncate_side_title(title)
    truncate(title, :length => 35)
  end

end
