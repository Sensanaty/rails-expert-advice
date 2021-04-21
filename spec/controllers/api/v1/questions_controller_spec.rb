require 'rails_helper'

RSpec.describe Api::V1::QuestionsController, type: :controller do
  before(:all) { create_list(:question, 16) }

  context "unauthorized endpoints" do
    describe "GET index" do
      xit "returns a paginated list of questions ordered by date created" do; end
      xit "returns all tags belonging to the questions"do ;end
      xit "returns metadata about total question count" do; end
      xit "returns metadata with pagination navigation" do; end
    end

    describe "GET index?page=<number>" do
      xit "returns correctly requested page of questions" do; end
      xit "returns correct number of remaining questions on last page" do; end
    end

    describe "GET show/:id" do
      xit "returns a specific question" do; end
      xit "returns all tags belonging to the question" do; end
      xit "returns paginated list of answers belonging to the question" do; end
    end
  end

  context "authorized endpoints" do
    let(:user) { create(:user) }

    let(:token) do
      instance_double('Doorkeeper::AccessToken', acceptable?: true, resource_owner_id: user.id)
    end

    before { allow(controller).to receive(:doorkeeper_token) { token } }

    describe "POST questions" do
      it "should create a new question with a tag" do
        post :create, params: {
          "title": "Question Title",
          "content": "Question Content",
          "user_id": 1,
          "tags": ["tag1"]
        }

        body_data = JSON.parse(response.body)['data']['attributes']

        expect(response.status).to eq(200)
        expect(body_data["title"]).not_to be_nil
        expect(body_data["content"]).not_to be_nil
        expect(body_data["user_id"]).not_to be_nil
        expect(body_data["tags"]).not_to be_nil
      end
    end
  end
end
