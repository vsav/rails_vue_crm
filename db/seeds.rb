# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
clients = Client.create!([
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
                            },
                            {
                              email: 'max@test.com',
                              password: 'qwe123',
                              password_confirmation: 'qwe123',
                              full_name: 'Max Cavalera',
                              phone: '123213'
                            },
                            {
                              email: 'igor@test.com',
                              password: 'qwe123',
                              password_confirmation: 'qwe123',
                              full_name: 'Igor Cavalera',
                              phone: '185924'
                            },
                            {
                              email: 'luke@test.com',
                              password: 'qwe123',
                              password_confirmation: 'qwe123',
                              full_name: 'Luke Skywalker',
                              phone: '1432343'
                            }])
Staff.create!(email: 'admin@staff.com', password: 'qwe123', password_confirmation: 'qwe123')

organizations = Organization.create!([
                            {
                              name: 'Orion',
                              structure: 'OOO',
                              inn: '123123123',
                              ogrn: '1334523473645'
                            },
                            {
                              name: 'Mars',
                              structure: 'ZAO',
                              inn: '1257483319',
                              ogrn: '1354273748251'
                            },
                            {
                              name: 'Venus',
                              structure: 'OAO',
                              inn: '345234234',
                              ogrn: '6723489730192'
                            },
                            {
                              name: 'Earth',
                              structure: 'OAO',
                              inn: '7483623423',
                              ogrn: '4628764230172'
                            },
                            {
                              name: 'Jupiter',
                              structure: 'ZAO',
                              inn: '847349534',
                              ogrn: '4563872343012'
                            },
                            {
                              name: 'Saturn',
                              structure: 'ZAO',
                              inn: '812319534',
                              ogrn: '4764523428142'
                            },
                            {
                              name: 'Neptune',
                              structure: 'ZAO',
                              inn: '8486428934',
                              ogrn: '4462837847182'
                            },
                            {
                              name: 'Uranus',
                              structure: 'ZAO',
                              inn: '898234423',
                              ogrn: '4564823440172'
                            },])
clients[0].organizations.push(organizations[2], organizations[3])
clients[1].organizations.push(organizations[2], organizations[3])
clients[2].organizations.push(organizations[2])
clients[3].organizations.push(organizations[0], organizations[1])
clients[4].organizations.push(organizations[0])
clients[5].organizations.push(organizations[4], organizations[5], organizations[6], organizations[7])
