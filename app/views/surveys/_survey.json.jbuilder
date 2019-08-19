json.extract! survey, :id, :access, :questions, :start_date, :end_date, :user_id, :created_at, :updated_at
json.url survey_url(survey, format: :json)
