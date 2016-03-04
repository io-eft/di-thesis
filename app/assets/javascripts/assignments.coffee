# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

inputChange = () ->
  $('input:file').on("change", () ->
    $('input:submit').prop('disabled', !$(this).val());
    return
    )

# addDoc = () ->
#   $("new_doc_toggle").on('click', () ->
#     $('#add_new_doc_button').toggle();
#     $('#new_doc').toggle();
#     $('#new_doc_form').trigger('reset');
#     $('#submit_new_doc').prop('disabled', true);
#     return
#     )

$(document).on("page:load ready", inputChange);
# $(document).on("page:load ready", addDoc);
