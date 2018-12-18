class PostsController < ApplicationController
  # http_basic_authenticate_with name: 'admin', password: '1q22', except: [:index, :show]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :new] , except: [:index, :show]

  # before_action :logged_in_user, only: [:index, :edit, :update, :destroy] 

  # Подтверждает вход пользователя
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end  

  def index
    @post = Post.all #вытянет нам все статьи с @post
  end

  def new
    # метод для создания новых постов
    @post = Post.new
  end

  def show #находит и отображает нужную статью
    @post = Post.find(params[:id])
  end

  def edit #находит и отображает нужную статью
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if (@post.update(post_params))
      redirect_to @post #если в 'post.rb' нету ошибок то перенаправляем нас на страницу,
    else
      render 'edit' #если ошибка то страница перезагрузится
    end
  end

  def destroy
    @post = Post.find(params[:id])

    @post.destroy
    redirect_to posts_path
  end

  def create #сохранение данных поста в базу данных
    # render plain: params[:post].inspect
    @post = Post.new(post_params)
    @post.user = current_user


    if (@post.save)
      redirect_to @post #если в 'post.rb' нету ошибок то перенаправляем нас на страницу,
    else
      render 'new' #если ошибка то страница перезагрузится
    end
  end

  #указуем разрешенны данные для передачи
  private def post_params
    params.require(:post).permit(:title, :current_user, :body)
  end
end
