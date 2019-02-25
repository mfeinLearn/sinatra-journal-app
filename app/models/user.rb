class User < ActiveRecord::Base
  has_secure_password
  # bcrypt gives us this method - this allows us to user
  # a activerecord method called authenticate.
  # authenticate takes in a password which is a plan string
  # and checks it agenst bcrypts hashing algurithum to make sure it is
  # the correct password

  # in forms and our controller we can say password when we
  # want to refer to our password 

  has_many :journal_entries
end
