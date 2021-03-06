class MakequestsController < ApplicationController
  before_action :redirect_user
  before_action :set_question, only: %i[ show edit update destroy ]
  def index
    @questions = Quest.all
    #0~5までのジャンルに分けてインスタンス変数生成
    6.times do |i|
      each_genre(i)
    end
  end
  def show
    
  end
  def new
    @makequest = Quest.new
  end
  def create
    @makequest = Quest.new(question_params)

    respond_to do |format|
      if @makequest.save
        format.html { redirect_to makequests_path, notice: "Question was successfully created." }
        format.json { render :show, status: :created, location: @makequest }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @makequest.errors, status: :unprocessable_entity }
      end
    end
  end
  def edit
    @makequest = Quest.find(params[:id])
  end
  def update
    respond_to do |format|
      if @makequest.update(question_params)
        format.html { redirect_to makequests_path, notice: "Question was successfully updated." }
        format.json { render :show, status: :ok, location: @makequest }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @makequest.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy
    @makequest.destroy
    respond_to do |format|
      format.html { redirect_to makequests_path, notice: "Question was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def redirect_user
    if !admin_signed_in?
      redirect_to root_path
    end
  end
  def set_question
    @makequest = Quest.find(params[:id])
  end
  def question_params
    params.require(:quest).permit(:question, :select1, :select2, :select3, :select4, :answer, :explain, :rank_id, :genre_id)
  end
  def each_genre(num)
    question_value = @questions.where(genre_id: num)
    instance_variable_set("@genre#{ num }", question_value)
  end

end
