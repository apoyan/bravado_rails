# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Company.find_or_create_by(number: 1) do |company|
  company.name = 'Google'
end

Company.find_or_create_by(number: 2) do |company|
  company.name = 'Yandex'
end

Company.find_or_create_by(number: 3) do |company|
  company.name = 'Pikabu'
end

Company.import