require_relative( '../db/sql_runner' )
require 'pry'

class Booking

  attr_accessor :id, :gym_member_id, :gym_class_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @gym_member_id = options['gym_member_id'].to_i
    @gym_class_id = options['gym_class_id'].to_i
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

  # def self.find_gym_class_by_id(gym_class_id)
  #
  # end


  def edit_booking(new_member_obj,old_gym_class_obj,new_gym_class_obj)

    if new_member_obj.member_activation_status == 'active'
      if new_gym_class_obj.class_activation_status == 'active'

        if new_gym_class_obj.class_capacity > 0

          # check how many characters time string has, in case we retrieve data from db where the format is 00:00:00:
          # 17:00 - 5, OK
          # 17:00:00 - 8, needs converted
          if new_gym_class_obj.class_time.length == 8
             # remove the last 3 digits
             new_gym_class_obj.class_time = new_gym_class_obj.class_time[0...-3]
          end

          new_class_time_int = new_gym_class_obj.class_time.gsub(/:/, "").to_i
          # peak times: 17:00 to 20:00
          # peak times int - 1700 to 2000
          if new_member_obj.membership_status == 'standard' && new_class_time_int.between?(1700, 2000)

            return "Only premium members are eligible for peak-time(17:00 to 20:00) classes. Please upgrade to premium or select a non-peak class."
          end

          old_gym_class_obj.class_capacity += 1
          old_gym_class_obj.update()
          new_gym_class_obj.class_capacity -= 1
          new_gym_class_obj.update()

          @gym_member_id = new_member_obj.id
          @gym_class_id =  new_gym_class_obj.id
          update
        else
          return "Sorry, but the class is now fully booked. Please select another class/time"
        end
      end
      return "Sorry but the class is currently deactivated. Please select another class."
    end
    return "Sorry, but your membership is deactivated"
  end


end
