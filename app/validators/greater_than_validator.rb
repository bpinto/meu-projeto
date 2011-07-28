class GreaterThanValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if (value <= record.send(options[:with]))
      record.errors[attribute] << (options[:message] || "is not greater than #{options[:with]}")
    end
  end
end
