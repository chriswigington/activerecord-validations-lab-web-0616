class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: {in: ["Fiction", "Non-Fiction"]}

  validate :must_be_clickbait

  def must_be_clickbait
    clickbaity = ["Won't Believe", "Secret", "Top ", "Guess"]
    if self.title.nil?
      errors.add(:title, "must exist, dummy")
    else
      clickbaity.each do |clickbait|
        if self.title.include?(clickbait)
          return
        end
      end
    end
    errors.add(:title, "must be clickbait")
  end
end
