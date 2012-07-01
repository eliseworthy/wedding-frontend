# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination .next_page').attr('href')
      if url &&  $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $('.pagination').text('Fetching more products...')
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
  $('.search-box form select').change ->
    $(this).parents('form').submit()

$(window).load ->
  $('.search-box-list').masonry

