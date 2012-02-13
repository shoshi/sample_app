# Run `bundle exec rake db:populate` to create 100 fake users

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_microposts
    make_relationships
  end
end

def make_users
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
end

def make_microposts
  User.all(:limit => 6).each do |user|
    50.times do
      content = Faker::Lorem.sentence(5)
      user.microposts.create!(:content => content)
    end
  end
end

def make_relationships
  users = User.all
  user  = User.first
  following = users[1..50]
  followers = users[3..40]
  following.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end
