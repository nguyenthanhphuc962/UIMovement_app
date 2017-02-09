class Micropost < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  validates :name, presence: true, length: { maximum: 50 }
  validates :user_id, presence: true
  validates :category_id, presence: true
   mount_uploader :picture, PictureUploader
  validates :picture, presence: true, allow_nil: true
  validate :picture_size


  #has_attached_file :micropost_img, styles: { micropost_index: "300x300>", micropost_show: "100x100>" }, default_url: "/images/:style/missing.png"
  #validates_attachment :micropost_img,
  #content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }

  private

    def self.search(search)
      if search
        where('name ILIKE ?', "%#{search}%")
      end
    end

    def picture_size
      if picture.size > 20.megabytes
        errors.add(:picture, "Should be less than 20 megabytes")
      end
    end

end
