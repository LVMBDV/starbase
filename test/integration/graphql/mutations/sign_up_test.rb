require "test_helper"

class SignUpTest < ActionDispatch::IntegrationTest
  SIGN_UP_QUERY = <<~'GRAPHQL'
    mutation SignUp($emailAddress: String!, $password: String!) {
      signUp(input: {
        credentials: { emailAddress: $emailAddress, password: $password }
      }) {
        errors
      }
    }
  GRAPHQL

  def errors
    JSON.parse(response.body)["data"]["signUp"]["errors"]
  end

  test "user can sign up" do
    post graphql_path, params: {
      query: SIGN_UP_QUERY,
      variables: {
        emailAddress: Faker::Internet.email,
        password: Faker::Internet.password
      }
    }

    assert_response :success
    assert_equal errors.count, 0
  end
end
