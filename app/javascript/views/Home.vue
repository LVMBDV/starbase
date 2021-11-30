<template>
  <div>
    <DisplayRow title="Recommended" description="You might enjoy these" :values="recommendedMovies" v-if="$isAuthenticated"/>
    <DisplayRow :interest="{ id: genre.id, kind: 'GENRE' }" :title="genre.title" :description="genre.description" :values="genre.movies.nodes" v-for="genre in genres" :key="genre.id"/>
  </div>
</template>

<script>
import gql from 'graphql-tag'

import AuthenticationMixin from '../mixins/AuthenticationMixin'
import DisplayRow from './components/DisplayRow.vue'

export default {
  mixins: [AuthenticationMixin],
  components: {
    DisplayRow
  },
  apollo: {
    recommendedMovies: {
      query: gql`
        query recommendedMovies {
          recommendedMovies {
            id
            originalTitle
            description
          }
        }`,
        skip() {
          return !this.$isAuthenticated
        }
    },
    genres: {
      query: gql`
        query genres {
          genres {
            id
            title
            description
            movies(first: 10) {
              nodes {
                id
                originalTitle
                description
              }
            }
          }
        }`,
    },
  },
}
</script>
