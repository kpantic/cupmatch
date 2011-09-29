require "spec_helper"

describe "cups/show.html.haml" do
  fixtures :cups
  before do
    @cup = cups(:ucl)
    assign :cup, @cup
    assign :matches, @cup.matches
    assign :cup_winners, @cup.cup_winners
    assign :stadia, @cup.stadia
    render
  end

  it "should load all associations" do
    rendered.should have_content("Name: #{@cup.name}")
    rendered.should have_content("Country: #{@cup.country}")
    rendered.should have_content("Year started: #{@cup.year_started}")
    rendered.should have_content("Frequency: #{@cup.frequency}")
  end

  it "should load all associations" do
    rendered.should have_xpath("//div[@id='matches']")
    rendered.should have_xpath("//div[@id='winners']")
    rendered.should have_xpath("//div[@id='stadiums']")
  end
end