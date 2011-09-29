require "spec_helper"

describe TeamsController do
  before :each do
    @user = User.create(:email => "tester@tester.com", :password => "123456")
    @user.save
  end

  fixtures :teams
  it "should assign @teams" do
    get :index
    assigns(:teams).should eq(Team.all)
    response.should render_template("index")
  end

  it "should filter by name and assigns to @teams" do
    get :index, :name => "Barcelona"
    assigns(:teams).should eq(Team.filter({:name => "Barcelona"}))
    response.should render_template("index")
  end

  it "should filter by country and assigns to @teams" do
    get :index, :country => "Spain"
    assigns(:teams).should eq(Team.filter({:country => "Spain"}))
    response.should render_template("index")
  end

  it "should filter by name & country and assigns to @teams" do
    get :index, :name => "F.C.", :country => "England"
    assigns(:teams).should eq(Team.filter({:name => "F.C.", :country => "England"}))
    response.should render_template("index")
  end

  it 'should assign the team to @team' do
    t = Factory(:team)
    get :show, :id => t
    assigns(:team).should eq(t)
    response.should render_template("show")
  end

  it 'should create a team' do
    sign_in @user
    post :create, :team => {:name => "Tester", :country => "Spain"}
    assigns[:team].name.should == "Tester"
    assigns[:team].country.should == "Spain"
    response.should redirect_to(team_path(assigns[:team]))
  end

  it 'should assign the team for edit to @team' do
    sign_in @user
    get :edit, :id => teams(:fcbarcelona).id
    assigns(:team).should eq(teams(:fcbarcelona))
    response.should render_template("edit")
  end

  it 'should update a team' do
    sign_in @user
    put :update, :id => teams(:fcbarcelona), :cup => {:name => "TesterCup", :country => "England"}
    assigns[:team].name == "TesterCup"
    assigns[:team].country == "England"
  end

  [:create, :update].each do |action|
    it "should not allow a guest to #{action}" do
      put action, :id => teams(:fcbarcelona)
      response.should be_redirect
    end
  end

  it "renders the index template" do
    get :index
    response.should render_template("index")
  end
end