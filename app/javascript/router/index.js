import Vue from 'vue/dist/vue.esm'
import Router from 'vue-router'

import Home from '../views/Home.vue'
import Stars from '../views/Stars.vue'
import Genre from '../views/Genre.vue'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    { path: '/', name: 'Home', component: Home },
    { path: '/stars', name: 'Stars', component: Stars },
    { path: '/genres/:title', component: Genre },
    { path: '/genres/:title/page/:page', component: Genre }
  ]
})
