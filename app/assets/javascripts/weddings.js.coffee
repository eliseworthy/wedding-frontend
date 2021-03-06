# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination .next_page').attr('href')
      if url &&  $(window).scrollTop() > $(document).height() - $(window).height() - 450
        $('.pagination').text(' ')
        $.getScript(url)
    $(window).scroll()

  $('.search-box-list').imagesLoaded ->
    $('.search-box-list').masonry ->
      ({
        itemSelector : '.pin-box',
        columnWidth : 220,
        isAnimated: true
      })
  $('.heart').click ->
    $(this).parent().next('form').slideToggle ->
      $('.search-box-list').masonry()
    false

  $('.show-details').children('a').click ->
    $(this).parent().parent().children('.details').slideToggle ->
      $('.search-box-list').masonry()
    false

  $('.wed-heart').click ->
    $(this).parent().parent().children().next('.add-from-wed').slideToggle ->
      $('.search-box-list').masonry()
    false

  $('.bottom-bar').children('a').click ->
    $(this).parent().next('.wedding-details').slideToggle ->
    false

  $('#sign-up').children().click ->
    $('#login-form').hide()
    $('#form').slideToggle ->
    false

  $('#reg-link').children('a').click ->
    $('#login-form').hide()
    $('#form').slideToggle ->
    false

  $('#login').click ->
    $('#login-form').show()
    $('#form').hide()

  $('#register').click ->
    $('#login-form').hide()
    $('#form').show()


