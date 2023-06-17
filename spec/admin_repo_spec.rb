require 'admin_repo'
require 'admin'
require 'database_connection'
require 'bcrypt'

RSpec.describe AdminRepository do

  def reset_admins_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'statsy' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_admins_table
  end

  after(:all) do
    reset_admins_table
  end

  it "returns all admins" do
    repo = AdminRepository.new

    admins = repo.all

    expect(admins.length).to eq 2

    expect(admins[0].id).to eq 1
    expect(admins[0].username).to eq 'TestAdmin'
    expect(admins[0].password).to eq '$2a$12$FiILcMtM1ndfnBeW0sAy.uooRAt1w5kKefZILfPOrFCvfYyf8FUNG'


    expect(admins[1].id).to eq 2
    expect(admins[1].username).to eq 'TestAdmin2'
    # expect(BCrypt::Password.new(admins[0].password)).to eq 'admin2'

  end

  it "creates a new admin" do
    repo = AdminRepository.new
    admin = Admin.new
    admin.username = "NewAdmin"
    admin.password = BCrypt::Password.create("newadmin")
    repo.create(admin)
    admins = repo.all

    expect(admins.length).to eq 3
    expect(admins.last.username).to eq "NewAdmin"
    expect(admins.last.password).to include "$2a$"
    # expected "$2a$12$kqS27wUX.GN.d4BnfOSIAeRvgY864ebL5x.UnB3Ri/Tly6JA04Sz2" to include "$sd2a$"
  end

  context "handle sign-in" do
    it "finds the admin by username" do
      repo = AdminRepository.new
      admin = repo.find_by_username('TestAdmin')
      expect(admin.id).to eq('1')
    end

    xit "returns OK if the admin supplies a correct username/password combo" do
      repo = AdminRepository.new
      # sign_in_result = repo.sign_in('TestAdmin', 'admin')
      # expect(sign_in_result).to eq(true)
      test_admin = Admin.new
      test_admin.username = 'TestAdmin1'
      test_admin.password = BCrypt::Password.create('admin')
      repo.create(test_admin)

      # Attempt to sign in with the correct username/password
      sign_in_result = repo.sign_in('TestAdmin1', 'admin')

      expect(sign_in_result).to eq("hello")
    end

    xit "returns false if the admin supplies incorrect username/password combo" do
      repo = AdminRepository.new
      sign_in_result = repo.sign_in('bmckue3@hostgator.com', 'jamespates')
    end
  end
end