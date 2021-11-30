<template>
  <div>
    <header class="is-flex is-align-items-flex-end mb-4">
      <b-tooltip :label="$followTooltip" position="is-bottom" type="is-black" v-if="$isAuthenticated">
        <button @click="$toggleFollow" class="card-header-icon is-size-3" aria-label="more options">
          <span class="icon">
            <i class="fa-star" :class="$followIconClass" aria-hidden="true"></i>
          </span>
        </button>
      </b-tooltip>
      <h3 class="is-flex-grow-1 is-size-3 is-uppercase">{{ title }}</h3>
      <b-pagination :total="totalCount" :current="currentPage" :per-page="pageSize">
        <template #default="props">
          <b-pagination-button :page="props.page" tag="router-link" :to="`/genres/${$route.params.title}/page/${props.page.number}`">
            {{ props.page.number }}
          </b-pagination-button>
        </template>
        <template #previous>
        </template>
        <template #next>
        </template>
      </b-pagination>
    </header>
    <div class="is-flex is-flex-wrap-wrap is-justify-content-center">
      <DisplayCard :value="movie" v-for="movie in movies" :key="movie.id"/>
    </div>
  </div>
</template>

<script>
import gql from 'graphql-tag'

import DisplayCard from './components/DisplayCard.vue'
import AuthenticationMixin from '../mixins/AuthenticationMixin'
import InterestMixin from '../mixins/InterestMixin'

export default {
  mixins: [AuthenticationMixin, InterestMixin],
  data() {
    return {
      pageSize: 12
    }
  },
  components: {
    DisplayCard
  },
  computed: {
    genre() {
      return this.searchGenre
    },
    title() {
      return this.genre?.title || "UNKNOWN"
    },
    interest() {
      return {
        id: this.genre?.id,
        kind: 'GENRE'
      }
    },
    movies() {
      return this.genre?.movies.nodes || []
    },
    currentPage() {
      return parseInt(this.$route.params.page) || 1
    },
    hasPreviousPage() {
      return this.currentPage > 1
    },
    hasNextPage() {
      return this.searchGenre?.movies?.pageInfo?.hasNextPage
    },
    totalCount() {
      return this.searchGenre?.movies?.totalCount || 0
    },
  },
  apollo: {
    searchGenre: {
      query: gql`
        query searchGenre($title: String!, $first: Int!, $pageSize: Int!) {
          searchGenre(query: $title) {
            id
            title
            description
            movies(first: $first, last: $pageSize) {
              totalCount
              nodes {
                id
                originalTitle
                description
              }
              pageInfo {
                hasNextPage
              }
            }
          }
        }`,
      variables() {
        return { title: this.$route.params.title, first: this.pageSize * (this.currentPage), pageSize: this.pageSize }
      }
    }
  }
}
</script>

<style>

</style>
