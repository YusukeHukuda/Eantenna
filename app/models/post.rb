class Post < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  belongs_to :user
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  # accepts_nested_attributes_for :tags
  attr_accessor :name
  has_one_attached :image

  # 文字数の制限
  validates :title, length: { in: 1..20 }
  validates :body, length: {in: 1..100 }

  validates :address, presence: true

  def self.serach(keyword)
   Post.where(['title LIKE ? OR body LIKE ?', "%#{keyword}%", "%#{keyword}%"])
  end

  def save_posts(tags)
   current_tags = self.tags.pluck(:name) unless self.tags.nil? #すべて新しいものだった場合はnilになる
   old_tags = current_tags - tags
   new_tags = tags - current_tags

  # 入力されたタグがすでにある場合それを算出
   old_tags.each do |old_name|
     self.tags.delete Tag.find_by(name:old_name)
   end

   new_tags.each do |new_name|
     post_tag = Tag.find_or_create_by(name:new_name)
     self.tags << post_tag
   end
  end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_fill: [width, height]).processed
  end

  # Postテーブルのcontentカラムを検索する
  def self.search(search)
    return Post.all unless search
    Post.where(['body LIKE(?) OR title LIKE(?)', "%#{search}%", "%#{search}%"])
  end

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
end
