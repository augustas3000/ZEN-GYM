require_relative( '../db/sql_runner' )

class Activity

  attr_accessor :id, :activity_name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @activity_name = options['activity_name']
  end

  def save()
    # to ensure we do not save duplicate activities
    if name_unique?
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
    else
      return "The activity you are trying to create is already on the list"
    end

  end

  def name_unique?
    all = Activity.all
    all_activities = all.map {|object| object.activity_name}

    if all_activities.include?(@activity_name)
      return false
    else
      return true
    end
  end


  def update
    sql = "UPDATE gym_activities SET activity_name = $1
    WHERE id = $2"
    values = [@activity_name, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM gym_activities"
    results = SqlRunner.run( sql )
    results = results.map { |hash| Activity.new( hash) }
    return results
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


  def change_name(name_str)
     all = Activity.all
     all = all.map {|object| object.activity_name}

     if all.include?(name_str)
      return "Sorry, but such activity is already present in the list, type in a different activity."
     else
      @activity_name = name_str
      update
     end
  end

  def name_by_id
    sql = "SELECT gym_activities.activity_name FROM gym_activities WHERE gym_activities.id = $1"
    value = [@id]
    result = SqlRunner.run(sql, values)
    result = result[0]['activity_name']
    return result
  end

end
