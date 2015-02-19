class Page < ActiveRecord::Base
  has_ancestry
  attr_accessor :parent_id
end
