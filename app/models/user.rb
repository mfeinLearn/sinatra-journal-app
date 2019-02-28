class User < ActiveRecord::Base
  has_secure_password
  # bcrypt gives us this method - this allows us to user
  # a activerecord method called authenticate.
  # authenticate takes in a password which is a plan string
  # and checks it agenst bcrypts hashing algurithum to make sure it is
  # the correct password

  # in forms and our controller we can say password when we
  # want to refer to our password

    # ACTIVERECORD VALIDATIONS - adding more validations into our user model:

  # validates is a method invocation
  # name is the thing that is beign validated
  # presence: true - key value pair
#  these validations will pervent ActiveRecord from:
#  - creation saving updating from the database if these requirements are not meet
  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true

# when do validations get called?
# save, create update, valid  
  has_many :journal_entries
end
