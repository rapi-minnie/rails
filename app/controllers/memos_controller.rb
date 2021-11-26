class MemosController < ApplicationController
  before_action :authenticate_user!, except: [:index]


  def new
    @memo = Memo.new
  end

  def create
    @memo = Memo.new(memo_params)
    @memo.user_id = current_user.id
    @memo.save
     redirect_to memo_path(current_user)
    end

  def index
    @memos = Memo.all
  end

  def show
     @memo = Memo.find(params[:id])
  end

  def edit
     @memo = Memo.find(params[:id])
  end

  def update
     @memo = Memo.find(params[:id])
     if @memo.update(memo_params)
       redirect_to memo_path(@memo), notice: "レシピを更新しました。"
     end
   end

   def destroy
    memo = Memo.find(params[:id])
    memo.destroy
    redirect_to user_path(memo.user), notice: "レシピを削除しました。"
  end


  private
    def memo_params
      params.require(:memo).permit(:title, :body, :image)
    end
  end
