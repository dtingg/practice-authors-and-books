class ApplicationController < ActionController::Base
  def show
    @author = Author.find_by(id: params[:id])
  end
end
