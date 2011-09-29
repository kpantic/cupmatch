# -*- coding: iso-8859-1 -*-
require "spec_helper"


describe "listing cups and creating a cup" do

  let(:user) { Factory(:user) }

  before do
    visit cups_path
  end

  context "as a guest" do

    it "shows all cups" do
      Cup.all.each do |cup|
        page.should have_xpath("//a",cup.name)
      end
    end

    it "new cup page redirects to sign in" do
      click_link "New Cup"
      page.should have_button("Sign in")
      page.should have_xpath("//div[@id='flash_alert']")
    end

  end

  context "as a valid user" do
    before do
      click_link "Sign in"
      fill_in "Email", :with => user.email
      fill_in "Password", :with => user.password
      click_button "Sign in"
    end

    it "shows all cups" do
      Cup.all.each do |cup|
        page.should have_xpath("//a",cup.name)
      end
    end

    it "new cup page shows form" do
      click_link "New Cup"
      page.should_not have_xpath("//div[@id='flash_alert']")
      page.should have_button("Create Cup")
    end
  end
end
