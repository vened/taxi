class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @pages = Page.all
    respond_with(@pages)
  end

  def show
    respond_with(@page)
  end
  
  private
    def set_page
      @page = Page.find_by_path(params[:id])
    end
end
