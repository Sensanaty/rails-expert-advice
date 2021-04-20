class Api::V1::QuestionsController < Api::V1::ApiController
  before_action :set_question, except: %i[index create]
  before_action :doorkeeper_authorize!, except: [:index, :show]
  before_action :authorize_owner, only: [:update, :destroy]

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

  def show
    render json: QuestionSerializer.new(@question).serializable_hash.to_json
  end

  # TODO: make deleting/changing tags is possible
  def update
    if @question.update_attributes(title: params[:title] || @question.title,
                                   content: params[:content] || @question.content)
      render json: QuestionSerializer.new(@question).serializable_hash.to_json, status: :ok
    else
      render json: { error: @question.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @tags = @question.tags

    if @question.destroy && @tags.destroy_all
      render status: :no_content
    else
      render json: { question: @question.errors, tags: @tags.errors }, status: :unprocessable_entity
    end
  end

  private

  def question_params
    # Not sure why permit(details: { :title, :content, :user_id }, tags: []) doesn't work
    params.permit(:id, :title, :content, :user_id, tags: [])
  end

  def set_question
    @question = Question.find(question_params[:id])
  end

  def authorize_owner
    if !current_user
      render json: { error: "Must be logged in to modify or delete questions" }, status: :unauthorized
    elsif @question.user != current_user
      render json: { error: "This user is not authorized to modify or delete this question" }, status: :unauthorized
    end
  end
end
