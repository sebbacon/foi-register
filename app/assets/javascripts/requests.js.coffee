# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  requestor_id = $ '#request_requestor_attributes_id'
  requestor_email = $ '#request_requestor_attributes_email'
  
  $('#request_requestor_attributes_name').autocomplete({
    source: "/ajax/requestors"
  }).bind("autocompletefocus", (event, ui) ->
    requestor_email.val ui.item.email
  ).bind("autocompleteselect", (event, ui) ->
    requestor_email.attr("disabled", true).val(ui.item.email)
    requestor_id.val ui.item.id
  ).bind("change", (event) ->
    if requestor_id.val()
      requestor_id.val("")
      requestor_email.removeAttr("disabled").val("")
  )
  
  lgcs_term_id = $ '#request_lgcs_term_id'
  lgcs_term = $ '#request_lgcs_term'
  
  lgcs_term.autocomplete({
    source: "/ajax/lgcs_terms"
  })
  .bind "autocompleteselect", (event, ui) ->
    lgcs_term_id.val ui.item.id
    lgcs_term.blur()
  .bind "focus", (event) ->
    lgcs_term.val ""
    lgcs_term_id.val ""
  .bind "blur", (event) ->
    lgcs_term.val("") if !lgcs_term_id.val()

  $('span.state').tooltip()
