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

  $('.circle-row').click(function(){
    var id = $(this).attr('id').substr(7);
  });
  var progress_value = 0;
  $('.upload-photo-input').on('change', function(){
    console.log($(this).val());
    $('.upload-photo-progress-bar').show();
    progress_value = 0;
    var progresspump = setInterval(function(){    
      $(".progress-bar").css('width',progress_value+'%');
      if(progress_value>87){
        clearInterval(progresspump);
      }else{
        progress_value = progress_value + 2;
      }
    }, 10);   

    //$('form#new_photo_form').trigger('submit.rails');;  
    var form = $('form#new_photo_form');
    // $.ajax({
    //  type: "POST",
    //  url: form.attr('action'),
    //  contentType: form.attr( "enctype", "multipart/form-data" ),
    //  dataType: "json",
    //  data: form.serialize()  
    //   }).done(function(js_data){
    //    alert(js_data);
    //  });
    $.ajax( {
      url: form.attr('action'),
      type: 'POST',
      data: new FormData( $('form#new_photo_form')[0] ),
      processData: false,
      contentType: false
    });



  });

 
});



