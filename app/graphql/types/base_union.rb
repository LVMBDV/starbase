module Types
  class BaseUnion < GraphQL::Schema::Union
    edge_type_class(Types::BaseEdge)
  end
end
