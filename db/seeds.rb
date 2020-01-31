require_relative '../models/gym_activity'
require_relative '../models/gym_booking'
require_relative '../models/gym_class'
require_relative '../models/gym_member'
require 'pry'

Booking.delete_all()
GymClass.delete_all()
Activity.delete_all()
Member.delete_all()


# Gym members:
# john
options_hash_john = {
  'member_name' => 'John',
  'member_surname' => 'Smithers',
  'membership_status' => 'premium',
  'member_activation_status' => 'active'
}
john = Member.new(options_hash_john)
john.save
# maria
options_hash_maria = {
  'member_name' => 'Maria',
  'member_surname' => 'Paul',
  'membership_status' => 'standard',
  'member_activation_status' => 'active'
}
maria = Member.new(options_hash_maria)
maria.save
# joseph
options_hash_joseph = {
  'member_name' => 'Joseph',
  'member_surname' => 'Star',
  'membership_status' => 'premium',
  'member_activation_status' => 'active'
}
joseph = Member.new(options_hash_joseph)
joseph.save
# carl
options_hash_carl = {
  'member_name' => 'Carl',
  'member_surname' => 'Cox',
  'membership_status' => 'standard',
  'member_activation_status' => 'active'
}
carl = Member.new(options_hash_carl)
carl.save
# dan
options_hash_dan = {
  'member_name' => 'Dan',
  'member_surname' => 'Single',
  'membership_status' => 'premium',
  'member_activation_status' => 'active'
}
dan = Member.new(options_hash_dan)
dan.save
# gabriel
options_hash_gabriel = {
  'member_name' => 'Gabriel',
  'member_surname' => 'Baker',
  'membership_status' => 'standard',
  'member_activation_status' => 'active'
}
gabriel = Member.new(options_hash_gabriel)
gabriel.save
# lucy
options_hash_lucy = {
  'member_name' => 'Lucy',
  'member_surname' => 'Smith',
  'membership_status' => 'premium',
  'member_activation_status' => 'active'
}
lucy = Member.new(options_hash_lucy)
lucy.save
# mathiew
options_hash_mathiew = {
  'member_name' => 'Mathiew',
  'member_surname' => 'Denniston',
  'membership_status' => 'standard',
  'member_activation_status' => 'active'
}
mathiew = Member.new(options_hash_mathiew)
mathiew.save
#------------------------------------------------
# Activities:
# boxing
options_hash_boxing = {
  'activity_name' => 'boxing'
}
boxing = Activity.new(options_hash_boxing)
boxing.save
# callisthenics
options_hash_callisthenics = {
  'activity_name' => 'callisthenics'
}
callisthenics = Activity.new(options_hash_callisthenics)
callisthenics.save
# booty camp
options_hash_booty_camp = {
  'activity_name' => 'booty camp'
}
booty_camp = Activity.new(options_hash_booty_camp)
booty_camp.save
# yoga
options_hash_yoga = {
  'activity_name' => 'yoga'
}
yoga = Activity.new(options_hash_yoga)
yoga.save
# breakdance
options_hash_breakdance = {
  'activity_name' => 'breakdance'
}
breakdance = Activity.new(options_hash_breakdance)
breakdance.save
# -------------------------------------------------
# gym_classes(basically an activity that takes place at certain time and has capacity of 10), and activation status.

# boxing class at 18:00
options_hash_boxing_18_00 = {
  'activity_id' => boxing.id,
  'class_time' => '18:00',
  'class_capacity' => 10,
  'class_activation_status' => 'active'
}
boxing_class_18_00 = GymClass.new(options_hash_boxing_18_00)
boxing_class_18_00.save
# boxing class at 10:00
options_hash_boxing_10_00 = {
  'activity_id' => boxing.id,
  'class_time' => '10:00',
  'class_capacity' => 10,
  'class_activation_status' => 'active'
}
boxing_class_10_00 = GymClass.new(options_hash_boxing_10_00)
boxing_class_10_00.save
# callisthenics class at 18:00
options_hash_callisthenics_18_00 = {
  'activity_id' => callisthenics.id,
  'class_time' => '18:00',
  'class_capacity' => 10,
  'class_activation_status' => 'active'
}
callisthenics_class_18_00 = GymClass.new(options_hash_callisthenics_18_00)
callisthenics_class_18_00.save
# callisthenics class at 10:00
options_hash_callisthenics_10_00 = {
  'activity_id' => callisthenics.id,
  'class_time' => '10:00',
  'class_capacity' => 10,
  'class_activation_status' => 'active'
}
callisthenics_class_10_00 = GymClass.new(options_hash_callisthenics_10_00)
callisthenics_class_10_00.save
# booty camp class at 18:00
options_hash_booty_camp_18_00 = {
  'activity_id' => booty_camp.id,
  'class_time' => '18:00',
  'class_capacity' => 10,
  'class_activation_status' => 'active'
}
booty_camp_class_18_00 = GymClass.new(options_hash_booty_camp_18_00)
booty_camp_class_18_00.save
# booty camp class at 10:00
options_hash_booty_camp_10_00 = {
  'activity_id' => booty_camp.id,
  'class_time' => '10:00',
  'class_capacity' => 10,
  'class_activation_status' => 'active'
}
booty_camp_class_10_00 = GymClass.new(options_hash_booty_camp_10_00)
booty_camp_class_10_00.save
# yoga class at 18:00
options_hash_yoga_18_00 = {
  'activity_id' => yoga.id,
  'class_time' => '18:00',
  'class_capacity' => 10,
  'class_activation_status' => 'active'
}
yoga_class_18_00 = GymClass.new(options_hash_yoga_18_00)
yoga_class_18_00.save
# yoga class at 10:00
options_hash_yoga_10_00 = {
  'activity_id' => yoga.id,
  'class_time' => '10:00',
  'class_capacity' => 10,
  'class_activation_status' => 'active'
}
yoga_class_10_00 = GymClass.new(options_hash_yoga_10_00)
yoga_class_10_00.save
# breakdance class at 18:00
options_hash_breakdance_18_00 = {
  'activity_id' => breakdance.id,
  'class_time' => '18:00',
  'class_capacity' => 10,
  'class_activation_status' => 'active'
}
breakdance_class_18_00 = GymClass.new(options_hash_breakdance_18_00)
breakdance_class_18_00.save
# breakdance class at 10:00
options_hash_breakdance_10_00 = {
  'activity_id' => breakdance.id,
  'class_time' => '10:00',
  'class_capacity' => 10,
  'class_activation_status' => 'active'
}
breakdance_class_10_00 = GymClass.new(options_hash_breakdance_10_00)
breakdance_class_10_00.save
# ------------------------------------------------
# bookings:










#
