
require "test_helper"

class GenresTest < ActionDispatch::IntegrationTest
  GENRES_QUERY = <<~'GRAPHQL'
    query Genres {
      genres {
        title
        description
        movies {
          totalCount
        }
      }
    }
  GRAPHQL

  def genres
    JSON.parse(response.body)["data"]["genres"]
  end

  test "genres can be listed" do
    create_list(:genre, 5)

    post graphql_path, params: { query: GENRES_QUERY }

    assert_equal genres.count, 5
    assert genres.all? { |genre| genre["movies"]["totalCount"] > 0 }
    assert_response :success
  end
end
