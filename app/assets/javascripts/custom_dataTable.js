function apply_dataTable(div_id, wrapper_id, table_len, table_filter){

      $(div_id).dataTable({
                  "bFilter": true,
                  "bSort": false,
                  "bInfo": false,
                  "oSearch": {"sSearch": ""},
                  "oLanguage": { "sSearch": "" },
                  "sDom": 'C<"clear">lfrtip',
                  "bAutoWidth": false,
                  "bRetrieve": true
              }
      );

      $(div_id).css({
          'marginTop': '35px'
      });

      $(wrapper_id).css({
         'position':'relative'
      });

      $(wrapper_id).find(table_len).css({
                  'position':'absolute',
                  'left': '0px',
                  'top': '-30px',
                  'width':'230px'
      });

      $(wrapper_id).find(table_filter).css({
          'position':'absolute',
          'right': '-12px',
          'top': '-32px',
          'width':'230px'
      });

      $(wrapper_id).find(table_filter).find('input:text').attr("placeholder", "Search Here");

}