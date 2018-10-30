require('pg')
require('pry-byebug')

class Property

  attr_accessor :value, :number_of_bedrooms, :year_built, :buy_let_status
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @value = options['value'].to_i
    @number_of_bedrooms = options['number_of_bedrooms'].to_i
    @year_built = options['year_built'].to_i
    @buy_let_status = options['buy_let_status']
  end

  def save()
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "INSERT INTO property_tracker (value, number_of_bedrooms, year_built, buy_let_status) VALUES ($1, $2, $3, $4) RETURNING *;"
    values = [@value, @number_of_bedrooms, @year_built, @buy_let_status]
    db.prepare("save", sql)
    array_of_hashes = db.exec_prepared("save", values)
    @id = array_of_hashes[0]['id'].to_i
    db.close()
  end

  def Property.delete_all()
    db = PG.connect({dbname: "property_tracker", host: "localhost"})
    sql = "DELETE FROM property_tracker;"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def delete()
    db = PG.connect({dbname: "property_tracker", host: "localhost"})
    sql = "DELETE FROM property_tracker WHERE id = $1;"
    values = [@id]
    db.prepare("delete", sql)
    array_of_hashes = db.exec_prepared("delete", values)
    db.close()
  end

  def update()

    db = PG.connect({dbname: "property_tracker", host: "localhost"})
    sql = "UPDATE property_tracker SET (value, number_of_bedrooms, year_built, buy_let_status) = ($1, $2, $3, $4) WHERE id = $5;"
    values = [@value, @number_of_bedrooms, @year_built, @buy_let_status, @id]
    db.prepare("update", sql)
    array_of_hashes = db.exec_prepared("update", values)
    db.close()
  end

  def Property.find(id)
    db = PG.connect({dbname: "property_tracker", host: "localhost"})
    sql = "SELECT * FROM property_tracker WHERE id = $1;"
    values = [id]
    db.prepare("find", sql)
    array_of_hashes = db.exec_prepared("find", values)
    db.close()
    p array_of_hashes.map { |order_hash| Property.new(order_hash) }
  end

  def Property.find_by_year_built(year)
    db = PG.connect({dbname: "property_tracker", host: "localhost"})
    sql = "SELECT * FROM property_tracker WHERE year_built = $1;"
    values = [year]
    db.prepare("find", sql)
    array_of_hashes = db.exec_prepared("find", values)
    db.close()
    result =  array_of_hashes.map { |order_hash| Property.new(order_hash)}
    if result == []
      result = nil
    end
      p result

  end

end
