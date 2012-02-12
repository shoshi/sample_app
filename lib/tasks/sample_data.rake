# Run `bundle exec rake db:populate` to create 100 fake users

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name                  => "Monkey",
                         :email                 => "monkey@example.com",
                         :password              => "foobar",
                         :password_confirmation => "foobar")
    admin.toggle!(:admin)
    User.create!(:name                  => "Example User",
                 :email                 => "example@example.com",
                 :password              => "foobar",
                 :password_confirmation => "foobar")
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@example.com"
      password = "password"
      User.create!(:name                  => name,
                   :email                 => email,
                   :password              => password,
                   :password_confirmation => password)
    end

    50.times do
      User.all(:limit => 6).each do |user|
        user.microposts.create!(:content => Faker::Lorem.sentence(5))
      end
    end
  end
end