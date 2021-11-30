module Types
  class InterestKind < Types::BaseEnum
    value "MOVIE"
    value "GENRE"
    value "STAR"
    def self.model_class(value)

      {
        "MOVIE" => Movie,
        "GENRE" => Genre,
        "STAR" => Star
      }[value]
    end
  end

end
