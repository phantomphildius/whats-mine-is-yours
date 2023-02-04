require 'csv' 

class StatementImporterService
  def initialize(institution_name:, statement_file:, budget:, time_period:)
    @institution_name = institution_name
    @statement_file = statement_file
    @budget = budget
    @time_period = time_period
  end

  def import
    budget.transaction do
      institution.save!
      statement.save!
      ingest_statement_rows
      StatementCategorizerJob.perform_later(statement)
    end
  end

  def statement
    @statement ||= budget.statements.build(
      institution: institution,
      time_period: Date.strptime(time_period, '%m/%y'),
    )
  end

  private

  attr_reader :institution_name, :statement_file, :budget, :time_period

  def ingest_statement_rows
    CSV.foreach(statement_file.path, headers: true) do |row|
      next if transaction_is_payment?(row)

      statement.transactions.create!(
        amount: row.fetch('Amount').to_money,
        date: Date.strptime(row.fetch('Date'), '%m/%d/%Y'),
        category: row.fetch('Category'),
        merchant: row.fetch('Description'),
      )
    end
  end

  def institution
    @institution ||= Institution.find_or_initialize_by(name: institution_name.downcase)
  end

  def transaction_is_payment?(row)
    row.fetch('Category').nil?   
  end
end