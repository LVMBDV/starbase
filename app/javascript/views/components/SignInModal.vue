<template>
  <b-modal :active.sync="isActive" :can-cancel="['escape', 'outside']" width="20em">
    <div class="modal-card">
      <header class="modal-card-head">
        <p class="modal-card-title">Sign In</p>
        <button class="delete" aria-label="close" @click="close(false)"></button>
      </header>
      <section class="modal-card-body">
        <b-field label="Email address">
          <b-input ref="emailInput" v-model="emailAddress" type="email" required @input="validate"></b-input>
        </b-field>
        <b-field label="Password">
          <b-input ref="passwordInput" v-model="password" type="password" required password-reveal @input="validate"></b-input>
        </b-field>
      </section>
      <footer class="modal-card-foot is-justify-content-flex-end">
        <b-button :disabled="!isValid" :loading="signingIn" @click="signIn">Sign In</b-button>
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
      password: "",
      signingIn: false,
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
      this.password = ""
    },
    validate() {
      this.isValid = [this.$refs.emailInput, this.$refs.passwordInput].every((input) => input?.checkHtml5Validity())
      return this.isValid
    },
    signIn() {
      if (this.isValid) {
        this.signingIn = true
        this.$signIn(this.emailAddress, this.password).then((errors) => {
          if (errors.length > 0) {
            this.$buefy.toast.open({
              message: errors.join(". "),
              type: 'is-danger'
            })
          } else {
            this.$buefy.toast.open({
              message: 'Signed in successfully!',
              type: 'is-success'
            })
            this.$emit('signed-in')
            this.close()
          }
        }).catch((error) => {
          console.error(error);
        }).finally(() => {
          this.signingIn = false
        })
      }
    }
  }
}
</script>

<style lang="scss" scoped>
.modal-card {
  width: 100%;
}
</style>
