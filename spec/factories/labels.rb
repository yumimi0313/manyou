FactoryBot.define do
  factory :label do
    name { "勉強" }
  end

  factory :second_label, class: Label do
    name { "仕事" }
  end

  factory :third_label, class: Label do
    name { "家事" }
  end
end
