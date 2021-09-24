require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe '管理者登録機能' do
    before do
      @admin = FactoryBot.build(:admin)
    end
    context '登録に成功する場合' do
      it '全ての情報を入力かつ正しい特殊コード４つを入力すれば登録できる' do
        expect(@admin).to be_valid
      end
    end
    context '登録に失敗する場合' do
      it 'emailが空だと登録できない' do
        @admin.email = ""
        @admin.valid?
        expect(@admin.errors.full_messages).to include("Email can't be blank")
      end
      it '既存のemailは登録できない' do
        @admin.save
        @admin2 = FactoryBot.build(:admin)
        @admin2.email = @admin.email
        @admin2.valid?
        expect(@admin2.errors.full_messages).to include("Email has already been taken")
      end
      it 'nicknameが空だと登録できない' do
        @admin.nickname = ""
        @admin.valid?
        expect(@admin.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'passwordが空だと登録できない' do
        @admin.password = ""
        @admin.valid?
        expect(@admin.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが6文字未満だと登録できない' do
        @admin.password = "abcde"
        @admin.valid?
        expect(@admin.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'passwordが確認用のそれと一致してないと登録できない' do
        @admin.password_confirmation = "abcderag"
        @admin.valid?
        expect(@admin.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'code1が空だと登録できない' do
        @admin.code1 = ""
        @admin.valid?
        expect(@admin.errors.full_messages).to include("Code1 can't be blank")
      end
      it 'code2が空だと登録できない' do
        @admin.code2 = ""
        @admin.valid?
        expect(@admin.errors.full_messages).to include("Code2 can't be blank")
      end
      it 'code3が空だと登録できない' do
        @admin.code3 = ""
        @admin.valid?
        expect(@admin.errors.full_messages).to include("Code3 can't be blank")
      end
      it 'code4が空だと登録できない' do
        @admin.code4 = ""
        @admin.valid?
        expect(@admin.errors.full_messages).to include("Code4 can't be blank")
      end
      it 'code1が間違っていると登録できない' do
        @admin.code1 = "gtabffatrbt"
        @admin.valid?
        expect(@admin.errors.full_messages).to include("One of the four codes is wrong.")
      end
      it 'code2が間違っていると登録できない' do
        @admin.code2 = "gtabffatrbt"
        @admin.valid?
        expect(@admin.errors.full_messages).to include("One of the four codes is wrong.")
      end
      it 'code3が間違っていると登録できない' do
        @admin.code3 = "gtabffatrbt"
        @admin.valid?
        expect(@admin.errors.full_messages).to include("One of the four codes is wrong.")
      end
      it 'code4が間違っていると登録できない' do
        @admin.code4 = "gtabffatrbt"
        @admin.valid?
        expect(@admin.errors.full_messages).to include("One of the four codes is wrong.")
      end
      
    end
  end
end
