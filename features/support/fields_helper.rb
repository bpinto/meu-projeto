module Fields

  def get_field(klass, field)
    case klass
    when "deal"
      Fields::DEAL[field]
    end
  end


  DEAL = {
    "description" => "deal_description",
    "link" => "deal_link",
    "price" => "deal_price",
    "title" => "deal_title",
    "type" => "deal_type"
  }
end

World(Fields)
