class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    authorize @post
  end

  def create
    @post = Post.new(post_params) #first init @post
    @post.update_attributes(permitted_attributes(@post)) # Post.new(permitted_attributes(@post))
                                                         # an error will be raised, because you are trying to pass a non-existant object to permitted_attributes

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @post, :edit?
    if @post.update(permitted_attributes(@post))
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @post.present?
      authorize @post
      @post.destroy
    else
      skip_authorization
    end

    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  def user_posts
    @posts = policy_scope(Post)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      # params.require(:post).permit(policy(@post).permitted_attributes) instead of permitted_attributes
      params.require(:post).permit(:title, :body)
    end
end
