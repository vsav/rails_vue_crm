# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
clients = Client.create([
                            {
                              email: 'john@test.com',
                              password: 'qwe123',
                              password_confirmation: 'qwe123',
                              full_name: 'John Connor',
                              phone: '2233222'
                            },
                            {
                              email: 'sarah@test.com',
                              password: 'qwe123',
                              password_confirmation: 'qwe123',
                              full_name: 'Sarah Connor',
                              phone: '3322223'
                            },
                            {
                              email: 'kyle@test.com',
                              password: 'qwe123',
                              password_confirmation: 'qwe123',
                              full_name: 'Kyle Reese',
                              phone: '1132423'
                            }])
