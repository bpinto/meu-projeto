module Fields

  def get_field(klass, field)
    case klass
    when "deal"
      field_id = Fields::DEAL[field]
    when "user"
      field_id = Fields::USER[field]
    when "comment"
      field_id = Fields::COMMENT[field]
    end

    field_id ? field_id : "#{field} not found on #{__FILE__}"
  end

  USER = {
    "name" => "user_name",
    "email" => "user_email",
    "login" => "user_login",
    "password" => "user_password",
    "password confirmation" => "user_password_confirmation",
    "username" => "user_username"
  }

  DEAL = {
    "address" => "deal_address",
    "category" => "deal_category",
    "city" => "deal_city_id",
    "company" => "deal_company",
    "description" => "deal_description",
    "discount" => "deal_discount",
    "link" => "deal_link",
    "price" => "deal_price",
    "price_mask" => "deal_price_mask",
    "real_price" => "deal_real_price",
    "real_price_mask" => "deal_real_price_mask",
    "title" => "deal_title",
    "kind" => "deal_kind",
    "user" => "deal_user"
  }

  COMMENT = {
    "comment" => "comment_comment"
  }
end

World(Fields)
