require 'rails_helper'

RSpec.describe FinancialControl, type: :model do
  describe '#create' do
    let(:user) { User.create(email: 'me@me.com', password: '123456', password_confirmation: '123456') }

    context 'when the financial control is valid' do
      it 'persist on database' do
        financial_control = described_class.new(
          title: 'Meu controle',
          description: 'Meu primeiro controle financeiro',
          user_id: user.id
        )

        expect{ financial_control.save }.to change { FinancialControl.count }.by(1)
      end
    end

    context 'when the financial control is invalid' do
      it 'return an error message' do
        financial_control = described_class.new(
          title: 'Meu controle',
          description: 'Meu primeiro controle financeiro',
          user_id: nil
        )

        financial_control.save
        expect(financial_control.errors[:user]).to eq(['O controle financeiro precisa de um usuário'])
      end

      it 'return error message unless title' do
        financial_control = described_class.new(
          title: '',
          description: 'Meu primeiro controle financeiro',
          user_id: user.id
        )

        financial_control.save

        expect(financial_control.errors[:title]).to eq(
          [
            'O título não pode ficar vazio',
            'O título está curto, mínimo 3 caracteres'
          ]
        )
      end
    end
  end
end
