class PostsController < ApplicationController
  http_basic_authenticate_with name: 'admin', password: '1q2', except: [:index, :show]

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

    if (@post.save)
      redirect_to @post #если в 'post.rb' нету ошибок то перенаправляем нас на страницу,
    else
      render 'new' #если ошибка то страница перезагрузится
    end
  end

  #указуем разрешенны данные для передачи
  private def post_params
    params.require(:post).permit(:title, :body)
  end
end
