class Post < ApplicationRecord
  has_many :comments  #пост имеет много коминтариев
  # проверка на заполнение полей
  validates :title, presence: true, length:{minimum: 5}#presence: true - автоматический вызов проверки, length:{minimum: 5} - минимальное кол-во символов
end
