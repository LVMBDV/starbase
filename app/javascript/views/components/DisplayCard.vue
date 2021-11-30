<template>
  <div class="display-card card is-flex-grow-0 is-flex-shrink-0">
    <header class="card-header">
      <p class="card-header-title">{{ title }}</p>
      <b-tooltip :label="$followTooltip" position="is-left" type="is-black" v-if="$isAuthenticated">
        <button @click="$toggleFollow" class="card-header-icon" aria-label="more options">
          <span class="icon">
            <i class="fa-star" :class="$followIconClass" aria-hidden="true"></i>
          </span>
        </button>
      </b-tooltip>
    </header>
    <div class="card-image">
      <figure class="image" :class="imageClass">
        <img :src="imageURL" alt="placeholder image"/>
      </figure>
    </div>
    <div class="card-content">
      <div class="content">
        {{ description }}
      </div>
    </div>
  </div>
</template>

<script>
import gql from 'graphql-tag'

import AuthenticationMixin from '../../mixins/AuthenticationMixin'
import InterestMixin from '../../mixins/InterestMixin'

export default {
  props: {
    value: {
      type: Object,
      required: true
    }
  },
  mixins: [AuthenticationMixin, InterestMixin],
  computed: {
    isMovie() {
      return this.value.__typename === 'Movie'
    },
    isStar() {
      return this.value.__typename === 'Star'
    },
    interest() {
      return {
        id: this.value.id,
        kind: this.value.__typename === 'Movie' ? 'MOVIE' : 'STAR'
      }
    },
    title() {
      if (this.isMovie) {
        return this.value.originalTitle
      } else if (this.isStar) {
        return this.value.fullName
      }
    },
    description() {
      if (this.isMovie) {
        return this.value.description
      } else if (this.isStar) {
        return this.value.biography.substring(0, 280) + '...'
      }
    },
    imageClass() {
      if (this.isMovie) {
        return "is-16by9"
      } else if (this.isStar) {
        return "is-square"
      }
    },
    imageURL() {
      if (this.isMovie) {
        return `https://picsum.photos/seed/${this.title.replace(/\?|\&/g, "")}/320/180/`
      } else if (this.isStar) {
        return `https://picsum.photos/seed/${this.title.replace(/\?|\&/g, "")}/400/400/`
      }
    },
  }
}
</script>

<style lang="scss" scoped>
.display-card {
  flex-basis: 400px;
  margin: 1rem;

  .card-header-icon i {
    transition: all 500ms ease-in-out;

    &.fas {
      transform: rotate(360deg);
    }
  }

  .card-content {
    white-space: break-spaces;
  }
}
</style>
