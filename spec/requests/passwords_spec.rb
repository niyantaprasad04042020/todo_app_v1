require 'rails_helper'

RSpec.describe "Passwords", type: :request do

  FactoryBot.define do
    factory :user do
      trait :valid_user do
        first_name { 'Niyanta' }
        last_name { 'Prasad' }
        email_id { 'niyanta16@gmail.com' }
        phone_no { '9957086386' }
        password { "pineapple" }
      end
    end
  end

  describe "POST /forgot_password" do
    it "forgot password" do
      headers      = { "ACCEPT" => "application/json" }
      @valid_user  = FactoryBot.create :user, :valid_user
      post "/password/forgot", :params => { :email => @valid_user.email_id, :token => "6ba7945c1e47e435bd6", :password => "pineapple1"}, :headers => headers
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status :ok
    end
  end

  describe "POST /reset_password" do
    it "forgot password" do
      headers      = { "ACCEPT" => "application/json" }
      @valid_user  = FactoryBot.create :user, :valid_user
      post "/password/reset", :params => { :email => @valid_user.email_id, :token => "6ba7945c1e47e435bd6", :password => "pineapple1"}, :headers => headers
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status :ok
    end
  end
end
