FactoryBot.define do
  factory :item do
    item_name             {Faker::JapaneseMedia::OnePiece.character}
    description           {Faker::JapaneseMedia::OnePiece.akuma_no_mi}
    price                 {"10000"}
    state                 {""}
    size                  {""}
    fee_size              {""}
    region                {""}
    delivery_date         {""}   
  end
end
