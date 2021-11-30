import gql from 'graphql-tag'

export default {
  computed: {
    $followTooltip() {
      return this.followingInterest ? 'Unfollow' : 'Follow'
    },
    $followIconClass() {
      return this.followingInterest ? 'fas' : 'far'
    },
  },
  methods: {
    async $unfollow() {
      try {
        const result = await this.$apollo.mutate({
          mutation: gql`
          mutation unfollowInterest($id: ID!, $kind: InterestKind!) {
            unfollowInterest(input: {interestId: $id, interestKind: $kind}) {
              errors
            }
          }`,
          variables: { id: this.interest.id , kind: this.interest.kind }
        })

        const errors = result.data.unfollowInterest.errors

        if (errors.length > 0) {
          throw new Error(errors.join(". "))
        }

        this.$refetchFollowingStatus()
      } catch (err) {
        this.$buefy.toast.open({
          message: err,
          type: 'is-danger'
        })
      }
    },
    async $follow() {
      try {
        const result = await this.$apollo.mutate({
          mutation: gql`
          mutation followInterest($id: ID!, $kind: InterestKind!) {
            followInterest(input: {interestId: $id, interestKind: $kind}) {
              errors
            }
          }`,
          variables: { id: this.interest.id , kind: this.interest.kind }
        })

        const errors = result.data.followInterest.errors

        if (errors.length > 0) {
          throw new Error(errors.join(". "))
        }

        this.$refetchFollowingStatus()
      } catch (err) {
        this.$buefy.toast.open({
          message: err,
          type: 'is-danger'
        })
      }
    },
    async $toggleFollow() {
      if (this.followingInterest) {
        await this.$unfollow()
      } else {
        await this.$follow()
      }
    },
    $refetchFollowingStatus() {
      this.$apollo.queries.followingInterest.refetch()
    }
  },
  apollo: {
    followingInterest: {
      query: gql`
        query followingInterest($id: ID!, $kind: InterestKind!) {
          followingInterest(interestId: $id, interestKind: $kind)
        }`,
      variables() {
        return {
          id: this.interest.id,
          kind: this.interest.kind
        }
      },
      skip() {
        return this.interest.id === undefined
      }
    }
  }
}
