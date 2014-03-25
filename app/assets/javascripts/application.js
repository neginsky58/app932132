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

  $('.circle-row').click(function(){
    var id = $(this).attr('id').substr(7);

  });
});




