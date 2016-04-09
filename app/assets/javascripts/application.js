// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .

function toggleText() {
  $("#text-button-div").toggleClass("hidden");
  $("#text-button-div").toggleClass("show");
  
  $("#text-form-div").toggleClass("hidden");
  $("#text-form-div").toggleClass("show");
}

$(function() {
  $("#weather-form").on("submit", function(e) {
    e.preventDefault();
    window.location = "/weather/" + $("#weather-zip").val();
  });
  
  $("[data-text-button]").on("click", function(e) {
    toggleText();
  });
  
  $("#text-form").on("submit", function(e) {
    e.preventDefault();
    
    var number = $("#text-number").val();
    if (! number || number.length != 10) {
      alert("Number must be 10 digits and can't include () or -");
      return;
    }
    
    $("#text-submit").attr("disabled", "disabled");
    
    $.ajax({
      type: "POST",
      url: "/weather/send-text",
      data: {
        number: number,
        message: $("#text-message").val()
      }
    })
    .fail(function() {
      alert("The text couldn't be sent. Try again.");
    })
    .done(function() {
      toggleText();
      $("#text-number").val("");
      $("#text-success").addClass("show");
      $("#text-success").removeClass("hidden");
      $("#text-submit").removeAttr("disabled");
    });
  });
  
  $("[data-dismiss-success]").on("click", function(e) {
    $("#text-success").addClass("hidden");
    $("#text-success").removeClass("show");
  });
  
  $("[data-text-cancel]").on("click", function(e) {
    toggleText();
  });
});