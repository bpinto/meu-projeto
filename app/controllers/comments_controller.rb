# coding: UTF-8
class CommentsController < ApplicationController

  def create
    @commentable = Deal.find(params[:deal_id])
    @comment = @commentable.comments.build(params[:comment])
    @comment.user = current_user
    if @comment.save
      redirect_to @comment.commentable, :notice => "Comentário cadastrado com sucesso!"
    else
      redirect_to @comment.commentable, :error => "Ocorreu um erro ao tentar cadastrar o seu comentário, tente novamente."
    end
  end

end
