First full stack project as part of Professional Software Development, CodeClan.

The first solo-project as part of week 4 at Code Clan. 
Description:

Gym
A local gym has asked you to build a piece of software to help them to manage memberships, and register members for classes.

MVP
The app should allow the gym to create and edit Members
(can be do

The app should allow the gym to create and edit Classes
The app should allow the gym to book members on specific classes
The app should show a list of all upcoming classes
The app should show all members that are booked in for a particular class
Inspired By
Glofox, Pike13

Possible Extensions
Classes could have a maximum capacity, and users can only be added while there is space remaining.
The gym could be able to give its members Premium or Standard membership. Standard members can only be signed up for classes during off-peak hours.
The Gym could mark members and classes as active/deactivated. Deactivated members/classes will not appear when creating bookings.

The project assumes database and server are established locally. 


Tools used:
Ruby Sinatra, postgresql, atom editor, class naming system BEM.
7 RESTful routes impletented to achieve CRUD functionality (slightly adjusted to allow creating bookings from
various locations - members view, classes view, bookings view.

Design: 4 main tables in postgresql database 'gym' - members, activities, classes, and bookings.
A gym class consists of activity name and corresponding class time. Members can be booked for classes and
classes can be assigned to members, as well as bookings can be created by inputing class and member from
dropdown list.  Attributes such as member activation status, member membership status, class activation status,
class time, and class capacity were used in conditionals to determine whether booking is successful or not.

To Run: Have Ruby, and Sinatra Installed. Have PostgreSQL installed with a db name - gym.

For more info contact me at augusto.pasaulis@gmail.com

