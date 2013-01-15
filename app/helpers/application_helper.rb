module ApplicationHelper

  def currency_euro(item)
        number_to_currency(item, :unit => "&euro;", :separator => ",", :delimiter => "", :format => "%n %u")
  end

  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display: none"
    end
    content_tag("div", attributes, &block)
  end
end
