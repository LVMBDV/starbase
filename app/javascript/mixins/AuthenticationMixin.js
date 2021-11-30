import jwt from 'jsonwebtoken'
import gql from 'graphql-tag'

export default {
  data() {
    return {
      $user: undefined
    };
  },
  computed: {
    $userId() {
      const token = jwt.decode(this.$cookies.get("jwt"));
      return token?.user_id;
    },
    $isAuthenticated() {
      return this.$cookies.isKey("jwt")
    },
  },
  methods: {
    async $fetchCurrentUser() {
      if (this.$userId === undefined) {
        return;
      }

      const result = await this.$apollo.query({
        query: gql`
        query user($id: ID!) {
          user(id: $id) {
            id
            emailAddress
          }
        }`,
        variables: { id: this.$userId },
      });

      this.$data.$user = result.data.user;
      return this.$data.$user;
    },
    async $signIn(emailAddress, password) {
      try {
        const result = await this.$apollo.mutate({
          mutation: gql`
          mutation signIn($emailAddress: String!, $password: String!) {
            signIn(input: { credentials: { emailAddress: $emailAddress, password: $password }}) {
              errors
            }
          }`,
          variables: { emailAddress, password }
        })

        this.$cookies.refresh()
        return result.data.signIn.errors
      } catch (err) {
        console.error(err)
        this.$buefy.toast.open({
          message: err,
          type: 'is-danger'
        })

        return []
      }
    },
    $signOut() {
      this.$cookies.remove("jwt")
      this.$data.$user = undefined
      this.$buefy.toast.open({
        message: 'Signed out.',
      })
    },
    async $signUp(emailAddress, password) {
      try {
        const result = await this.$apollo.mutate({
          mutation: gql`
          mutation signUp($emailAddress: String!, $password: String!) {
            signUp(input: { credentials: { emailAddress: $emailAddress, password: $password }}) {
              errors
            }
          }`,
          variables: { emailAddress, password }
        })

        return result.data.signUp.errors
      } catch (err) {
        this.$buefy.toast.open({
          message: err,
          type: 'is-danger'
        })

        return []
      }
    },
    async $resetPassword(token, password) {
      try {
        const result = await this.$apollo.mutate({
          mutation: gql`
          mutation resetPassword($token: String!, $password: String!) {
            resetPassword(input: { token: $token, password: $password }) {
              errors
            }
          }`,
          variables: { token, password }
        })

        return result.data.resetPassword.errors
      } catch (err) {
        this.$buefy.toast.open({
          message: err,
          type: 'is-danger'
        })

        return []
      }
    },
    async $requestPasswordReset(emailAddress) {
      try {
        const result = await this.$apollo.mutate({
          mutation: gql`
          mutation requestPasswordReset($emailAddress: String!) {
            requestPasswordReset(input: { emailAddress: $emailAddress }) {
              errors
            }
          }`,
          variables: { emailAddress }
        })

        return result.data.requestPasswordReset.errors
      } catch (err) {
        this.$buefy.toast.open({
          message: err,
          type: 'is-danger'
        })

        return []
      }
    }
  }
}
