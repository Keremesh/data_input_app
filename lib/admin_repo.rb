require_relative './admin'
require 'bcrypt'

class AdminRepository

  def all
    sql = 'SELECT id, username, password FROM admins;'
    result_set = DatabaseConnection.exec_params(sql, [])

    admins = []

    result_set.each do |admin|
      new_admin = Admin.new

      new_admin.id = admin['id'].to_i
      new_admin.username = admin['username']
      new_admin.password = admin['password']

      admins << new_admin
    end
    return admins
  end

  def create(admin)
    encrypted_password = BCrypt::Password.create(admin.password)

    sql = 'INSERT INTO admins(username, password) VALUES ($1, $2);'
    params = [admin.username, encrypted_password]
    
    DatabaseConnection.exec_params(sql, params)

    return nil
  end

  def find_by_username(username)
    sql = 'SELECT id, username, password FROM admins WHERE username = $1;'
    params = [username]
    result_set = DatabaseConnection.exec_params(sql, params)

    admin = Admin.new
    admin.id = result_set[0]['id']
    admin.username = result_set[0]['username']
    admin.password = result_set[0]['password']
333
    return admin
  end

  def sign_in(username, submitted_password)
    admin = find_by_username(username)

    return nil if admin.nil?

    stored_password = BCrypt::Password.new(admin.password)
    # stored_password = admin.password
    # hashed_submitted_password = BCrypt::Password.create(submitted_password)

    if stored_password.is_password?(submitted_password)
      return "hello"
    else 
      return "don't good!"
    end
#   puts "Stored Password: #{admin.password}"
#   puts "Submitted Password: #{submitted_password}"
#     puts "Hashed submitted Password: #{hashed_submitted_password}"

#    admin.password.is_password?(hashed_submitted_password)
    # admin.password == hashed_submitted_password

    # submitted_password = BCrypt::Password.new(admin.password)

  end

end

#   # Gets a single record by its ID
#   # One argument: the id (number)
#   def find(id)
#     # Executes the SQL query:
#     # SELECT id, name, cohort_name FROM students WHERE id = $1;

#     # Returns a single Student object.
#   end

#   def create(admin)
#   # INSERT INTO admins(username,password) VALUES ($1, $2)
#   end

#   def update(admin)
# # UPDATE [table name] SET [column_name] = [new_value], [other_column_name] = [other_new_value];
# # UPDATE albums SET title = 'New title' WHERE date='16th of November 2020';
#   end

#   def delete(admin)
# # DELETE FROM [table name] WHERE [conditions];
#   end

