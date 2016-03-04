# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

inputChange = () ->
  $('input:file').on("change", () ->
    $('input:submit').prop('disabled', !$(this).val());
    return
    )

$(document).on("page:load ready", inputChange);
