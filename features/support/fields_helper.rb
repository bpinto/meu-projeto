module Fields

  def get_field(klass, field)
    case klass
    when "deal"
      field_id = Fields::DEAL[field]
    end

    field_id ? field_id : "#{field} not found"
  end


  DEAL = {
    "address" => "deal_address",
    "category" => "deal_category",
    "company" => "deal_company",
    "description" => "deal_description",
    "link" => "deal_link",
    "price" => "deal_price",
    "real_price" => "deal_real_price",
    "title" => "deal_title",
    "kind" => "deal_kind"
  }
end

World(Fields)
