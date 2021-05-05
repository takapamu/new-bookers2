class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true, presence: true
  validates :introduction,length: { maximum: 50}
  
  attachment :profile_image
  has_many :book_comments,dependent: :destroy
  has_many :favorites, dependent: :destroy

  def favorited_by?(book)
    self.favorites.exists?(book_id: book.id)
  end
  
has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy 
has_many :following, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
has_many :following_users, through: :follower, source: :following
has_many :follower_users, through: :following, source: :follower

# ユーザーをフォローする
def follow(user_id)
  follower.create(following_id: user_id)
end

# ユーザーのフォローを外す
def unfollow(user_id)
  follower.find_by(following_id: user_id).destroy
end

# フォローしていればtrueを返す
def following?(user)
  following_users.include?(user)
end

  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end

end
