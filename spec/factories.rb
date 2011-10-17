#Encoding: UTF-8

# En utilisant le symbole ':user', nous faisons que
# Factory Girl simule un modèle User.
Factory.define :user do |user|
  user.firstname             "Michael"
  user.lastname              "Hartl"
  user.email                 "mhartl@example.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :micropost do |micropost|
  micropost.content "Foo bar"
  micropost.association :user
end

Factory.define :prospect do |prospect|
  prospect.last_name "Foo bar"
  prospect.first_name "Albert"
  prospect.civility "M."
  prospect.birthday "1987-08-13"
  prospect.address "13 rue Ernest Psichari"
  prospect.postal_code "75000"
  prospect.city "Paris"
  prospect.phone_number_1 "0123456789"
  prospect.phone_number_2 "0123456710"
  prospect.email "test@test.fr"
  prospect.marital_status "Marié"
  prospect.nb_in_household "1"
  prospect.income "30000"
  prospect.imposition "5000"
  prospect.taxes "30000"
  prospect.debt_ratio "500"
  prospect.day "2013-01-01"
  prospect.place  "Café de la cité"
  prospect.meeting false
  prospect.to_classify false
  prospect.to_call_on "2011-10-01 19:00:00"
  prospect.comments "X"
  prospect.association :user
end

Factory.sequence :phone_number_1 do |n|
  "010101010#{n}"
end