configure do
  # Log queries to STDOUT in development
  if Sinatra::Application.development?
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    set :database, {
      adapter: "sqlite3",
      database: "db/db.sqlite3"
    }
  else
    db = URI.parse(ENV['DATABASE_URL'])
    set :database, {
      adapter: "postgresql",
      host: db.host,
      username: db.user,
      password: db.password,
      database: db.path[1..-1],
      encoding: "utf8"
    }
  end

