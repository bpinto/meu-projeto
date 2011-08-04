module Fields

  def get_field(klass, field)
    case klass
    when "deal"
      Fields::DEAL[field]
    end
  end


  DEAL = {
    "address" => "deal_address",
    "description" => "deal_description",
    "link" => "deal_link",
    "price" => "deal_price",
    "title" => "deal_title",
    "kind" => "deal_kind"
  }
end

World(Fields)
