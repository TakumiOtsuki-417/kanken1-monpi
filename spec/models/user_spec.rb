require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー登録機能' do
    before do
      @user = FactoryBot.build(:user)
    end
    context '登録に成功する場合' do
      it '全ての情報を入力すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '登録に失敗する場合' do
      it 'emailが空だと登録できない' do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '既存のemailは登録できない' do
        @user.save
        @user2 = FactoryBot.build(:user)
        @user2.email = @user.email
        @user2.valid?
        expect(@user2.errors.full_messages).to include("Email has already been taken")
      end
      it 'nicknameが空だと登録できない' do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'passwordが空だと登録できない' do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが6文字未満だと登録できない' do
        @user.password = "abcde"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'passwordが確認用のそれと一致してないと登録できない' do
        @user.password_confirmation = "abcderag"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'RankIDが空だと登録できない' do
        @user.rank_id = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Rank can't be blank")
      end
      it 'RankIDは半角数値でないと登録できない' do
        @user.rank_id = '２'
        @user.valid?
        expect(@user.errors.full_messages).to include("Rank is invalid. Input only half-number")
      end
      it 'RankIDは半角数値でないと登録できない' do
        @user.rank_id = 'abcde'
        @user.valid?
        expect(@user.errors.full_messages).to include("Rank is invalid. Input only half-number")
      end
      it 'RankIDは0~4でないと登録できない' do
        @user.rank_id = 5
        @user.valid?
        expect(@user.errors.full_messages).to include("Rank is invalid. Input less than 5")
      end
    end
  end
end
