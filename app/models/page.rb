class Page < ActiveRecord::Base
  has_ancestry
  attr_accessor :parent_id


  def parent_enum
    Page.where.not(id: id).map { |c| [c.title, c.id] }
  end
  
  rails_admin do
    nestable_tree({
                      position_field: :ancestry,
                      max_depth: 10
                  })
    list do
      field :title
      field :path
    end
    edit do
      field :title
      field :parent_id, :enum do
        enum_method do
          :parent_enum
        end
      end
      field :body, :ck_editor
    end
  end
end
