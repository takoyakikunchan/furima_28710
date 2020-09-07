class Tag < ApplicationRecord
  has_many :item_tag_relations
  has_many :items, through: :item_tag_relations
  validates :tag_name, uniqueness: true





  after_save do
    hashtags  = self.tag_name.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      #ハッシュタグは先頭の'#'を外した上で保存
      tag = Tag.find_or_create_by(tag_name: hashtag.downcase.delete('#'))
      #tagdlt = Tag.find_by(tag_name: tag_name).delete
      
    end
  end

end

