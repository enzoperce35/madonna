// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require hamburger.js
//= require select2_simple_form
//= require select2
//= require_tree .


import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

require("jquery")
import "packs/sales_nested_form.js"

(function($){
  "use strict";
   $(document).on('ready', function(){
       $("#order_place_id").select2({
           allowClear: true,
           theme: "bootstrap"
       });
   });
}(jQuery));
