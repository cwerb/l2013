# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready  ->

  check_height = -> $('.next-page-link').click() if 400 > ($(document).height()-$(window).height()-$(document).scrollTop())

  $('.login-button').click((e)->
    e.preventDefault()
    if $('.auth-block').css('display') == 'none'
      $(this).parent().addClass 'this'
      $('.auth-block').css('display', 'block')
    else
      $(this).parent().removeClass 'this'
      $('.auth-block').css('display', 'none')
  )

  check_height()
  $(window).on('scroll', ->
    check_height()
  )
  $('ul.task-menu > li a').click (e)->
    e.preventDefault()
  $('ul.task-menu > li').click((e)->
    e.preventDefault()
    unless $(this).hasClass('inactive')
      $.getScript($(this).children().first().attr('href')+'.js')
      $('.lavalamp').css('left', ( $(this).position().left - $('ul.task-menu > li').first().position().left + 2))
      $('.tasks-carousel-content').css('left', '-'+$('ul.task-menu > li').index($(this))+'00%')
  )

  $(".auth-block .w-control-close").click ->
    $(".auth-block").hide();

  $('.checkbox').click ->
    if $(this).hasClass 'selection'
      $(this).removeClass 'selection'
      $(this).parent().find('input[type="checkbox"]').attr('checked', false)
    else
      $(this).addClass 'selection'
      $(this).parent().find('input[type="checkbox"]').attr('checked', true)

  $('a.participate').click((e)->
    e.preventDefault()
    $('.auth-block').css('display', 'block')
  )

  $(document).on 'ajax:complete', ->
    $('a.wannalikebutcant').click((e)->
      e.preventDefault()
      $('.overlay').html('')
      $('.overlay').animate({opacity: 0}, 800)
      $('.auth-block').css('display', 'block')
      $('body, html').animate({scrollTop: 0}, 800)
    )