class Database
  attr_reader :users

  def initialize
    @users = {
      'user@example.com'  => { password: 'pa$$w0rd' },
      'admin@example.com' => { password: 'pa$$w0rd' }
    }
  end

  def self.users = new.users
end
