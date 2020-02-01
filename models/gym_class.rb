require_relative( '../db/sql_runner' )


class GymClass
  attr_reader :id, :class_activation_status, :class_time, :activity_id
  attr_accessor :class_capacity

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @activity_id = options['activity_id'].to_i
    @class_time = options['class_time']
    @class_capacity = options['class_capacity'].to_i
    @class_activation_status = options['class_activation_status']
  end


  def save()
    sql = "INSERT INTO gym_classes
    (
      activity_id,
      class_time,
      class_capacity,
      class_activation_status
    )
    VALUES
    (
      $1, $2, $3, $4
    )
    RETURNING id"
    values = [@activity_id, @class_time, @class_capacity, @class_activation_status]

    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def update
    sql = "UPDATE gym_classes SET (activity_id, class_time, class_capacity, class_activation_status ) = ($1, $2, $3, $4)
    WHERE id = $5"
    values = [@activity_id, @class_time, @class_capacity, @class_activation_status, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM gym_classes"
    results = SqlRunner.run( sql )
    results = results.map { |hash| GymClass.new(hash) }
    return results
  end

  def self.find( id )
    sql = "SELECT * FROM gym_classes
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run( sql, values )
    return GymClass.new( results.first )
  end

  def self.find_by_activity_and_time(hash)
    sql = "SELECT * FROM gym_classes
    WHERE activity_id = $1 AND class_time = $2 "
    values = [hash['activity_id'].to_i,hash['class_time']]
    results = SqlRunner.run( sql, values )
    return GymClass.new( results.first )
  end

  def self.delete_all
    sql = "DELETE FROM gym_classes"
    SqlRunner.run( sql )
  end

  def delete
    sql = "DELETE FROM gym_classes WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

  # members booked




end
