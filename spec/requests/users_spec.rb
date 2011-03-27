require 'spec_helper'

describe "Users" do
  describe "visitor" do
    describe "form" do
      describe "GET /" do
        visit "/"
        page.should have_content("L'Accademia")
      end
    end
  end
  
  describe "authenticated" do
    
  end
end
