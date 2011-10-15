#Encoding: UTF-8
require 'spec_helper'

describe "FriendlyForwardings" do
 
  it "devrait rediriger vers la page voulue après identification" do
    user = Factory(:user)
    visit edit_user_path(user)
    # Le test suit automatiquement la redirection vers la page d'identification.
    fill_in "Email",    :with => user.email
    fill_in "Mot de passe", :with => user.password
    click_button
    # Le test suit à nouveau la redirection, cette fois vers users/edit.
    response.should render_template('users/edit')
  end
end
