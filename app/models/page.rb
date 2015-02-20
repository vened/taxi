class Page < ActiveRecord::Base
  has_ancestry
  # attr_accessor :parent_id


  rails_admin do
    nestable_tree({
                      position_field: :ancestry,
                      max_depth: 10
                  })
  end
end
