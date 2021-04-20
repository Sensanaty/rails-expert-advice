class Api::V1::QuestionsController < Api::V1::ApiController
  before_action :doorkeeper_authorize!, except: [:index]
  # before_action :authorize_owner, only: [:edit, :destroy]

  def index
    @questions = Question.all
    render json: QuestionSerializer.new(@questions).serializable_hash.to_json
  end

  def create
    @question = Question.new(title: question_params[:title],
                             content: question_params[:content],
                             user_id: question_params[:user_id])

    if @question.save
      @tag = question_params[:tags]
      @question.tags.create(@tag.map { |tag| { name: tag } })
      render json: QuestionSerializer.new(@question).serializable_hash.to_json, status: :ok
    else
      render json: { error: @question.errors }, status: :unprocessable_entity
    end
  end

  private

  def question_params
    # Not sure why permit(details: { :title, :content, :user_id }, tags: []) doesn't work
    params.permit(:title, :content, :user_id, tags: [])
  end
end
