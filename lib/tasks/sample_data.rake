#Encoding: UTF-8
namespace :db do
  desc "Peupler la base de données"
  task :populate => :environment do
    require 'faker'
    Rake::Task['db:reset'].invoke
    administrator = User.create!(:lastname => "Utilisateur nom exemple",
                 :firstname => "Utilisateur prénom exemple",
                 :email => "example@railstutorial.org",
                 :password => "foobar",
                 :password_confirmation => "foobar")
    administrator.toggle!(:admin)
    99.times do |n|
      firstname  = Faker::Name.first_name
      lastname = Faker::Name.last_name
      email = "example-#{n+1}@railstutorial.org"
      password  = "motdepasse"
      User.create!(:lastname => lastname,
                   :firstname => firstname,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
    i=1
    User.all(:limit => 6).each do |user|
      6.times do |n|
        first_name  = Faker::Name.first_name
        last_name = Faker::Name.last_name
        phone_number = "010101010#{n+(10*i)}"
        email = "example-#{n+1}@railstutorial.org"               
        user.prospects.create!( :last_name => last_name,
                                :first_name => first_name,
                                :phone_number_1 => phone_number,
                                :email => email)
      
      end
      i+= 1
    end
    
    User.all(:limit => 6).each do |user|
      50.times do
        user.microposts.create!(:content => Faker::Lorem.sentence(5))
      end
    end
  end
end