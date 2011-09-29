# -*- coding: iso-8859-1 -*-
require "spec_helper"


describe "as a guest on the sign in page" do

  let(:user) { Factory(:user) }

  before do
    visit root_path
    click_link "Sign in"
  end

  context "with valid credentials" do

    before do
      fill_in "Email", :with => user.email
      fill_in "Password", :with => "123456"
      click_button "Sign in"
    end

    it "has a sign out link" do
      page.should have_xpath("//a", :text => "Logout")
    end

    it "knows who I am" do
      page.should have_content("Welcome, #{user.email}")
    end

  end

  context "with invalid credentials" do

    #No form entry should produce an error
    before do
      click_button "Sign in"
    end

    it "has errors" do
      page.should have_xpath("//div[@id='flash_alert']")
    end

  end

end
