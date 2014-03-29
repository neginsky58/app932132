# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create Admin User

Admin.find_or_create_by_username(username: 'admin', password: 'admin')
Admin.find_or_create_by_username(username: 'admin1', password: 'admin1')
Admin.find_or_create_by_username(username: 'admin2', password: 'admin2')



# Create UserGroup 
UserGroup.find_or_create_by_value(value: 1, name: 'SUPER ADMIN', desc: 'SUPER ADMIN')
UserGroup.find_or_create_by_value(value: 2, name: 'GENERAL ADMIN', desc: 'GENERAL ADMIN')
UserGroup.find_or_create_by_value(value: 3, name: 'CIRCLE ADMIN', desc: 'CIRCLE ADMIN')
UserGroup.find_or_create_by_value(value: 4, name: 'PAID USER', desc: 'PAID USER')
UserGroup.find_or_create_by_value(value: 5, name: 'TRIAL USER', desc: 'TRIAL USER')
UserGroup.find_or_create_by_value(value: 6, name: 'BANNED USER', desc: 'BANNED USER')


# Creat clothing categories
Category.find_or_create_by_name(name: 'Clothings', desc: 'Clothings')
Category.find_or_create_by_name(name: 'Electronics', desc: 'Electronics')
Category.find_or_create_by_name(name: 'Gorden Supplies', desc: 'Gorden Supplies')
Category.find_or_create_by_name(name: 'Household Goods', desc: 'Household Goods')
Category.find_or_create_by_name(name: 'Toys', desc: 'Toys')

# Creat Size categories
Size.find_or_create_by_name(name: '0-2', desc: '0-2')
Size.find_or_create_by_name(name: '4-6', desc: '4-6')
Size.find_or_create_by_name(name: '8-12', desc: '8-12')
Size.find_or_create_by_name(name: '14-18', desc: '14-18')
Size.find_or_create_by_name(name: '20+', desc: '20+')

# Create PersonType categories
PersonType.find_or_create_by_name(name: 'Womens', desc: 'Womens')
PersonType.find_or_create_by_name(name: 'Mens', desc: 'Mens')
PersonType.find_or_create_by_name(name: 'Kids-Girl', desc: 'Kids-Girl')
PersonType.find_or_create_by_name(name: 'Kids-Boys', desc: 'Kids-Boys')
PersonType.find_or_create_by_name(name: 'Unisex', desc: 'Unisex')


# Create ItemState 
ItemState.find_or_create_by_value(value: 1, name: "AVAILABLE", desc: "Available")
ItemState.find_or_create_by_value(value: 2, name: "PENDING", desc: "Pending")
ItemState.find_or_create_by_value(value: 3, name: "CLOSED", desc: "Closed")
ItemState.find_or_create_by_value(value: 4, name: "FLAGGED", desc: "sUSPENDED")

# Create Condition
Condition.find_or_create_by_value(value: 1, name: "NEW", desc: "With or without tags, not laundered")
Condition.find_or_create_by_value(value: 2, name: "LIKENEW", desc: "No visible signs of wear")
Condition.find_or_create_by_value(value: 3, name: "GENUSED", desc: "Minor signs of wear, not damage")
Condition.find_or_create_by_value(value: 4, name: "WORN", desc: "Scratched, pilling, dinged, may have holes")


## Create Circles   
Circle.find_or_create_by_zipcode(zipcode: '61259', name: 'Illinois City', city: 'Illinois', state: 'IL', status: true)
Circle.find_or_create_by_zipcode(zipcode: '10007', name: 'New York City', city: 'New York', state: 'NY', status: true)
Circle.find_or_create_by_zipcode(zipcode: '10432', name: 'Los Angeles City', city: 'Los Angeles', state: 'LA', status: true)
Circle.find_or_create_by_zipcode(zipcode: '20432', name: 'San Diego City', city: 'San Diego', state: 'SD', status: true)


