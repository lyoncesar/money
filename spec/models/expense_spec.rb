require 'rails_helper'

RSpec.describe Expense, type: :model do
  describe '#expense_type' do
    it 'return expense_types' do
      expect(Expense.expense_types.symbolize_keys).to eq({ temporary: 0, fixed: 1 })
    end
  end

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

      it "return an error message if don't have a title" do
        expense = described_class.new(
          title: '',
          description: 'Aluguel do apto',
          date: Date.today,
          amount: 1200.00,
          expense_type: 1,
          duration: nil,
          financial_control: financial_control
        )

        expect{ expense.save }.not_to change{ Expense.count }
        expect(expense.errors).to include(:title)
        expect(expense.errors[:title]).to include('O título deve ser preenchido')
      end

      it "return an error message if don't have an amount" do
        expense = described_class.new(
          title: 'Aluguel',
          description: 'Aluguel do apto',
          date: Date.today,
          amount: '',
          expense_type: 1,
          duration: nil,
          financial_control: financial_control
        )

        expect{ expense.save }.not_to change{ Expense.count }
        expect(expense.errors).to include(:amount)
        expect(expense.errors[:amount]).to include('O valor deve ser preenchido')
      end

      it "return an error message if don't have an expense_type" do
        expense = described_class.new(
          title: 'Aluguel',
          description: 'Aluguel do apto',
          date: Date.today,
          amount: 1200.00,
          expense_type: '',
          duration: nil,
          financial_control: financial_control
        )

        expect{ expense.save }.not_to change{ Expense.count }
        expect(expense.errors).to include(:expense_type)
        expect(expense.errors[:expense_type]).to include('O tipo de despesa deve ser preenchido')
      end
    end
  end
end
