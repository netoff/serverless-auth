require 'swagger_helper'

RSpec.describe 'api/users', type: :request do
  let(:admin) { create(:admin) }
  let(:existing_user) { create(:user) }

  path '/api/users' do
    post 'Create a User' do
      tags 'Users'
      security [bearer: {}]
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string, format: :email },
          password: { type: :string, format: :password },
          password_confirmation: { type: :string, format: :password }
        },
        required: %w[email password password_confirmation]
      }

      response '201', 'user created' do
        let(:user) { { email: 'user@gmail.com', password: '12345', password_confirmation: '12345' } }
        let(:Authorization) { "Bearer #{::Base64.strict_encode64(admin.api_key)}"}
        run_test! do |response|
          json = JSON.parse(response.body)
          expect(json["email"]).to eq(User.last.email)
          expect(json["token"]).to eq(User.last.jwt_token)
        end
      end

      response '400', 'email missing' do
        let(:user) { { password: '12345', password_confirmation: '12345' } }
        let(:Authorization) { "Bearer #{admin.api_key}"}
        run_test!
      end

      response '400', 'password request' do
        let(:user) { { email: 'user@gmail.com', password_confirmation: '12345' } }
        let(:Authorization) { "Bearer #{admin.api_key}"}
        run_test!
      end

      response '400', 'password confirmation missing' do
        let(:user) { { email: 'user@gmail.com', password: '12345' } }
        let(:Authorization) { "Bearer #{admin.api_key}"}
        run_test!
      end

      response '400', 'password confirmation does not match' do
        let(:user) { { email: 'user@gmail.com', password: '12345', password_confirmation: '54321' } }
        let(:Authorization) { "Bearer #{admin.api_key}"}
        run_test!
      end

      response '400', 'invalid email' do
        let(:user) { { email: 'bad', password: '12345', password_confirmation: '12345' } }
        let(:Authorization) { "Bearer #{admin.api_key}"}
        run_test!
      end

      response '400', 'duplicate email' do
        let(:user) { { email: existing_user.email, password: '12345', password_confirmation: '12345' } }
        let(:Authorization) { "Bearer #{admin.api_key}"}
        run_test!
      end

      response '401', 'unauthorized' do
        let(:user) { { email: 'user@gmail.com', password: '12345', password_confirmation: '123456' } }
        let(:Authorization) { "" }
        run_test!
      end
    end
  end
end
