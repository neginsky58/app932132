// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs

//= require bootstrap

//= require underscore
//= require gmaps/google

// require handlebars
// require ember
// require ember-data

//= require_self
// require binbuds
//= require_tree .
$(document).ready(function() {

  $("#new_favorite").bind('ajax:success', function(xhr, data, status) {
    console.log('ajax:success');
    console.log(xhr);
    content = '<tr><td>'+data.category+'</td><td>'+data.person_type+'</td><td>'
    content = content + data.size+'</td><td>'+data.search_word+'</td><td>'
    content = content + '<input class="checkbox" type="checkbox" name="favorite[id_' +data.id+']\"/></td></tr>';
    $('.block-attribute-list table tbody').append(content);
  });
  $("#delete_favorite_form").bind('ajax:success', function(xhr, data, status){
    console.log('deleted favorites');

    $('input[type="checkbox"]').each(function(){
      var par = $(this).parent().parent();
      if(this.checked)
        par.remove();      
    });
  });
  
  $("#delete_users_form").bind('ajax:success', function(xhr, data, status){
    
    $('input[type="checkbox"]').each(function(){
      var par = $(this).parent().parent();
      if(this.checked)
        par.remove();      
    });
  });

  $("#new_photo_form").bind('ajax:success', function(xhr, data, status){
    console.log(data);    
    $(".progress-bar").css('width','100%');
    $(".progress-bar").hide();

  });
  
  var progress_value = 0;
  $('.upload-photo-input').on('change', function(){
    console.log($(this).val());

    progress_value = 1;
    $(".progress-bar").css('width',progress_value+'%');
    $('.upload-photo-progress-bar').show();
    
    var progresspump = setInterval(function(){    
      $(".progress-bar").css('width',progress_value+'%');
      if(progress_value>87){
        clearInterval(progresspump);
      }else{
        progress_value = progress_value + 8;
      }
    }, 5);   

    var form = $('form#new_photo_form');

    var eleProgressBar = $(".progress-bar");
    var eleProgressBarBlock = $(".upload-photo-progress-bar");

    var sel_thumb = $('input#sel_thumbnail').val();
    var elePhotoId = "thumb_photo_id_" + sel_thumb;
    var thumbnail_img = ".thumbnail"+sel_thumb+" img";

    $.ajax( {
      url: form.attr('action'),
      type: 'POST',
      data: new FormData( $('form#new_photo_form')[0] ),
      processData: false,
      contentType: false,
      complete: function(data){
        eleProgressBar.css('width','100%');
        eleProgressBarBlock.hide();
        eleProgressBar.css('width','1%');

        if(data.responseJSON.success){          
          $(thumbnail_img).attr('src', data.responseJSON.url);
          $('#'+elePhotoId).val(data.responseJSON.photo_id);          
        } 
        console.log(data.responseJSON.url);
      }
    });

  });

  $('.thumbnail').on('click', function(){
    $('.thumbnail').removeClass('thumbnail-active');
    if($(this).hasClass('thumbnail1')){
      $('input#sel_thumbnail').val('1');
    }
    if($(this).hasClass('thumbnail2')){
      $('input#sel_thumbnail').val('2');
    }
    if($(this).hasClass('thumbnail3')){
      $('input#sel_thumbnail').val('3');
    }
    if($(this).hasClass('thumbnail4')){
      $('input#sel_thumbnail').val('4');
    }
    $(this).addClass('thumbnail-active');    
  });
  
  $('.table-circles .circle-row').on('click', function(){    
    //$('.sel-circle-icon').remove();
    $('.sel-circle-icon').html('<i class="fa fa-circle-o"></i>');    
    //$(this).children('.sel-circle-icon').remove();
    $(this).children('.sel-circle-icon').html('<i class="fa fa-dot-circle-o"></i>');    
    $('#circle_id').val($(this).attr('data-circle-id'));
  });
  $('.item-block .btn-img-preview').on('click', function(){
    var css_thumbnail = ".thumbnail-" + $(this).attr("data-item-id");
    var img_elm = $(css_thumbnail+" img.active");  
    console.log(img_elm.prev('img'));
    if(img_elm.prev('img').length > 0){
      img_elm.removeClass('active');
      img_elm.addClass('inactive');    
      img_elm.prev('img').removeClass('inactive');
      img_elm.prev('img').addClass('active');
    }
  });
  $('.item-block .btn-img-next').on('click', function(){
    var css_thumbnail = ".thumbnail-" + $(this).attr("data-item-id");
    var img_elm = $(css_thumbnail+" img.active"); 
    console.log(img_elm.next('img'));
    if(img_elm.next('img').length > 0){
      img_elm.removeClass('active');
      img_elm.addClass('inactive');
      img_elm.next('img').removeClass('inactive');
      img_elm.next('img').addClass('active');
    }
  });



  $('.btn-set-mine').on('click', function(){        
    var this_elm = $(this)
    $.ajax({
      url: $(this).attr('action'), //sumbits it to the given url of the form      
      dataType: "JSON" // you want a difference between normal and ajax-calls, and json is standard
    }).success(function(json){
      console.log('success');
      this_elm.removeClass('btn-default');
      this_elm.addClass('btn-success');
    });
  });

  

});



