class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  
  with_options presence: true do
    # ニックネームが必須であること。
    validates :nickname
    # メールアドレスが必須、一意性である、@を含むはデフォルトで備わっているため記述不要。
    # パスワードが必須、6文字以上必須、パスワードとパスワード（確認）の一致は必須であることはデフォルトで備わっているため記述不要。

    # お名前(全角)は、名字と名前がそれぞれ必須であること。全角の漢字・ひらがな・カタカナ
    validates :last_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }
    validates :first_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }
    #  お名前カナ(全角)は、名字と名前がそれぞれ必須であること。全角のカタカナ
    validates :last_name_kana, format: { with: /\A[ァ-ヶー－]+\z/ }
    validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/ }
    # 生年月日が必須であること。
    validates :birth_date
  end

   # パスワードが半角英数字混合での入力必須であること。
   PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
   validates_format_of :password, with: PASSWORD_REGEX, message: 'is invalid. Include both letters and numbers'

end
