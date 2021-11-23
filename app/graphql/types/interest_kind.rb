module Types
  class InterestKind < Types::BaseEnum
    value "MOVIE"
    value "GENRE"
    value "STAR"
  end

  def model_class
    {
      "MOVIE" => Movie,
      "GENRE" => Genre,
      "STAR" => Star
    }[self.value]
  end
end
