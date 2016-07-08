$ ->
  $(document).on 'change', '#cities_select', (evt) ->
    $.ajax 'update_districts',
      type: 'GET'
      dataType: 'script'
      data: {
        parent_id: $("#cities_select option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic city select OK!")