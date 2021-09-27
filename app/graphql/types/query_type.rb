module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :financial_control, FinancialControlType, null: false do
      description 'Find a financial_control by id'
      argument :id, ID, required: false
      argument :user_id, ID, required: false
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end

    def financial_control(id:, user_id:)
      FinancialControl.where(id: id, user_id: user_id)
    end
  end
end
