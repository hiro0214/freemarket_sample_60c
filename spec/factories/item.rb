FactoryBot.define do
  factory :item do
    item_name             {Faker::JapaneseMedia::OnePiece.character}
    description           {Faker::JapaneseMedia::OnePiece.akuma_no_mi}
    price                 {"10000"}
    state                 {"新品"}
    size                  {"M"}
    fee_size              {"送料込み"}
    region                {Faker::JapaneseMedia::OnePiece.sea}
    delivery_date         {"1〜2日で発送"}
  end
end
