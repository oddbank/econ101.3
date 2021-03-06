class MemesController < ApplicationController
 
 def new
    @meme = Meme.new
  end

  def create
      @meme = current_user.created_memes.build(meme_params)
      if @meme.save
      flash[:success] = "You have added a new Meme!"
      redirect_to @meme #things_path later
    else
      flash[:danger] = "The form contains errors"
      render :new
    end
  end

  def index
  @memes = current_user.memes
  end

  def show
  @meme = Meme.find(params[:id])
  end

  def edit
  @user = current_user
  @meme = Meme.find(params[:id])
  end

  def update
  @user = current_user
  @meme = Meme.find(params[:id])  
  if @meme.update_attributes(meme_params)
      flash[:success] = "Update successful"
      redirect_to @meme
    else
      flash[:danger] = "Something went wrong"
      render :edit
    end
  end

  def destroy
    @meme = Meme.find(params[:id])
    @meme.destroy

    if @meme.destroy
      flash[:success] = "Your Meme was deleted successfully"
      redirect_to root_url
    else
      flash[:danger] = "Could not delete"
      render @meme
    end
  end

  private

  def meme_params
    params.require(:meme).permit(:creator_id, :image, :text, :breed, :hashtags, :description, :meme_addy,)
  end

  def correct_user
  @meme = Meme.find(params[:id])
    if current_user != @meme.creator
      flash[:danger] = "You don't have permission to do that."
      redirect_to root_url
    end
  end
    
end
