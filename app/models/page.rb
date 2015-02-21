class Page < ActiveRecord::Base
  acts_as_nested_set


  def parent_enum
    Page.where.not(id: id).map { |c| [c.title, c.id] }
  end

  rails_admin do
    nested_set({max_depth: 2})
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
