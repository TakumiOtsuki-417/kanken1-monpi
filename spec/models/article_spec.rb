require 'rails_helper'

RSpec.describe Article, type: :model do
  describe '記事投稿機能' do
    before do
      @article = FactoryBot.build(:article)
    end
    context '記事が投稿できた場合' do
      it '全てを正しく入力すれば登録できる' do
        expect(@article).to be_valid
      end
    end
    context '記事投稿に失敗する場合' do
      it 'titleが空だと登録できない' do
        @article.title = ""
        @article.valid?
        expect(@article.errors.full_messages).to include("Title can't be blank")
      end
      it 'contentが空だと登録できない' do
        @article.content = ""
        @article.valid?
        expect(@article.errors.full_messages).to include("Content can't be blank")
      end
      it 'Genreが空だと登録できない' do
        @article.genre_id = nil
        @article.valid?
        expect(@article.errors.full_messages).to include("Genre can't be blank")
      end
      it 'Genreが全角数値（文字列）だと登録できない' do
        @article.genre_id = "４"
        @article.valid?
        expect(@article.errors.full_messages).to include("Genre is invalid. Input only half-number")
      end
      it 'Genreが9以上だと登録できない' do
        @article.genre_id = 9
        @article.valid?
        expect(@article.errors.full_messages).to include("Genre is invalid. Input less than 8")
      end
      it 'Rankが空だと登録できない' do
        @article.rank_id = nil
        @article.valid?
        expect(@article.errors.full_messages).to include("Rank can't be blank")
      end
      it 'Rankが全角数値(文字列)だと登録できない' do
        @article.rank_id = "４"
        @article.valid?
        expect(@article.errors.full_messages).to include("Rank is invalid. Input only half-number")
      end
      it 'Rankが5以上だと登録できない' do
        @article.rank_id = 5
        @article.valid?
        expect(@article.errors.full_messages).to include("Rank is invalid. Input less than 5")
      end
    end
  end
end
