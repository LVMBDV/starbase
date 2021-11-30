<template>
  <div class="display-row">
    <header class="display-row__header is-flex is-align-items-flex-end">
      <b-tooltip :label="$followTooltip" position="is-bottom" type="is-black" v-if="$isAuthenticated && !!interest">
        <button @click="$toggleFollow" class="card-header-icon is-size-3" aria-label="more options">
          <span class="icon">
            <i class="fa-star" :class="$followIconClass" aria-hidden="true"></i>
          </span>
        </button>
      </b-tooltip>
      <h3 class="is-size-3 is-uppercase">{{ title }}</h3>
      <p class="ml-4 mb-1 is-italic">{{ description }}</p>
    </header>
    <div class="display-row__content is-flex">
      <DisplayCard :value="value" v-for="(value, index) in values" :key="index"></DisplayCard>
    </div>
  </div>
</template>

<script>
import gql from 'graphql-tag'

import DisplayCard from './DisplayCard.vue'
import AuthenticationMixin from '../../mixins/AuthenticationMixin'
import InterestMixin from '../../mixins/InterestMixin'

export default {
  mixins: [AuthenticationMixin, InterestMixin],
  components: {
    DisplayCard
  },
  props: {
    title: String,
    description: String,
    interest: Object,
    values: Array
  }
}
</script>

<style lang="sass" scoped>
.display-row {
  margin-bottom: 5rem;

  &:last-child {
    margin-bottom: 0;
  }

  &__content {
    width: 100%;
    white-space: nowrap;
    overflow-x: auto;

    :first-child {
      margin-left: 0;
    }
  }
}
</style>
