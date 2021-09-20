namespace :one_shot do
  desc 'Run the migration of Revenues and Expenses to FinancialMovements'
  task :migrate_revenues_and_expenses_to_financial_movements => :environment  do
    puts 'Migrating revenues...'
    FinancialMovement.transaction do
      Revenue.find_each do |revenue|
        puts 'revenue: ' + revenue.title
        FinancialMovement.create(
          name: revenue.title,
          description: revenue.description,
          date: revenue.date,
          amount: revenue.amount,
          movement_type: :revenue,
          duration: '',
          financial_control: revenue.financial_control
        )
      end

      puts 'Revenues migration done!'
      puts 'Destroing all Revenues...'
      puts 'Revenues destroyed' if Revenue.destroy_all
    end

    puts 'Migrating expenses...'
    FinancialMovement.transaction do
      Expense.find_each do |expense|
        puts 'expense: ' + expense.title
        FinancialMovement.create(
          name: expense.title,
          description: expense.description,
          date: expense.date,
          amount: expense.amount,
          movement_type: :expense,
          duration: '',
          financial_control: expense.financial_control
        )
      end

      puts 'Expenses migration done!'
      puts 'Destroing all Expenses...'
      puts 'Expenses destroyed' if Expense.destroy_all
    end
  end
end
