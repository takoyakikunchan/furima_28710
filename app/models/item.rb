class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one :order
  has_one_attached :image
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_fee_person
  belongs_to_active_hash :region
  belongs_to_active_hash :date_ish
  has_many :item_tag_relations
  has_many :tags, through: :item_tag_relations
  has_many :comments
  
  # 空の投稿を保存できないようにする
  validates :name, :price, :description, :category, :condition, :shipping_fee_person, :region, :date_ish, presence: true
  validates :image, presence: {message: 'を登録してください'}
  # ジャンルの選択が「--」の時は保存できないようにする
  validates :category_id, :condition_id, :shipping_fee_person_id, :region_id, :date_ish_id, numericality: { other_than: 1 , message: 'を選択してください' }
  validates :name, length: { maximum: 40 }
  validates :description, length: { maximum: 1000 }
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'は300~9,999,999円の間で設定してください' }







  def self.item_search(search)
    if search != ""
      @items = Item.where('name LIKE(?)', "%#{search}%").where('description LIKE(?)', "%#{search}%")
      @tags = Tag.where('tag_name LIKE(?)', "%#{search}%")
      @test = []
      @tags.each do |tag|
        @tag_item = tag.items
        @test <<  @tag_item
      end
      @test <<  @items 
      @test.each do |i|
        @item= i.uniq
      end
      return @item

    else
      Item.all
    end
  end


end
