class ItemsTag

  include ActiveModel::Model
  attr_accessor :tag_name, :name, :image, :description, :price, :category_id, :condition_id, :shipping_fee_person_id, :region_id, :date_ish_id, :user_id, :item_id
 
  validates :name, :price, :image,:description, :category_id, :condition_id, :shipping_fee_person_id, :region_id, :date_ish_id, presence: true

  def save
    item = Item.create(name: name, image: image, description: description, price: price, category_id: category_id, condition_id: condition_id, shipping_fee_person_id: shipping_fee_person_id, region_id: region_id, date_ish_id: date_ish_id, user_id: user_id)
    tag = Tag.where(tag_name: tag_name).first_or_initialize
    tag.save
    ItemTagRelation.create(item_id: item.id, tag_id: tag.id)
  end

  def update
    item = Item.find_by(id: item_id)
    item.update(name: name, image: image, description: description, price: price, category_id: category_id, condition_id: condition_id, shipping_fee_person_id: shipping_fee_person_id, region_id: region_id, date_ish_id: date_ish_id, user_id: user_id, id: item_id)
    tag = Tag.where(tag_name: tag_name).first_or_create
    item.tags.clear
    item.tags << tag

  
  end
  
end