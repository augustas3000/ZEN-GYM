require_relative( '../db/sql_runner' )

class Booking

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @gym_member_id = options['gym_member_id'].to_i
    @gym_class_id = options['gym_class_id']
  end

  def save()
    sql = "INSERT INTO class_bookings
    (
      gym_member_id,
      gym_class_id
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@gym_member_id, @gym_class_id]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def update
    sql = "UPDATE class_bookings SET (gym_member_id, gym_class_id ) = ($1, $2)
    WHERE id = $3"
    values = [@gym_member_id, @gym_class_id, @id]
    SqlRunner.run(sql, values)
  end


  def self.all()
    sql = "SELECT * FROM class_bookings"
    results = SqlRunner.run( sql )
    return results.map { |hash| Booking.new( hash) }
  end

  def self.find( id )
    sql = "SELECT * FROM class_bookings
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run( sql, values )
    return Booking.new( results.first )
  end

  def self.delete_all
    sql = "DELETE FROM class_bookings"
    SqlRunner.run( sql )
  end

  def delete
    sql = "DELETE FROM class_bookings WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

end
