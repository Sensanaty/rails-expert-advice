require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:user) { create(:user) }

  context "with correct parameters" do
    it "should create a question" do
      question = create(:question, user: user)

      expect(question.title).not_to be_empty
      expect(question.content).not_to be_empty
      expect(question.user_id).to eq(user.id)
      expect(question).to be_valid
    end
  end

  context "with incorrect parameters" do
    it "raises an error when no title is provided" do
      question = build(:question, user: user, title: nil)

      expect{ question.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "raises an error when no content is provided" do
      question = build(:question, user: user, content: nil)

      expect{ question.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "raises an error when no user is attached" do
      question = build(:question, user: nil)

      expect{ question.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context "user account deletion" do
    it "nullifies the user_id field" do
      question = create(:question, user: user)

      expect(question).to be_valid
      expect{
        user.destroy
        question.reload
      }.to change(question, :user_id).to(nil)
    end
  end
end
