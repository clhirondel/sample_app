#Encoding: UTF-8
namespace :db do
  desc "Add the default roles."
  task :roles => :environment do
    Role.create( :name => 'Prospector')
    Role.create( :name => 'ProspectManager')
  end
end