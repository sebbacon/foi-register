# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  id = $ '#request_requestor_attributes_id'
  email = $ '#request_requestor_attributes_email'
  
  $('#request_requestor_attributes_name').autocomplete({
    source: "/ajax/requestors"
  }).bind("autocompletefocus", (event, ui) ->
    email.attr("disabled", true).val(ui.item.email)
    id.val(ui.item.id)
  )

  $('span.state').tooltip()
