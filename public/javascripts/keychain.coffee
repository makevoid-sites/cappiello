bc = require 'bitcore'
PrivateKey = bc.PrivateKey

class SMSGateway
  def initialize()
    @sms = TextMagic
  end
end


class SMSAuth
  @gate = SMSGateway

  generate_code: () ->
    "12345"

  constructor: (@user_num) ->
    @gen_code = generate_code()

  sms: ->
    gate.send to: @user_num, code: @gen_code


class Keychain
  @store = localStorage

  key_found: ->
    @store.privateKey

  load: ->
    @key = if key_found?
      @key
    else
      new PrivateKey


KEYCHAIN = new Keychain

web_component = ->
  SMS_server_host = ""


route '/logout', ->

route "/login", ->
  password "12 words"
  login_via_email_link

route "/recover", ->
  SMS.recovery_sms ""



route "/", ->


# flow:

# register, generate bitcoin address


key = new Keychain
key.load
