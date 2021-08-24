class MakequestsController < ApplicationController
  before_action :set_question, only: %i[ show edit update destroy ]
  def index
    @questions = Quest.all
  end
  def show
    
  end
  def new
    @makequest = Quest.new
  end
  def create
    @question = Quest.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to makequests_path, notice: "Question was successfully created." }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end
  def edit
  end
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to makequests_path, notice: "Question was successfully updated." }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to makequests_path, notice: "Question was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_question
    @question = Quest.find(params[:id])
  end
  def question_params
    params.permit(:question, :select1, :select2, :select3, :select4, :answer, :explain, :level, :genre)
  end


end
