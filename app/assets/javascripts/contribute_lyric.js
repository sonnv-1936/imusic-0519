$(document).on('turbolinks:load', function () {
  $(document).on('click', '#show_contribute_lyric_form', function () {
    $('#contribute_lyric_form').show();
    $(`#submit_lyric`).removeAttr('disabled');
    $(this).hide();
  });

  $(document).on('click', '#cancel_contribute_lyric', function () {
    $('#contribute_lyric_form').hide();
    $('#show_contribute_lyric_form').show();
    $(`#lyric_content`).val('');
  });
});
