class StaticPagesController < ApplicationController
  def about
    @posts = Post.all.count
  end
end
