require './sample/login_app/database'

class SessionsController < Chespirito::Controller
  VIEWS_PATH = './sample/login_app/views'

  def destroy
    headers = {
      'Set-Cookie' => 'email=; path=/; HttpOnly; Expires=Thu, 01 Jan 1970 00:00:00 GMT',
      'Location' => "http://#{request.headers['Host'] || 'localhost:3000'}/"
    }

    response.status  = 301
    response.headers = headers
  end

  def create
    email    = request.params['email']
    password = request.params['password']
    user     = Database.users[email]

    if user && user[:password] == password
      headers = {
        'Set-Cookie' => "email=#{email}; path=/; HttpOnly",
        'Location' => "http://#{request.headers['Host'] || 'localhost:3000'}/"
      }

      response.status  = 301
      response.headers = headers
    else
      response.status = 401
      response.headers = { 'Content-Type' => 'text/html' }
      response.body = view("#{VIEWS_PATH}/unauthorized.html")
    end
  end
end
