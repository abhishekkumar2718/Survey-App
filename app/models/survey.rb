class Survey < ApplicationRecord
  belongs_to :user
  has_many :submissions
  has_many :permissions
  has_many :users, through: :permissions

  scope :permitted, lambda { |user_id|
    permitted_ids = Permission.where(user_id: user_id).pluck(:survey_id)
    where(closed: false).or(where(user_id: user_id)).or(where(id: permitted_ids))
  }

  def self.seed(count, titles, questions, options, closed: false)
    user_ids = User.ids
    count.times do |i|
      Survey.create(
        user_id: user_ids.sample,
        title: titles[i],
        questions: questions[i],
        options: options[i],
        closed: closed
      )
    end
  end

  def permit(email)
    user = User.find_by(email: email)
    Permission.create(user_id: user.id, survey_id: id) if user
  end

  def permitted?(user_id)
    !closed || users.find_by(id: user_id) || (self.user_id == user_id)
  end

  def submitted?(user_id)
    submissions.find_by(user_id: user_id)
  end

  def submit(user_id, data)
    Submission.create(survey_id: id, user_id: user_id, choices: data)
  end

  def options_lengths
    options.map { |option| option.length() }
  end

  def creator?(user_id)
    self.user_id == user_id
  end

  def aggregrates
    value_counts = []

    rows = submissions.pluck(:choices).transpose.map! do |row|
      row.map! { |x| x.to_i }
    end

    rows.each_with_index do |row, index|
      value_counts << [*0..options_lengths[index] - 1].map do |x|
        [x, row.count(x)]
      end.to_h
    end

    value_counts
  end
end
