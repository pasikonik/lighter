# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

checkStars = (amount) ->
  if amount < 5
    for i in [amount+1..5]
      $("span[data-score='#{i}']").text("☆")
  for i in [1..amount]
    $("span[data-score='#{i}']").text("★")

$ ->
  stars = $("#rate").attr('rated')
  if stars > 0
    checkStars(stars)

  if location.pathname.match(/[0-9]+/) != null
    idVideo = location.pathname.match(/[0-9]+/)[0]
  if idVideo
    $.get "/videos/#{idVideo}/tags", (data) ->
      $(".tm-input").tagsManager
        prefilled: data
        hiddenTagListName: 'tag_list'
  else
    $(".tm-input").tagsManager
      hiddenTagListName: 'tag_list'

  
  # $("span[data-score]").hover ->
  #   for i in [1..5]
  #     $("span[data-score='#{i}']").text("☆")

  # $("span[data-score]").mouseout ->
  #   checkStars(stars)

  $("span[data-score]").on 'click', ->
    index = $(this).data("score")   
    path = location.pathname
    $.ajax
      type: 'POST'
      url: path + '/vote'
      data: $.param(video:
          rate: index)
    checkStars(index)
    $('#score').load(path + " #score");

  $("#comment-button").on 'click', ->    
    setTimeout (->
      $('#comments').load(location.pathname + " #comments")
      $("#comment_comment").val('')
      return
    ), 50

  $(".comment-delete").on 'click', ->
    setTimeout (->
      $('#comments').load(location.pathname + " #comments")
      return
    ), 50

  sort = $('.sort').data('sort')
  if sort
    $("#created_at").removeClass 'active'
    $("##{sort}").addClass 'active'
  type = $('.type').data('type')
  if type
    $("#1").removeClass 'active'
    $("##{type}").addClass 'active'
  tag = $('.tagg').data('tag')
  if tag
    $("##{tag}-tag").addClass 'chosen-tag'


  $("a[href='#local']").click ->
    $("input[name='video[remote]'").val('')

  $("a[href='#remote']").click ->
    $("input[name='video[source]'").val('')

