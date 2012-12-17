# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready  ->
  direction = -1
  position = 0
  carousel = $('.carousel-content')
  carousel_items_count = $('.carousel-block').size()
  carousel_holder_width = $('.ad-carousel').width()
  $(".carousel-block").css('width', carousel_holder_width)
  carousel_width = carousel_holder_width*carousel_items_count
  being_resized = false
  new_position = ->
    carousel.position().left + direction*carousel_holder_width

  window.setInterval( ->
    unless being_resized
      pos = new_position()
      if (direction == -1 and pos < carousel_holder_width - carousel_width) or (direction == 1 and pos > 0)
        direction = -direction
        pos = new_position()
      carousel.css('left', pos+'px')
  , 2500)
  $(window).resize(->
    being_resized = true
    carousel.css('left', '0')
    carousel_holder_width = $('.ad-carousel').width()
    $(".carousel-block").css('width', carousel_holder_width)
    carousel_width = carousel_holder_width*carousel_items_count
    carousel.css('left', '0')
    window.setTimeout(->
      being_resized = false
    ,3000
    )
  )


  $('ul.task-menu > li').hover(->
    $('.lavalamp').css('left', ( $(this).position().left - $('ul.task-menu > li').first().position().left + 2))
    $('.tasks-carousel-content').css('left', $('.tasks-carousel-content > .task').first().position().left - $($('.tasks-carousel-content > .task')[$('ul.task-menu > li').index($(this))]).position().left)
  )
  ajax_loading = false
  ajax_out = false

  check_height = -> $('.next-page-link').click() if 400 > ($(document).height()-$(window).height()-$(document).scrollTop())

  check_height()
  $(window).on('scroll', ->
    check_height()
  )

  $(".auth-block .w-control-close").click ->
    $(".auth-block").hide();