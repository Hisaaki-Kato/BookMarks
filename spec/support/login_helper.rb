module LoginHelper
  def log_in_as(user)
    visit root_path
    click_link "ログイン"
    fill_in "session[email]",	with: user.email
    fill_in "session[password]",	with: user.password
    within ".session-login-form" do
      click_button "ログイン"
    end
  end
end