require_relative( '../db/sql_runner' )

class Booking

  attr_accessor :id, :gym_member_id, :gym_class_id

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

  def self.bookings_report
    sql = "SELECT

    class_bookings.id as booking_id, gym_members.member_name as name, gym_members.member_surname as surname,
    gym_members.membership_status as membership,
    gym_activities.activity_name as activity,
    gym_classes.class_time as class_time,
    gym_classes.id as class_id

    FROM class_bookings LEFT JOIN gym_members ON class_bookings.gym_member_id = gym_members.id

    INNER JOIN gym_classes ON gym_classes.id = class_bookings.gym_class_id

    INNER JOIN gym_activities ON gym_classes.activity_id = gym_activities.id
    "

    results = SqlRunner.run( sql )
    return results
  end

  def activity_name
    sql = "SELECT gym_activities.activity_name
           FROM gym_activities INNER JOIN gym_classes ON gym_activities.id = gym_classes.activity_id WHERE gym_classes.id = $1"
    values = [@gym_class_id]
    result = SqlRunner.run(sql, values)
    result = result[0]
    return result['activity_name']
  end

  def class_time
    sql = "SELECT gym_classes.class_time
           FROM gym_classes WHERE gym_classes.id = $1"
    values = [@gym_class_id]
    result = SqlRunner.run(sql, values)
    result = result[0]
    return result['class_time']
  end

end
