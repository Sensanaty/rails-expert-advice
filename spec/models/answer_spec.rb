require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:user) { create(:user) }
  let(:question) { create(:question) }

  context "with valid params" do
    it "should create an answer" do
      answer = create(:answer)

      expect(answer.content).not_to be_empty
      expect(answer.user).not_to be_nil
      expect(answer.question).not_to be_nil
      expect(answer).to be_valid
    end
  end

  context "with invalid params" do
    it "raises an error when no user is provided" do
      answer = build(:answer, user: nil, question: question, content: "Content Text")

      expect{ answer.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "raises an error when no question is provided" do
      answer = build(:answer, user: user, question: nil, content: "Content Text")

      expect{ answer.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "raises an error when no content is provided" do
      answer = build(:answer, user: user, question: question, content: nil)

      expect{ answer.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context "dependant deletion" do
    it "nullifies user_id when a user account is destroyed" do
      answer = create(:answer)

      expect{
        answer.user.destroy!
        answer.reload
      }.to change(answer, :user_id).to(nil)
    end

    it "deletes question_id when a question is deleted" do
      answer = create(:answer)

      answer.question.destroy
      expect{ answer.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
