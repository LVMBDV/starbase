<template>
  <b-navbar fixed-top shadow spaced>
    <template #brand>
       <b-navbar-item tag="router-link" :to="{ path: '/' }" class="mr-4 has-text-weight-bold">
        Starbase
       </b-navbar-item>
    </template>
    <template #start>
      <b-navbar-item tag="router-link" :to="{ path: '/stars' }">
        Stars
      </b-navbar-item>
      <b-navbar-dropdown label="Genres">
        <b-navbar-item tag="router-link" :to="{ path: `/genres/${genre.title.toLowerCase()}` }" v-for="genre in genres" :key="genre.id">
          {{ genre.title }}
        </b-navbar-item>
      </b-navbar-dropdown>
    </template>
    <template #end>
      <UserCard></UserCard>
    </template>
  </b-navbar>
</template>

<script>
import gql from 'graphql-tag'

import UserCard from './UserCard.vue'

export default {
  components: {
    UserCard
  },
  apollo: {
    genres: gql`query {
      genres {
        id
        title
      }
    }`
  }
}
</script>

<style>

</style>
