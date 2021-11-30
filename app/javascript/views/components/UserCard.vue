<template>
  <div class="user-card is-flex is-align-items-center is-justify-content-center mx-4">
    <div class="user-card__welcome-message is-flex is-align-items-center" v-if="!!$data.$user">
      <p class="mr-4">Welcome, {{ $data.$user.emailAddress }}</p>
      <b-button type="is-text" @click="$signOut">Sign out</b-button>
    </div>
    <div class="user-card__authentication-buttons" v-else>
      <b-button tag="a" type="is-text" @click="openPasswordResetRequestModal">Forgot password?</b-button>
      <b-button tag="a" @click="openSignInModal" class="ml-4">Sign In</b-button>
      <b-button tag="a" @click="openSignUpModal" class="ml-4">Sign Up</b-button>
    </div>
    <SignInModal @signed-in="$fetchCurrentUser" ref="signInModal"/>
    <SignUpModal ref="signUpModal"/>
    <PasswordResetRequestModal ref="passwordResetRequestModal"/>
    <PasswordResetModal/>
  </div>
</template>

<script>
import SignInModal from './SignInModal.vue'
import SignUpModal from './SignUpModal.vue'
import PasswordResetModal from './PasswordResetModal.vue'
import PasswordResetRequestModal from './PasswordResetRequestModal.vue'
import AuthenticationMixin from '../../mixins/AuthenticationMixin'

export default {
  components: {
    SignInModal,
    SignUpModal,
    PasswordResetModal,
    PasswordResetRequestModal
  },
  mixins: [AuthenticationMixin],
  methods: {
    openSignInModal() {
      this.$refs.signInModal.open()
    },
    openSignUpModal() {
      this.$refs.signUpModal.open()
    },
    openPasswordResetRequestModal() {
      this.$refs.passwordResetRequestModal.open()
    },
  },
  created() {
    this.$fetchCurrentUser()
  }
}
</script>
