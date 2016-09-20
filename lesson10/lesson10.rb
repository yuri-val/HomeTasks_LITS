require 'mysql2'

client = Mysql2::Client.new(host: 'localhost', username: 'root', password: 'root')

client.query('USE my_db')

results = client.query("SELECT
                            figures.name,
                            GROUP_CONCAT(formulas.formula) AS formula
                        FROM figures
                          LEFT JOIN formulas
                          ON figures.id = formulas.figure_id
                        GROUP BY figures.name")

results.each do |row|
    # conveniently, row is a hash
    # the keys are the fields, as you'd expect
    # the values are pre-built ruby primitives mapped from their corresponding field types in MySQL
    puts "#{row['name']} - #{row['formula']}"
end
