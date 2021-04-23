module Api
  module V1
    class QuestionsController < Api::V1::ApiController
      before_action :set_question, except: %i[index create]
      before_action :doorkeeper_authorize!, except: %i[index show]
      before_action :authorize_owner, only: %i[update destroy]

      def index
        @pagy, @questions = pagy(Question.all)
        render json: QuestionSerializer.new(@questions, meta: pagy_metadata(@pagy)).serializable_hash.to_json
      end

      def create
        @question = Question.new(title: question_params[:title],
                                 content: question_params[:content],
                                 user_id: question_params[:'user-id'])

        if @question.save
          @tag = question_params[:tags]
          @question.tags.create(@tag.map { |tag| { name: tag } })
          render json: QuestionSerializer.new(@question).serializable_hash.to_json, status: :ok
        else
          render json: { error: @question.errors }, status: :unprocessable_entity
        end
      end

      def show
        options = {}
        options[:include] = [:answers]
        render json: QuestionSerializer.new(@question, options).serializable_hash.to_json
      end

      def update
        if @question.update_attributes(title: params[:title] || @question.title,
                                       content: params[:content] || @question.content)

          modify_question_tags(@question.tags, params[:tags])
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
        params.require(:data).require(:attributes).permit(:id, :title, :content, :'user-id', tags: [])
      end

      def set_question
        @question = Question.find(params[:id])
      end

      def authorize_owner
        if !current_user
          render json: { error: 'Must be logged in to modify or delete questions' }, status: :unauthorized
        elsif @question.user != current_user
          render json: { error: 'This user is not authorized to modify or delete this question' }, status: :unauthorized
        end
      end

      # Modifies the tags belonging to the question if a user supplies different ones than are currently present
      # @param current_tags [ActiveRecord::Associations::CollectionProxy] collection of the current question tags
      # @param tag_names [ActionController::Parameters] tag names supplied via params
      def modify_question_tags(current_tags, tag_names)
        if tag_names
          # Not perfect, but there's only a max of 5 tags so it's not a massive issue. Probably better to check whether
          # there's a difference between the old and newly supplied tags, but this'll do for now.
          current_tags.destroy_all
          @question.tags.create(tag_names.map { |tag| { name: tag } })
        end
      end
    end
  end
end
