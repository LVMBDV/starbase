<template>
  <b-modal :active.sync="isActive" :can-cancel="['escape', 'outside']" width="20em">
    <div class="modal-card">
      <header class="modal-card-head">
        <p class="modal-card-title">Reset your password</p>
        <button class="delete" aria-label="close" @click="close(false)"></button>
      </header>
      <section class="modal-card-body">
        <b-field label="Password">
          <b-input ref="passwordInput" v-model="password" type="password" required password-reveal @input="validate"></b-input>
        </b-field>
      </section>
      <footer class="modal-card-foot is-justify-content-flex-end">
        <b-button :disabled="!isValid" :loading="resetting" @click="resetPassword">Reset password</b-button>
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
      password: "",
      token: "",
      resetting: false,
    }
  },
  methods: {
    open() {
      this.isActive = true
      this.$nextTick(() => {
        this.$refs.passwordInput.focus()
      })
    },
    close(reset = true) {
      this.isActive = false

      if (reset) {
        this.reset()
      }
    },
    reset() {
      this.password = ""
    },
    validate() {
      this.isValid = this.$refs.passwordInput.checkHtml5Validity() && !!this.token
      return this.isValid
    },
    resetPassword() {
      if (this.isValid) {
        this.resetting = true
        this.$resetPassword(this.token, this.password).then((errors) => {
          if (errors.length > 0) {
            this.$buefy.toast.open({
              message: errors.join(". "),
              type: 'is-danger'
            })
          } else {
            this.$buefy.toast.open({
              message: 'Password reset succesfully! You can sign in with your new password now.',
              type: 'is-success'
            })
            this.close()
          }
        }).catch((error) => {
          console.error(error);
        }).finally(() => {
          this.resetting = false
        })
      }
    }
  },
  mounted() {
    const token = this.$route.query.password_reset

    if (token) {
      this.token = token
      this.open()
    }
  }
}
</script>

<style lang="scss" scoped>
.modal-card {
  width: 100%;
}
</style>
