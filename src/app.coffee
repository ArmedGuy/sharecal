express = require 'express'
session = require 'express-session'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'
mongoose = require 'mongoose'

#### Basic application initialization
# Create app instance.
app = express()

# Define Port & Environment
app.port = process.env.PORT or process.env.VMC_APP_PORT or 3000
env = process.env.NODE_ENV or "development"

mongoose.connect 'mongodb://localhost/example'
app.locals.db = mongoose

# Set the public folder as static assets.
app.use express.static(process.cwd() + '/public')

app.use cookieParser()
app.use session(
  secret: "wawawewawou"
  key: "sid"
  cookie:
    secure: true
)

app.use bodyParser()

routes = require './routes'
routes app


app.listen()
