class JournalEntry < ActiveRecord::Base

  belongs_to :user

  validates :mood, presence: true

  def formatted_created_at
    self.created_at.strftime("%A, %d %b %Y %l:%M %p")
  end
end
