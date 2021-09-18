require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    context 'when user is valid' do
      it 'persist on database' do
        user = described_class.new(
          email: 'road_runner@acme.com',
          password: '123456',
          password_confirmation: '123456'
        )

        expect{ user.save }.to change{ User.count }.by(1)
        expect(User.last.email).to eq('road_runner@acme.com')
      end
    end

    context "when user don't have all params" do
      context 'return an error on class.errors' do
        it "if don't have a email" do
          user = described_class.new(
            email: '',
            password: '123456',
            password_confirmation: '123456'
          )

          expect{ user.save }.not_to change{ User.count }
          expect(user.errors).to include(:email)
          expect(user.errors[:email]).to include('O email deve ser preenchido')
        end

        it "if don't have a password" do
          user = described_class.new(
            email: 'road_runner@acme.com',
            password: '',
            password_confirmation: '123456'
          )

          expect{ user.save }.not_to change{ User.count }
          expect(user.errors).to include(:password)
          expect(user.errors[:password]).to include('A senha deve ser preenchida')
        end

        it "if don't have a password_confirmation" do
          user = described_class.new(
            email: 'road_runner@acme.com',
            password: '123456',
            password_confirmation: ''
          )

          expect{ user.save }.not_to change{ User.count }
          expect(user.errors).to include(:password_confirmation)
          expect(user.errors[:password_confirmation]).to include('A confirmação de senha deve ser preenchida')
        end
      end
    end
  end
end
