require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Main", %q{
} do

  scenario "home" do
    visit root_path
    page.should have_content("L'Accademia")
  end
end
