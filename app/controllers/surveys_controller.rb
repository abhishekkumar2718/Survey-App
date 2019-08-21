class SurveysController < ApplicationController
  before_action :set_survey, only: [:show, :edit, :update, :destroy, :submission, :invite]
  before_action :authorize, only: [:show, :edit, :update, :destroy]

  # GET /surveys
  # GET /surveys.json
  def index
    @surveys = Survey.permitted(current_user.id).includes(:users, :submissions)
  end

  # GET /surveys/1
  # GET /surveys/1.json
  def show
  end

  # GET /surveys/new
  def new
    @survey = Survey.new
  end

  # GET /surveys/1/edit
  def edit
  end

  # POST /surveys
  # POST /surveys.json
  def create
    @survey = Survey.new(survey_params)

    respond_to do |format|
      if @survey.save
        format.html { redirect_to @survey, notice: 'Survey was succesfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /surveys/1
  # PATCH/PUT /surveys/1.json
  def update
    respond_to do |format|
      if @survey.update(survey_params)
        format.html { redirect_to @survey, notice: 'Survey was successfully updated.' }
        format.json { render :show, status: :ok, location: @survey }
      else
        format.html { render :edit }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /surveys/1
  # DELETE /surveys/1.json
  def destroy
    @survey.destroy
    respond_to do |format|
      format.html { redirect_to surveys_url, notice: 'Survey was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def submission
    if submitted_options.length == @survey.questions.length
      @survey.submit(current_user.id, submitted_options)
      flash[:notice] = 'Survey submitted successfully!'
    else
      flash[:notice] = 'Some options have not been filled!'
    end
  end

  def invite
    email = params[:email]
    user = User.find_by(email: email)
    if user
      if @survey.permitted?(user.id)
        flash[:notice] = 'User already has permissions to the survey!'
      else
        @survey.permit(user.id)
        flash[:notice] = 'User invited'
      end
    else
      flash[:notice] = 'User not found'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey
      @survey = Survey.find_by(id: params[:id])
      unless @survey
        flash[:notice] = 'The resource does not exist!'
        redirect_to surveys_path
      end
    end

    def authorize
      unless @survey.permitted?(current_user.id)
        flash[:notice] = 'The resource does not exist!'
        redirect_to surveys_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def survey_params
      permitted_params = params.permit(:closed, :title, questions: [], options: {})

      {
        title: params[:title],
        closed: params[:closed] == 'on',
        user_id: current_user.id,
        questions: permitted_params[:questions],
        options: permitted_params[:options].values
      }
    end

    def submitted_options
      permitted_questions = [*0..@survey.questions.length].map! { |x| x.to_s }
      params.permit(permitted_questions).values
    end
end
