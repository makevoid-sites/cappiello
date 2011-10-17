# encoding: utf-8



hashes = <<-ASD
{"utf8"=>"✓", "_method"=>"put", "authenticity_token"=>"UuaQ+3asdasUhuzIDr5bdDARgK7hzTxTNtA3LDnJxpMpvQ=", "user"=>{blabla}, "commit"=>"Invia"}
ASD
require 'date'


namespace :import do

  desc "borse"
  task :borse => :environment do
    
    
    hashes.split("\n").each do |info|

      user = eval(info.strip)["user"]
      # puts user["email"]

      # puts "u = User.first(email: '#{user["email"]}'); \"\#{u.address} - \#{u.qualification} - \#{u.birthdate} - \#{u.info3}\""

      email = user["email"]

      fields = %w(utf8 _method first_name last_name email)
      fields.each do |field|
        user.delete field
      end
      user["birthdate"] = Date.parse "#{user["birthdate(1i)"]}/#{user["birthdate(2i)"]}/#{user["birthdate(3i)"]}"
      # puts user["birthdate"]
      # puts "u = User.first(email: '#{user["email"]}'); u.update_attributes(#{user})"


      usr = User.first(email: email)
      res = usr.update(user)
      p usr.errors
      # p usr = User.first(email: email)
      # UserMailer.admin_borsa(usr).deliver
    end
    
  end
  
end