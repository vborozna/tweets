$(function() {
  $(document).on('change', ':file', function() {
    var fileInput = $(this);
    var filename = fileInput.val().split('\\').pop();

    fileInput.parents('.input-group').
              find(':text').
              val(filename);
  });
});

