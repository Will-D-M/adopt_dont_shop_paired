# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
mikes_shelter = Shelter.create(name: "Mike's Shelter",
  address: "1331 17th Street", city: "Denver", state: "CO", zip: "80202")

megs_shelter = Shelter.create(name: "Meg's Shelter", address: "150 Main Street",
city: "Hershey", state: "CO", zip: "17033")

athena = Pet.create(image: "https://images-ra.adoptapet.com/images/Homepage-DogV2.png",
name: "Athena",
# description: "butthead",
approximate_age: 1,
sex: "female",
# status: "adoptable",
shelter_name: "Mike's Shelter",
shelter_id: mikes_shelter.id)

odell = Pet.create(image: "https://imgix.bustle.com/uploads/getty/2019/11/18/6296727a-d38c-40b4-8ffe-dbec5cd1b289-getty-954967324.jpg?w=1020&h=576&fit=crop&crop=faces&auto=format&q=70",
name: "Odell",
# description: "good dog",
approximate_age: 4,
sex: "male",
# status: "adoptable",
shelter_name: "Meg's Shelter",
shelter_id: megs_shelter.id)

#run this with 'rails db:seed' after pet show
