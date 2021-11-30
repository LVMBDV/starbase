<template>
  <div>
    <header>
      <b-input v-model="query" placeholder="Search for a star" class="mx-4 mb-5">
      </b-input>
    </header>
    <div class="is-flex is-flex-wrap-wrap is-justify-content-center">
      <DisplayCard :value="star" v-for="star in searchStars" :key="star.id"/>
      <div class="has-text-grey is-italic" v-if="starCount === 0">No stars found</div>
    </div>
  </div>
</template>

<script>
import gql from 'graphql-tag'

import DisplayCard from './components/DisplayCard.vue'

export default {
  components: {
    DisplayCard
  },
  data() {
    return {
      query: ""
    }
  },
  computed: {
    starCount() {
      return this.searchStars?.length || 0
    }
  },
  apollo: {
    searchStars: {
      query: gql`
        query searchStars($name: String!) {
          searchStars(name: $name) {
            id,
            fullName
            biography
          }
        }`,
      variables() {
        return { name: this.query }
      }
    }
  }
}
</script>

<style>

</style>
