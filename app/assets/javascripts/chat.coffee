$(document).on "turbolinks:load", ->

  $("#new_usersmessage_body").on "keypress", (e) ->
    if e && e.keyCode == 13
      e.preventDefault()
      console.log(this.form)
      $(this).form[0].submit()
      console.log("ça enter")
      
