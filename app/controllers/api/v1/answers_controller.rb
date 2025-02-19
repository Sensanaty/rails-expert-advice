module Api
  module V1
    class AnswersController < Api::V1::ApiController
      before_action :set_answer, except: %i[index create]
      before_action :doorkeeper_authorize!, except: [:index, :show]
      before_action :authorize_owner, except: %i[index show create]

      def index
        @answers = Answer.all.order(created_at: :desc)
        render json: AnswerSerializer.new(@answers).serializable_hash.to_json, status: :ok
      end

      def show
        render json: AnswerSerializer.new(@answer).serializable_hash.to_json, status: :ok
      end

      def create
        @answer = Answer.new(content: answer_params[:content],
                             user_id: answer_params[:'user-id'],
                             question_id: answer_params[:'question-id'])

        if @answer.save
          render json: AnswerSerializer.new(@answer).serializable_hash.to_json, status: :ok
        else
          render json: { error: @answer.errors }, status: :unprocessable_entity
        end
      end

      def update
        if @answer.update(content: answer_params[:content])
          render json: AnswerSerializer.new(@answer).serializable_hash.to_json, status: :ok
        else
          render json: { error: @answer.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        if @answer.destroy
          render status: :no_content
        else
          render json: { error: @answer.errors }, status: :unprocessable_entity
        end
      end

      private

      def answer_params
        params.require(:data).require(:attributes).permit(:id, :content, :'user-id', :'question-id')
      end

      def set_answer
        @answer = Answer.find(params[:id])
      end

      # Should probably make this a helper since it's present in the question controller as well
      def authorize_owner
        if !current_user
          render json: { error: 'Must be logged in to modify or delete answers' }, status: :unauthorized
        elsif @answer.user != current_user
          render json: { error: 'This user is not authorized to modify or delete this answer' }, status: :unauthorized
        end
      end
    end
  end
end
