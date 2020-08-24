FactoryBot.define do 
  factory :user do 
    nickname              { 'abe' } 
    email                 { 'kkk@gmail.com' } 
    password              { 'knbn0000' } 
    password_confirmation { password } 
    given_name { '佳奈' } 
    family_name { '相原' } 
    read_fam_name { 'アイハラ' }
    read_given_name { 'カナ' }
    birthday { '2017/12/12' }
  end
end
