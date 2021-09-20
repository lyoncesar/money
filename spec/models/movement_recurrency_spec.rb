require 'rails_helper'

RSpec.describe MovementRecurrency, type: :model do
  describe '#create' do
    let(:financial_movement) { create(:financial_movement, :expense) }

    context 'when the movement_recurrency is valid' do
      it 'persist on database without errors' do
        movement_recurrency = described_class.new(
          date: Date.today + 1.month,
          financial_movement: financial_movement
        )

        expect{ movement_recurrency.save }.to change{ MovementRecurrency.count }.by(1)
        expect(MovementRecurrency.last.financial_movement).to eq(financial_movement)
        expect(movement_recurrency.errors.present?).to be_falsey
      end
    end

    context 'when the movement_recurrency is invalid' do
      it "don't persist on database and return errors on class.errors" do
        movement_recurrency = described_class.new(
          date: Date.today + 1.month,
          financial_movement: nil
        )

        expect{ movement_recurrency.save }.not_to change{ MovementRecurrency.count }
        expect(movement_recurrency.errors).to include(:financial_movement)
        expect(movement_recurrency.errors[:financial_movement]).to include(
          'A recorrência de movimento financeiro precisa de um movimento financeiro'
        )
      end
    end
  end
end
