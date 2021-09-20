class ReportsController < ApplicationController
  def index
    report = FinancialControl.last
    @revenues = report.financial_movements.where(movement_type: :revenue)
    @expenses = report.financial_movements.where(movement_type: :expense)
    @total_revenue = @revenues.sum { |revenue| revenue.amount }
    @total_expense = @expenses.sum { |expense| expense.amount }
    @balance = @total_revenue - @total_expense
  end
end
