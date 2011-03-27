require 'spec_helper'

describe "Main" do
  describe "GET /" do
    visit root_path
    page.should have_content("L'Accademia")
  end
end
