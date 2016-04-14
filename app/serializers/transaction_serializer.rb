class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :invoice_id, :result, :credit_card_number, :created_at, :updated_at
end
