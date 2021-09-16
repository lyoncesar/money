require 'rails_helper'

RSpec.describe Expense, type: :model do
  describe '#create' do
    let(:financial_control) { create(:financial_control) }

    context 'when expense is valid' do
      it 'persist on database without errors' do
        expense = described_class.new(
          title: 'Aluguel',
          description: 'Aluguel do apto',
          date: Date.today,
          amount: 1200.00,
          expense_type: 1,
          duration: nil,
          financial_control: financial_control
        )
        expect{ expense.save }.to change{ Expense.count }.by(1)
        expect(expense.errors.messages).to eq({})
        expect(Expense.last.title).to eq('Aluguel')
      end
    end

    context 'when expense is invalid' do
      it 'add an error message to class.errors' do
        expense = described_class.new(
          title: 'Aluguel',
          description: 'Aluguel do apto',
          date: Date.today,
          amount: 1200.00,
          expense_type: 1,
          duration: nil,
          financial_control: nil
        )
        expect{ expense.save }.not_to change{ Expense.count }
        expect(expense.errors).to include(:financial_control)
      end
    end
  end
end
