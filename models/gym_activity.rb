require_relative( '../db/sql_runner' )

class Activity
  attr_reader :id

  def initialize(options)
    @id = options['id'] if options['id']
    @activity_name = options['activity_name']
  end

  def save()
    sql = "INSERT INTO gym_activities
    (
      activity_name
    )
    VALUES
    (
      $1
    )
    RETURNING id"
    values = [@activity_name]

    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def update
    sql = "UPDATE gym_activities SET (activity_name = $1
    WHERE id = $2"
    values = [@activity_name, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM gym_activities"
    results = SqlRunner.run( sql )
    return results.map { |hash| Activity.new( hash) }
  end

  def self.find( id )
    sql = "SELECT * FROM gym_activities
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run( sql, values )
    return Activity.new( results.first )
  end

  def self.delete_all
    sql = "DELETE FROM gym_activities"
    SqlRunner.run( sql )
  end

  def delete
    sql = "DELETE FROM gym_activities WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

end
