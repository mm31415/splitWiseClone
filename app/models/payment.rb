class Payment < ApplicationRecord
  validates :amount, :friendship_id, presence: true

  belongs_to(
    :friendship,
    class_name: "Friendship",
    foreign_key: :friendship_id,
    primary_key: :id
  )

  def to_h
    {
      id: self.id,
      amount: self.amount,
      date: self.date
    }
  end

end
