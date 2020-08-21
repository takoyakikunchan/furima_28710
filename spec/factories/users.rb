FactoryBot.define do
  factory :user do
    nickname              {"abe"}
    email                 {"kkk@gmail.com"}
    password              {"knbn0000"}
    password_confirmation {password}
    given_name            {"相原"}
    family_name           {"太郎"}
    read_fam_name        {"アイハラ"}
    read_given_name       {"タロウ"}
    birthday                {21.years.ago}
  end　
end