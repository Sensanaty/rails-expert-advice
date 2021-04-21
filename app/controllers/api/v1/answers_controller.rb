module Api
  module V1
    class AnswersController < ApplicationController
      before_action :set_answer, except: %i[index create]
      before_action :doorkeeper_authorize!, except: [:index]
      before_action :authorize_owner, except: %i[index create]

      def index
        @pagy, @answers = pagy(Answer.where(question_id: params[:question_id]), items: 10)
        render json: AnswerSerializer
          .new(@answers, meta: { pagy: pagy_metadata(@pagy) })
          .serializable_hash.to_json, status: :ok
      end

      def create
        @answer = Answer.new(answer_params)

        if @answer.save
          render json: AnswerSerializer.new(@answer).serializable_hash.to_json, status: :ok
        else
          render json: { error: @answer.errors }, status: :unprocessable_entity
        end
      end

      def update
        if @answer.update_attributes(content: params[:content])
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
        params.permit(:id, :content, :user_id, :question_id)
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
