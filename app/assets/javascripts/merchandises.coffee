$ ->
  $(document).on 'change', '#categories_select', (evt) ->
    $.ajax 'update_subcategories',
      type: 'GET'
      dataType: 'script'
      data: {
        parent_id: $("#categories_select option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic category select OK!")