# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#preview-tab').click ->
    $('#preview').html('Loading...')
    $.ajax
      async:     true
      type:      "POST"
      url:       '/weekly_reports/preview'
      data:      { 'content' : $('#weekly_report_content').val()}
      dataType:  "html"
      success:   (data, status, xhr)   -> $('#preview').html(data)
      error:     (xhr,  status, error) -> alert status
