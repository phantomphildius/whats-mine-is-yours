require 'csv'

class StatementParserService
  def initialize(csv_file)
    @csv_file = csv_file
  end

  def transaction_rows
    csv_contents.map do |row|
      next if transaction_is_payment?(row)
      transform_row!(row)
    end.compact
  end

  private

  attr_reader :csv_file
    
  def csv_contents
    @transaction_rows ||= CSV.read(csv_file.path, headers: true, header_converters: :symbol)
  end

  def transaction_is_payment?(row)
    row.fetch(:category).nil?   
  end

  def transform_row!(row)
    hash_row = row.to_h

    hash_row.merge(
      amount: row.fetch(:amount).to_money,
      date: Date.strptime(row.fetch(:date), '%m/%d/%Y'),
      merchant: hash_row.delete(:description),
    )
  end
end
