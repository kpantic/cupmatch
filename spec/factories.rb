# This will guess the User class
FactoryGirl.define do
  factory :user do
    email 'test@test.com'
    password  '123456'
  end
  factory :cup do
    name 'Test Cup'
    country 'Spain'
  end
  factory :stadium do
    name 'Test Stadium'
    country 'Venezuela'
  end
  factory :team do
    name 'Test Team'
    country 'Spain'
  end
  factory :second_team, :class => Team do
    name 'Test Team2'
    country 'England'
  end
  factory :match do
    date '2011-06-09'
    cup {Factory(:cup)}
    stadium {Factory(:stadium)}
    home_team {Factory(:team)}
    away_team {Factory(:second_team)}
    home_team_result 3
    away_team_result 2
  end
end
