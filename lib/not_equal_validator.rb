class NotEqualValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    other_value = object.send(options[:with])

    if value == other_value
      object.errors[attribute] << (options[:message] || "is equal to #{options[:with]}") 
    end
  end
end
