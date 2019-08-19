module SurveysHelper
  def submitted?(survey)
    survey.submitted?(current_user.id)
  end
end
