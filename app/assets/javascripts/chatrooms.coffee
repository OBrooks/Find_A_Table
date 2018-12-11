$(document).on "turbolinks:load", ->

  $(".chatmessages").on "keypress", (e) ->
    if e && e.keyCode == 13
      e.preventDefault()
      $(this).submit()
      console.log("ça enter")
