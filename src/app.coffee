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

# Setup Model
mongoose.connect 'mongodb://localhost/example'
app.locals.db = mongoose

model = require './model'
app.locals.model = model app

# Set the public folder as static assets.
app.use express.static(process.cwd() + '/public')

app.use cookieParser()
app.use session(
  secret: "wawawewawou"
  saveUninitialized: false
  key: "sid"
  resave: false
)

app.use bodyParser.json()

routes = require './routes'
routes app

app.all '/*', (req, res, next) ->
  res.sendFile 'index.html',
    root: process.cwd() + '/public'

app.listen(app.port)
