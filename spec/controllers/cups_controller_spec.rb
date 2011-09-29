require "spec_helper"

describe CupsController do
  before :each do
    @user = User.create(:email => "tester@tester.com", :password => "123456")
    @user.save
  end

  fixtures :cups
  it "should assign @cups" do
    get :index
    assigns(:cups).should eq(Cup.all)
    response.should render_template("index")
  end

  it "should filter by name and assigns to @cups" do
    get :index, :name => "Champions"
    assigns(:cups).should eq(Cup.filter({:name => "Champions"}))
    response.should render_template("index")
  end

  it "should filter by country and assigns to @cups" do
    get :index, :country => "Spain"
    assigns(:cups).should eq(Cup.filter({:country => "Spain"}))
    response.should render_template("index")
  end

  it "should filter by name & country and assigns to @cups" do
    get :index, :name => "League", :country => "England"
    assigns(:cups).should eq(Cup.filter({:name => "League", :country => "England"}))
    response.should render_template("index")
  end

  it 'should assign the cup to @cup' do
    c = Factory(:cup)
    get :show, :id => c
    assigns(:cup).should eq(c)
    assigns(:matches).should eq(c.matches)
    assigns(:stadia).should eq(c.stadia)
    assigns(:cup_winners).should eq(c.cup_winners)
    response.should render_template("show")
  end

  it 'should create a cup' do
    sign_in @user
    post :create, :cup => {:name => "Tester", :country => "Spain"}
    assigns[:cup].name.should == "Tester"
    assigns[:cup].country.should == "Spain"
    response.should redirect_to(cup_path(assigns[:cup]))
  end

  it 'should assign the cup for edit to @cup' do
    sign_in @user
    get :edit, :id => cups(:ucl).id
    assigns(:cup).should eq(cups(:ucl))
    response.should render_template("edit")
  end

  it 'should update a cup' do
    sign_in @user
    put :update, :id => cups(:ucl), :cup => {:name => "TesterCup", :country => "England"}
    assigns[:cup].name == "TesterCup"
    assigns[:cup].country == "England"
  end

  [:create, :update].each do |action|
    it "should not allow a guest to #{action}" do
      put action, :id => cups(:ucl)
      response.should be_redirect
    end
  end

  it "renders the index template" do
    get :index
    response.should render_template("index")
  end
end