$(document).ready(function() {
  $("#home .slider").extraSlider({
    'type': 'fade',
    'auto': 5,
    'navigate': false,
    'onInit': moveLoader,
    'onMoveStart': moveLoader
  });

  function moveLoader(currentItem, total, slider) {
      autoTween = TweenMax.fromTo(slider.find('.loader'), 5, {width: 0}, {width: "100%"});
      autoTween = TweenMax.fromTo(slider.find('.wrapperTxt'), 1, {right: '-100%'}, {right: '0'});
  }
});
