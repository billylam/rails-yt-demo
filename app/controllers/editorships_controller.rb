class EditorshipsController < ApplicationController
  def create
    other_user = User.find(params[:editorship][:editor_id])
    current_user.allow!(other_user)
    redirect_to root_path
  end

  def destroy
    other_user = Editorship.find(params[:id]).editor
    current_user.disallow!(other_user)
    redirect_to root_path
  end
end
