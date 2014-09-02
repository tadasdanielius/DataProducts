function _doClick() {
    var $symbol = $('#symbol');
    var $d = $('#symbol_displayed');
    $symbol.val($d.val());
    $symbol.trigger('change');
    return false;
}

function _doLinkClick(s) {
    $('#symbol_displayed').val(s);
    _doClick();
}

$(document).ready(function() {
$('#symbol_displayed').keypress(function (e) {
  if (e.which == 13) {
      _doClick();
  }
});
})