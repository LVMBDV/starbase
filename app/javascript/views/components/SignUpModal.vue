<template>
  <b-modal :active.sync="isActive" :can-cancel="['escape', 'outside']" width="20em">
    <div class="modal-card">
      <header class="modal-card-head">
        <p class="modal-card-title">Sign Up</p>
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
        <p class="is-size-7 mr-6">By signing up, you agree to hire Ata :^)</p>
        <b-button :disabled="!isValid" :loading="signingUp" @click="signUp">Sign Up</b-button>
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
      signingUp: false,
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
      this.message = ""
    },
    validate() {
      this.isValid = [this.$refs.emailInput, this.$refs.passwordInput].every((input) => input?.checkHtml5Validity())
      return this.isValid
    },
    signUp() {
      if (this.isValid) {
        this.signingUp = true
        this.$signUp(this.emailAddress, this.password).then((errors) => {
          if (errors.length > 0) {
            this.$buefy.toast.open({
              message: errors.join(". "),
              type: 'is-danger'
            })
          } else {
            this.$buefy.toast.open({
              message: 'Signed up successfully! Check your inbox for the confirmation link.',
              type: 'is-success'
            })
            this.close()
          }
        }).catch((error) => {
          console.error(error);
        }).finally(() => {
          this.signingUp = false
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
