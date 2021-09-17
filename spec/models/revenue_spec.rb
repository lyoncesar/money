require 'rails_helper'

RSpec.describe Revenue, type: :model do
  describe '#revenue_type' do
    it 'return revenue_types' do
      expect(Revenue.revenue_types.symbolize_keys).to eq({ temporary: 0, fixed: 1 })
    end
  end
  describe '#create' do
    let(:financial_control) { create(:financial_control) }

    context 'when is a valid revenue' do
      it 'persist it on database' do
        revenue = described_class.new(
          title: 'Adiantamento de salário',
          description: 'Adiantamento quinzenal do salário',
          date: Date.today,
          amount: Faker::Number.decimal(l_digits: 4, r_digits: 2),
          revenue_type: 1,
          duration: '',
          financial_control: financial_control
        )

        expect{ revenue.save }.to change{ Revenue.count }.by(1)
        expect(Revenue.last.title).to eq('Adiantamento de salário')
      end
    end

    context 'when is a invalid revenue' do
      it 'add an error message on class.errors' do
        revenue = described_class.new(
          title: 'Adiantamento de salário',
          description: 'Adiantamento quinzenal do salário',
          date: Date.today,
          amount: Faker::Number.decimal(l_digits: 4, r_digits: 2),
          revenue_type: 1,
          duration: '',
          financial_control: nil
        )

        expect{ revenue.save }.not_to change{ Revenue.count }
        expect(revenue.errors[:financial_control]).to include(
          'A receita precisa de um controle financeiro'
        )
      end

      it "return an error message if don't have title" do
        revenue = described_class.new(
          title: '',
          description: 'Adiantamento quinzenal do salário',
          date: Date.today,
          amount: Faker::Number.decimal(l_digits: 4, r_digits: 2),
          revenue_type: 1,
          duration: '',
          financial_control: financial_control
        )

        expect{ revenue.save }.not_to change{ Revenue.count }
        expect(revenue.errors).to include(:title)
        expect(revenue.errors[:title]).to include('O título deve ser preenchido')
      end

      it "return an error message if don't have amount" do
        revenue = described_class.new(
          title: 'Adiantamento de salário',
          description: 'Adiantamento quinzenal do salário',
          date: Date.today,
          amount: '',
          revenue_type: 1,
          duration: '',
          financial_control: financial_control
        )

        expect{ revenue.save }.not_to change{ Revenue.count }
        expect(revenue.errors).to include(:amount)
        expect(revenue.errors[:amount]).to include('O valor deve ser preenchido')
      end

      it "return an error message if don't have revenue_type" do
        revenue = described_class.new(
          title: 'Adiantamento de salário',
          description: 'Adiantamento quinzenal do salário',
          date: Date.today,
          amount: Faker::Number.decimal(l_digits: 4, r_digits: 2),
          revenue_type: '',
          duration: '',
          financial_control: financial_control
        )

        expect{ revenue.save }.not_to change{ Revenue.count }
        expect(revenue.errors).to include(:revenue_type)
        expect(revenue.errors[:revenue_type]).to include('O tipo de receita deve ser preenchido')
      end
    end
  end
end
