class AddAttachmentMicropostImgToMicroposts < ActiveRecord::Migration
  def self.up
    change_table :microposts do |t|
      t.attachment :micropost_img
    end
  end

  def self.down
    remove_attachment :microposts, :micropost_img
  end
end
