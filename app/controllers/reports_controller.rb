class ReportsController < ApplicationController
  def index
    @report = FinancialControl.last
    @total_revenue = @report.revenues.sum { |rev| rev.amount }
    @total_expense = @report.expenses.sum { |exp| exp.amount }
    @balance = @total_revenue - @total_expense
  end
end
