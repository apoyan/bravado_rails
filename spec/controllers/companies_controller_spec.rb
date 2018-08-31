require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  let(:valid_attributes) { { name: 'Google', number: 1 } }
  let(:invalid_attributes) { { name: '', number: '' } }

  describe "GET #index" do
    it "returns a success response" do
      Company.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      company = Company.create! valid_attributes
      get :show, params: {id: company.to_param}
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      company = Company.create! valid_attributes
      get :edit, params: {id: company.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Company" do
        expect {
          post :create, params: {company: valid_attributes}
        }.to change(Company, :count).by(1)
      end

      it "redirects to the created company" do
        post :create, params: {company: valid_attributes}
        expect(response).to redirect_to(Company.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {company: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { name: 'Yandex', number: 2 } }

      it "updates the requested company" do
        company = Company.create! valid_attributes
        put :update, params: {id: company.to_param, company: new_attributes}
        company.reload
        expect(company.name).to eq new_attributes[:name]
        expect(company.number).to eq new_attributes[:number]
        expect(response).to redirect_to(company)
      end

      it "redirects to the company" do
        company = Company.create! valid_attributes
        put :update, params: {id: company.to_param, company: valid_attributes}
        expect(response).to redirect_to(company)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        company = Company.create! valid_attributes
        put :update, params: {id: company.to_param, company: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested company" do
      company = Company.create! valid_attributes
      expect {
        delete :destroy, params: {id: company.to_param}
      }.to change(Company, :count).by(-1)
    end

    it "redirects to the companies list" do
      company = Company.create! valid_attributes
      delete :destroy, params: {id: company.to_param}
      expect(response).to redirect_to(companies_url)
    end
  end
end
