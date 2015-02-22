# == Schema Information
#
# Table name: pages
#
#  id        :integer          not null, primary key
#  title     :string(255)
#  body      :text(65535)
#  parent_id :integer
#  lft       :integer
#  rgt       :integer
#  depth     :integer
#  path      :string(255)
#  feedback  :boolean
#  order     :boolean
#

class Page < ActiveRecord::Base
  extend ActiveModel::Callbacks
  before_save :update_path
  before_update :update_path
  acts_as_nested_set

  validates :title, length: {minimum: 1}, uniqueness: true

  def update_path
    custom_title = self.title.strip.gsub(/[^а-яА-Яa-zA-Z0-9]+/, "-")
    self.path = I18n.transliterate(custom_title).downcase
  end

  def full_path
    @parents = self.self_and_ancestors.select(:path)
    @path = @parents.map do |p|
      "/" + p.path
    end
    @path.join()
  end


  def to_param
    "#{path}"
  end

  def parent_enum
    Page.where.not(id: id).map { |c| [c.title, c.id] }
    # nested_set_options(Page) { |i| ['-' * i.level , i.title]}
  end

  rails_admin do
    nested_set({max_depth: 2})
    list do
      field :title
      field :full_path
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
