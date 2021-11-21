class Types::InterestType < Types::BaseUnion
  possible_types Types::MovieType, Types::GenreType, Types::StarType
end
