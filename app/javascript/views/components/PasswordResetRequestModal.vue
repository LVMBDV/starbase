<template>
  <b-modal :active.sync="isActive" :can-cancel="['escape', 'outside']" width="20em">
    <div class="modal-card">
      <header class="modal-card-head">
        <p class="modal-card-title">Reset your password</p>
        <button class="delete" aria-label="close" @click="close(false)"></button>
      </header>
      <section class="modal-card-body">
        <b-field label="Email address">
          <b-input ref="emailInput" v-model="emailAddress" type="email" required @input="validate"></b-input>
        </b-field>
      </section>
      <footer class="modal-card-foot is-justify-content-flex-end">
        <b-button :disabled="!isValid" :loading="requesting" @click="resetPassword">Request password reset</b-button>
      </footer>
    </div>
  </b-modal>
</template>

<script>
import gql from 'graphql-tag'

import AuthenticationMixin from '../../mixins/AuthenticationMixin'

export default {
  mixins: [AuthenticationMixin],
  data() {
    return {
      isActive: false,
      isValid: false,
      emailAddress: "",
      requesting: false,
    }
  },
  methods: {
    open() {
      this.isActive = true
      this.$nextTick(() => {
        this.$refs.emailInput.focus()
      })
    },
    close(reset = true) {
      this.isActive = false

      if (reset) {
        this.reset()
      }
    },
    reset() {
      this.emailAddress = ""
    },
    validate() {
      this.isValid = this.$refs.emailInput.checkHtml5Validity()
      return this.isValid
    },
    resetPassword() {
      if (this.isValid) {
        this.resetting = true
        this.$requestPasswordReset(this.emailAddress).then((errors) => {
          if (errors.length > 0) {
            this.$buefy.toast.open({
              message: errors.join(". "),
              type: 'is-danger'
            })
          } else {
            this.$buefy.toast.open({
              message: 'Password reset requested! Check your inbox.',
              type: 'is-success'
            })
            this.close()
          }
        }).catch((error) => {
          console.error(error);
        }).finally(() => {
          this.requesting = false
        })
      }
    }
  },
}
</script>

<style lang="scss" scoped>
.modal-card {
  width: 100%;
}
</style>
