<template>
  <div>
    <Navbar></Navbar>
    <main class="p-4">
      <router-view></router-view>
    </main>
  </div>
</template>

<script>
import gql from 'graphql-tag'

import Navbar from './components/Navbar.vue'

export default {
  components: {
    Navbar
  },
}
</script>
