require 'rails_helper'

RSpec.describe Quest, type: :model do
  describe 'クエスト投稿機能' do
    before do
      @quest = FactoryBot.build(:quest)
      selects = [@quest.select1, @quest.select2, @quest.select3, @quest.select4]
      @quest.answer = selects.sample
    end
    context '投稿が成功するとき' do
      it '全て正しく入力してれば成功する' do
        expect(@quest).to be_valid
      end
    end
    context '投稿が失敗するとき' do
      it 'questionが空だと登録できない' do
        @quest.question = ""
        @quest.valid?
        expect(@quest.errors.full_messages).to include("Question can't be blank")
      end
      it 'select1が空だと登録できない' do
        @quest.select1 = ""
        @quest.valid?
        expect(@quest.errors.full_messages).to include("Select1 can't be blank")
      end
      it 'select2が空だと登録できない' do
        @quest.select2 = ""
        @quest.valid?
        expect(@quest.errors.full_messages).to include("Select2 can't be blank")
      end
      it 'select3が空だと登録できない' do
        @quest.select3 = ""
        @quest.valid?
        expect(@quest.errors.full_messages).to include("Select3 can't be blank")
      end
      it 'select4が空だと登録できない' do
        @quest.select4 = ""
        @quest.valid?
        expect(@quest.errors.full_messages).to include("Select4 can't be blank")
      end
      it 'explainが空だと登録できない' do
        @quest.explain = ""
        @quest.valid?
        expect(@quest.errors.full_messages).to include("Explain can't be blank")
      end
      it 'answerが空だと登録できない' do
        @quest.answer = ""
        @quest.valid?
        expect(@quest.errors.full_messages).to include("Answer can't be blank")
      end
      it 'answerがselect1~4のいずれとも一致しないと登録できない' do
        @quest.answer = "日本語"
        @quest.valid?
        expect(@quest.errors.full_messages).to include("Answer must be the same string as one of 4 selects.")
      end
      it 'Genreが空だと登録できない' do
        @quest.genre_id = nil
        @quest.valid?
        expect(@quest.errors.full_messages).to include("Genre can't be blank")
      end
      it 'Genreが全角数値（文字列）だと登録できない' do
        @quest.genre_id = "４"
        @quest.valid?
        expect(@quest.errors.full_messages).to include("Genre is invalid. Input only half-number")
      end
      it 'Genreが9以上だと登録できない' do
        @quest.genre_id = 9
        @quest.valid?
        expect(@quest.errors.full_messages).to include("Genre is invalid. Input less than 8")
      end
      it 'Rankが空だと登録できない' do
        @quest.rank_id = nil
        @quest.valid?
        expect(@quest.errors.full_messages).to include("Rank can't be blank")
      end
      it 'Rankが全角数値(文字列)だと登録できない' do
        @quest.rank_id = "４"
        @quest.valid?
        expect(@quest.errors.full_messages).to include("Rank is invalid. Input only half-number")
      end
      it 'Rankが5以上だと登録できない' do
        @quest.rank_id = 5
        @quest.valid?
        expect(@quest.errors.full_messages).to include("Rank is invalid. Input less than 5")
      end
    end
  end
end
