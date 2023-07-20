require 'rails_helper'

RSpec.describe "Donations", type: :request do
  let(:user) { create(:user) }

  context "Index" do
    describe "GET /donations with no user" do
      it "should redirect to user login" do
        get donations_path
        expect(response).to have_http_status(302)
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "GET /donations with user" do
      it "should render donations index" do
        sign_in user

        get donations_path
        expect(response).to have_http_status(200)
        expect(response).to render_template(:index)
      end
    end
  end

  context "Create" do
    describe "POST /donations" do
      let(:params) do
        {
          "donation" => {
            "first_name" => "Test",
            "last_name" => "Test",
            "email" => "test@test.com",
            "birth_date" => "2023-07-03",
            "phone_number" => "123456",
            "amount" => "100000",
            "card_attributes" => {
              "card_number" => "123456789012",
              "security_code" => "122",
              "expiration_date" => "2023-07-29",
              "card_type" => "visa",
              "document_type" => "cc",
              "document_number" => "123456",
              "_destroy" => "false"
            }
          }
        }
      end

      let(:bad_params) do
        {
          "donation" => {
            "first_name" => "Test",
            "last_name" => "Test",
            "email" => "test@test.com",
            "birth_date" => "2023-07-03",
            "phone_number" => "123456",
            "amount" => "100000",
            "card_attributes" => {
            }
          }
        }
      end

      describe "correct params" do
        it "creates a new donation and redirect thanks page" do
          post "/donations/", params: params
          expect(response).to redirect_to thanks_path
          follow_redirect!
          expect(response).to render_template(:thanks)
          expect(response.body).to include('Gracias por tu donacion')
        end
      end

      describe "incorrect params" do
        it "render new donation view" do
          post "/donations/", params: bad_params
          expect(response).to render_template(:new)
          expect(response.body).to include('Please review the problems below:')
        end
      end
    end
  end

  context "Update" do
    describe 'PATCH /donations/:id' do
      let!(:donation) { create :donation_with_card, card: build(:card) }
      let(:card) { donation.card }
      let(:params) do
        {
          "donation" => {
            "first_name" => "Test",
            "last_name" => "Test",
            "email" => "test2@test2.com",
            "birth_date" => "2023-07-03",
            "phone_number" => "123456",
            "amount" => "100000",
            "card_attributes" => {
              "id":"#{card.id}",
              "card_number" => "123456789012",
              "security_code" => "122",
              "expiration_date" => "2023-07-29",
              "card_type" => "visa",
              "document_type" => "cc",
              "document_number" => "123456",
              "_destroy" => "false"
            }
          }
        }
      end
      before(:each) { sign_in user }

      describe 'correct params' do
        it "should update donation data" do
          patch "/donations/#{donation.id}", params: params
          expect(response).to redirect_to donations_path
          follow_redirect!
          expect(response.body).to include('Donacion exitosamente editada.')
          donation.reload
          expect(donation.email).to eq 'test2@test2.com'
        end
      end
    end
  end

  context "Destroy" do
    describe "DESTROY /donations/:id" do
      let!(:donation) { create :donation_with_card, card: build(:card) }
      let!(:count) { Donation.count }
      before(:each) { sign_in user }

      it 'should delete donations' do
        delete "/donations/#{donation.id}"
        expect(response).to redirect_to donations_path
        follow_redirect!
        expect(response.body).to include('Donacion exitosamente eliminada.')
        expect(Donation.count).to eq(count - 1)
      end
    end
  end
end
