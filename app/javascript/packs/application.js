// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import $ from 'jquery'
window.$ = $
window.jQuery = $

import 'popper.js'
import 'bootstrap'

// 自作のスタイルを読み込み
import "../stylesheets/application.scss"


Rails.start()
Turbolinks.start()
ActiveStorage.start()
