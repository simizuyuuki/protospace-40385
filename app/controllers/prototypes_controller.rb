class PrototypesController < ApplicationController
  before_action :authenticate_user!, only:[:new,:create,:update,:destroy]
  before_action :move_to_index, except: [:index,:show]
  def index
    @prototypes = Prototype.all
  end
  
  def new
    @prototype = Prototype.new
  end
  
  def create
    @prototype = Prototype.new(prototype_params.merge(user_id: current_user.id))
    if @prototype.save
      redirect_to root_path(@prototype), notice: "Prototype was successfully created."
    else
      render :index, status:  :unprocessable_entity
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to @prototype, notice: "Prototype was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to root_path
    end
  end
end