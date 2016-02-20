
class String
  def singular; singularize; end
end


APP_NAME = Rails.application.class.name.split("::")[0].downcase
DEVELOPER_NAME = "Francesco Canessa"

APP_HOST = Rails.env == "development" ? "localhost:3000" : "accademia-cappiello.it"

require "haml"
require "haml/template"
Haml::Template.options[:escape_html] = false
Haml::Template.options[:ugly] = false

#require 'bluecloth'
require "RedCloth"

# require "dm-is-tree"
# require "dm-is-protectable"

# generators

# model
# script/generate model MODEL --skip-migration --no-test-framework

# monkeypatching

module Intyable
  def inty?
    self.to_i.to_s == self && self.to_i != 0
  end
end

class String
  include Intyable
end
class NilClass
  include Intyable
end

class String
  def title_urlize
    gsub(/\.|-/, '').gsub(/\s+|'/, "_").downcase
  end
end

class Exception
  def status_exception
    false
  end
  alias :status_exception? :status_exception
end

class NotFound < Exception
  attr_accessor :code, :status_exception

  def initialize
    @code = 404
    @status_exception = true
  end

  def message
    "Pagina non trovata"
  end
end
