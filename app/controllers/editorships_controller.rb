class EditorshipsController < ApplicationController
  def create
    @other_user = User.find(params[:editorship][:editor_id])
    current_user.allow!(@other_user)
    respond_to do |format|
      format.html { redirect_to index }
      format.js
    end
  end

  def destroy
    @other_user = Editorship.find(params[:id]).editor
    current_user.disallow!(@other_user)
    respond_to do |format|
      format.html { redirect_to index }
      format.js
    end
  end
end
