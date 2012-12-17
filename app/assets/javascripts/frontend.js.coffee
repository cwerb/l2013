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

  $(".auth-block .w-control-close").click ->
    $(".auth-block").hide();

  $('.background').click ->
    alert()
    $('.overlay').html('')