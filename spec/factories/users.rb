FactoryBot.define do

  factory :user do
    name                       {Faker::JapaneseMedia::OnePiece.character}
    email                      {Faker::Internet.free_email}
    first_name                 {Faker::Name.first_name}
    last_name                  {Faker::Name.last_name}
    first_name_kana            {"ヤマダ"}
    last_name_kana             {"タロウ"}
    tel_number                 {"09012345678"}
    password                   {"12345678"}
  end
end