$("#cart").replaceWith('<div id="cart"><%= escape_javascript(render(:partial => @cart))%></div>')

$("#current_item").fadeToggle()
$("#current_item").fadeToggle()

if $("#cart tr").length == 1
  # hide the cart
  $("#cart").hide('slow','swing')
