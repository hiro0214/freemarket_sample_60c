FactoryBot.define do

  factory :user do
    name                  {Faker::JapaneseMedia::OnePiece.character}
    email                 {Faker::Internet.free_email}
    gender                {"men"}
    first_name            {Faker::Name.first_name}
    last_name             {"Faker::Name.last_name"}
    birthday              {"2019/10/23"}
    tel_number            {"fffff"}
    password              {"12345678"}
    password_confirmation {"12345678"}
    avatar                {Faker::Avatar.image}
  end
end