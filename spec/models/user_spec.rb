path = File.expand_path "../../../", __FILE__
# pass = File.read(File.expand_path("~/.password")).strip

def require_glob(path)
  Dir.glob(path).each do |file|
    require file
  end
end

require 'bundler'
Bundler.require :default

DataMapper.setup :default, "mysql://localhost/cappiello_test"

require_glob "#{path}/app/models/*.rb"

DataMapper.finalize

describe User do
  it "should initialize" do
    User.new.should be_a(User)
  end

  it "should initialize with an empty pdfs downloaded array" do
    User.new.pdfs_downloaded.should == []
  end

  it "should add downloaded pdfs" do
    user = User.create!(first_name: "Francesco", last_name: "Canessa", nickname: "makevoid", email: "makevoid@gmail.com", password: "secret")
    user.pdfs_downloaded_add "abc"
    user.pdfs_downloaded.should == ["abc"]
  end

  after :all do
    User.all.map{ |u| u.destroy }
  end
end