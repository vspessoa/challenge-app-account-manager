class Transaction < ApplicationRecord
  enum status: [:completed, :pending, :canceled]
  
  enum transaction_type: [ :transfer, :contribution, :reversal ]

  belongs_to :origin, class_name: "Account"
  belongs_to :destination, class_name: "Account"
  validates :transaction_type, :amount, presence: true
  validates :token, uniqueness: true, allow_blank: true, allow_nil: true

  validates_with TransactionValidator

  after_initialize :generate_token

  def generate_token
    if self.contribution? && self.token.blank?
      begin
        self.token = SecureRandom.hex(12)      
      end while Transaction.exists?(token: self.token)
    end
  end
end
