import Vue from 'vue/dist/vue.esm'
import VueCookies from 'vue-cookies-reactive'
import ApolloClient from 'apollo-boost'
import VueApollo from 'vue-apollo'
import Buefy from 'buefy'
import 'buefy/dist/buefy.css'
import '@fortawesome/fontawesome-free/css/all.css'

import App from '../views/App.vue'
import router from '../router'

Vue.use(VueCookies)
Vue.use(VueApollo)
Vue.use(Buefy)

const apolloClient = new ApolloClient({
  uri: isProduction ? 'https://f4881080e5.herokuapp.com/graphql' : 'http://localhost:3000/graphql',
  fetchOptions: {
    credentials: 'same-origin',
  },
  request: (operation) => {
    const csrfToken = document.querySelector('meta[name=csrf-token]').getAttribute('content')
    operation.setContext({
      headers: { "X-CSRF-Token": csrfToken }
    })
  }
})

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: "#app",
    render: h => h(App),
    router,
    apolloProvider: new VueApollo({
      defaultClient: apolloClient
    })
  })
})
