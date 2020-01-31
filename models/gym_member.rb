require_relative( '../db/sql_runner' )
require 'pry'

class Member
  attr_reader :id, :member_name, :member_surname, :membership_status, :member_activation_status

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
          if @membership_status == 'standard' && class_obj.class_time == '18:00'
            return "Only premium members are eligible for evening classes. Please upgrade to premium or select a morning class."
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
        end
        return "Sorry, but the class is now fully booked. Please select another class/time"
      end
      return "Sorry but the class is currently deactivated. Please select another class."
    end
    return "Sorry, but your membership is deactivated"
  end

end
