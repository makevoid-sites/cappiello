require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Users", %q{
  In order to subscribe / obtain infos
  As a user
  I want to send my personal infos
} do
  before do
    User.all.each{ |u| u.destroy }
  end
  
  feature "Visitor" do
    scenario "post form" do
      visit "/pages/form"
      page.should have_content("RICHIESTA INFORMAZIONI")
      within(".forms_form") do
        fill_in "Nome", with: "Francesc0"
        fill_in "Cognome", with: "Canessa"
        fill_in "Email", with: "m4kevoid@gmail.com"
        fill_in "password", with: "final"
        click_on "Invia"
      end
      #puts page.body.inspect
      
      page.should have_content("Francesc0 Canessa")
    end
  end
  
  feature "Authenticated" do
    scenario "post form" do
      visit "/pages/form"
      page.should have_content("RICHIESTA INFORMAZIONI")
    end
  end
end
