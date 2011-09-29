require "spec_helper"

describe StadiaController do
  before :each do
    @user = User.create(:email => "tester@tester.com", :password => "123456")
    @user.save
  end

  fixtures :stadia
  it "should assign @stadia" do
    get :index
    assigns(:stadia).should eq(Stadium.all)
    response.should render_template("index")
  end

  it "should filter by name and assigns to @stadia" do
    get :index, :name => "Camp Nou"
    assigns(:stadia).should eq(Stadium.filter({:name => "Camp Nou"}))
    response.should render_template("index")
  end

  it "should filter by country and assigns to @stadia" do
    get :index, :country => "Spain"
    assigns(:stadia).should eq(Stadium.filter({:country => "Spain"}))
    response.should render_template("index")
  end

  it "should filter by name & country and assigns to @stadia" do
    get :index, :name => "Stadium", :country => "England"
    assigns(:stadia).should eq(Stadium.filter({:name => "Stadium", :country => "England"}))
    response.should render_template("index")
  end

  it 'should assign the stadium to @stadium' do
    t = Factory(:stadium)
    get :show, :id => t
    assigns(:stadium).should eq(t)
    assigns(:matches).should eq(t.matches)
    assigns(:cups).should eq(t.cups)
    response.should render_template("show")
  end

  it 'should create a stadium' do
    sign_in @user
    post :create, :stadium => {:name => "Tester", :country => "Spain"}
    assigns[:stadium].name.should == "Tester"
    assigns[:stadium].country.should == "Spain"
    response.should redirect_to(stadium_path(assigns[:stadium]))
  end

  it 'should assign the stadium for edit to @stadium' do
    sign_in @user
    get :edit, :id => stadia(:campnou).id
    assigns(:stadium).should eq(stadia(:campnou))
    response.should render_template("edit")
  end

  it 'should update a stadium' do
    sign_in @user
    put :update, :id => stadia(:campnou), :cup => {:name => "TesterCup", :country => "England"}
    assigns[:stadium].name == "TesterCup"
    assigns[:stadium].country == "England"
  end

  [:create, :update].each do |action|
    it "should not allow a guest to #{action}" do
      put action, :id => stadia(:campnou)
      response.should be_redirect
    end
  end

  it "renders the index template" do
    get :index
    response.should render_template("index")
  end
end