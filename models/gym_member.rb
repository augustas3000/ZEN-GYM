require_relative( '../db/sql_runner' )
require 'pry'

class Member
  attr_accessor :id, :member_name, :member_surname, :membership_status, :member_activation_status

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @member_name = options['member_name']
    @member_surname = options['member_surname']
    @membership_status = options['membership_status']
    @member_activation_status = options['member_activation_status']
  end

  def save()
    sql = "INSERT INTO gym_members
    (
      member_name,
      member_surname,
      membership_status,
      member_activation_status
    )
    VALUES
    (
      $1, $2, $3, $4
    )
    RETURNING id"
    values = [@member_name, @member_surname, @membership_status, @member_activation_status]

    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def update
    sql = "UPDATE gym_members SET (member_name, member_surname, membership_status, member_activation_status ) = ($1, $2, $3, $4)
    WHERE id = $5"
    values = [@member_name, @member_surname, @membership_status, @member_activation_status, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM gym_members"
    results = SqlRunner.run( sql )
    return results.map { |hash| Member.new( hash) }
  end

  def self.find( id )
    sql = "SELECT * FROM gym_members
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run( sql, values )
    return Member.new( results.first )
  end

  def self.delete_all
    sql = "DELETE FROM gym_members"
    SqlRunner.run( sql )
  end

  def delete
    sql = "DELETE FROM gym_members WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

  def book_a_class(class_obj)
    if @member_activation_status == 'active'
      if class_obj.class_activation_status == 'active'
        if class_obj.class_capacity > 0

          # check how many characters time string has, in case we retrieve data from db where the format is 00:00:00:
          # 17:00 - 5, OK
          # 17:00:00 - 8, needs converted
          if class_obj.class_time.length == 8
             # remove the last 3 digits
             class_obj.class_time = class_obj.class_time[0...-3]
          end

          new_class_time_int = class_obj.class_time.gsub(/:/, "").to_i
          # peak times: 17:00 to 20:00
          # peak times int - 1700 to 2000
          if @membership_status == 'standard' && new_class_time_int.between?(1700, 2000)
            return "Only premium members are eligible for peak-time(17:00 to 20:00) classes. Please upgrade to premium or select a non-peak class."
          end

          # reduce class_obj capacity by 1
          class_obj.class_capacity -= 1
          class_obj.update()
          # create a booking
          options_hash_booking = {
            'gym_member_id' => @id,
            'gym_class_id' => class_obj.id
          }
          booking_obj = Booking.new(options_hash_booking)
          booking_obj.save
          return
        else
          return "Sorry, but the class is now fully booked. Please select another class/time"
        end
      end
      return "Sorry but the class is currently deactivated. Please select another class."
    end
    return "Sorry, but your membership is deactivated"
  end


  def self.deactivated_members()
    sql = "SELECT * FROM gym_members WHERE gym_members.member_activation_status = 'deactivated'"
    results = SqlRunner.run( sql )
    return results.map { |hash| Member.new( hash) }
  end

end
