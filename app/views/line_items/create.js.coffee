$("#notice").hide()

$("#cart").replaceWith('<div id="cart"><%= escape_javascript(render(:partial => @cart))%></div>')

$("#current_item").fadeToggle()
$("#current_item").fadeToggle()
