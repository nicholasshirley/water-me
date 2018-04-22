/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import TurbolinksAdapter from 'vue-turbolinks';
import Vue from 'vue/dist/vue.esm';
import App from '../app.vue';
import NavBar from '../nav-bar.vue';
import EntryForm from '../forms/entry-form.vue';
import Datepicker from 'vuejs-datepicker';
import Counter from '../forms/counter.vue';
import axios from 'axios';

Vue.use(TurbolinksAdapter)

Vue.component('app', App)
Vue.component('nav-bar', NavBar)
Vue.component('entry-form', EntryForm)
Vue.component('datepicker', Datepicker)
Vue.component('counter', Counter)

document.addEventListener('turbolinks:load', () => {

  axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')

  const app = new Vue({
    el: '[data-behavior="vue"]',
  })
})