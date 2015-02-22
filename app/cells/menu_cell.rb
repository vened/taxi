class MenuCell < Cell::Rails

  def list
    # @pages = Page.all.order('lft ASC')
    @pages = Page.roots
    render
  end

end