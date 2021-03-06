require 'rails_helper'

RSpec.describe FinancialControl, type: :model do
  describe '#create' do
    let(:user) { create(:user) }

    context 'when the financial control is valid' do
      it 'persist on database' do
        financial_control = described_class.new(
          name: 'Meu controle',
          description: 'Meu primeiro controle financeiro',
          user_id: user.id
        )

        expect{ financial_control.save }.to change { FinancialControl.count }.by(1)
      end
    end

    context 'when the financial control is invalid' do
      it 'return an error message' do
        financial_control = described_class.new(
          name: 'Meu controle',
          description: 'Meu primeiro controle financeiro',
          user_id: nil
        )

        financial_control.save

        expect(financial_control.errors[:user]).to eq(['O controle financeiro precisa de um usuário'])
      end

      it 'return error message unless name' do
        financial_control = described_class.new(
          name: '',
          description: 'Meu primeiro controle financeiro',
          user_id: user.id
        )

        financial_control.save

        expect(financial_control.errors[:name]).to eq(
          [
            'O nome precisa ser preenchido',
            'O nome está curto, mínimo 3 caracteres'
          ]
        )
      end
    end
  end
end
