require "test_helper"

class FollowInterestTest < ActionDispatch::IntegrationTest
  FOLLOW_INTEREST_QUERY = <<~'GRAPHQL'
    mutation FollowInterest($interestId: ID!, $interestKind: InterestKind!) {
      followInterest(input: { interestId: $interestId, interestKind: $interestKind }) {
        errors
      }
    }
  GRAPHQL

  def errors
    JSON.parse(response.body)["data"]["followInterest"]["errors"]
  end

  test "user can follow an interest" do
    genre = create :genre
    user = create :user

    sign_in_as user
    assert signed_in_as? user

    assert_not Genre.first.followers.include?(user)
    post graphql_path, params: { query: FOLLOW_INTEREST_QUERY, variables: { interestId: genre.id, interestKind: "GENRE" } }

    assert_response :success
    assert errors.count.zero?
    assert Genre.first.followers.include?(user)
  end
end
