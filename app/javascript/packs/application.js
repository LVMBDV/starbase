import Vue from 'vue/dist/vue.esm'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'

import App from '../views/App.vue'
import router from '../router'

Vue.use(ElementUI)

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: "#app",
    render: h => h(App),
    router
  })
})
