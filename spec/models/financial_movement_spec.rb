require 'rails_helper'

RSpec.describe FinancialMovement, type: :model do
  describe '#movement_type' do
    it 'return financial_movement:_types' do
      expect(FinancialMovement.movement_types.symbolize_keys).to eq({ revenue: 0, expense: 1 })
    end
  end

  describe '#create' do
    let(:financial_control) { create(:financial_control) }

    context 'when financial_movement is valid' do
      it 'persist on database without errors' do
        financial_movement = described_class.new(
          name: 'Aluguel',
          description: 'Aluguel do apto',
          date: Date.today,
          amount: 1200.00,
          movement_type: :expense,
          duration: 'permanent',
          financial_control: financial_control
        )

        expect{ financial_movement.save }.to change{ FinancialMovement.count }.by(1)
        expect(financial_movement.errors.messages).to eq({})
        expect(FinancialMovement.last.name).to eq('Aluguel')
      end
    end

    context 'when financial_movement is invalid' do
      it 'add an error message to class.errors' do
        financial_movement = described_class.new(
          name: 'Aluguel',
          description: 'Aluguel do apto',
          date: Date.today,
          amount: 1200.00,
          movement_type: :expense,
          duration: 'permanent',
          financial_control: nil
        )
        expect{ financial_movement.save }.not_to change{ FinancialMovement.count }
        expect(financial_movement.errors).to include(:financial_control)
      end

      it "return an error message if don't have a name" do
        financial_movement = described_class.new(
          name: '',
          description: 'Aluguel do apto',
          date: Date.today,
          amount: 1200.00,
          movement_type: :expense,
          duration: 'permanent',
          financial_control: financial_control
        )

        expect{ financial_movement.save }.not_to change{ FinancialMovement.count }
        expect(financial_movement.errors).to include(:name)
        expect(financial_movement.errors[:name]).to include('O nome deve ser preenchido')
      end

      it "return an error message if don't have an amount" do
        financial_movement = described_class.new(
          name: 'Aluguel',
          description: 'Aluguel do apto',
          date: Date.today,
          amount: '',
          movement_type: :expense,
          duration: 'permanent',
          financial_control: financial_control
        )

        expect{ financial_movement.save }.not_to change{ FinancialMovement.count }
        expect(financial_movement.errors).to include(:amount)
        expect(financial_movement.errors[:amount]).to include('O valor deve ser preenchido')
      end

      it "return an error message if don't have an movement_type" do
        financial_movement = described_class.new(
          name: 'Aluguel',
          description: 'Aluguel do apto',
          date: Date.today,
          amount: 1200.00,
          movement_type: '',
          duration: 'permanent',
          financial_control: financial_control
        )

        expect{ financial_movement.save }.not_to change{ FinancialMovement.count }
        expect(financial_movement.errors).to include(:movement_type)
        expect(financial_movement.errors[:movement_type]).to include('O tipo de movimento deve ser preenchido')
      end
    end
  end
end
