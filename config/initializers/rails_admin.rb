RailsAdmin.config do |config|

  config.main_app_name = ["Taxi"]
  # or somethig more dynamic
  config.main_app_name = Proc.new { |controller| ["Taxi", "- #{controller.params[:action].try(:titleize)}"] }


  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :admin
  end
  config.current_user_method(&:current_admin)


  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration


  config.excluded_models = ["Ckeditor::Asset", "Ckeditor::AttachmentFile", "Ckeditor::Picture"]
  
  config.actions do
    dashboard
    index
    nested_set do
      visible do
        %w(Page).include? bindings[:abstract_model].model_name
      end
    end    
    new
    export do
      visible do
        %w(Page).include? bindings[:abstract_model].model_name
      end
    end
    bulk_delete
    show
    edit
    delete
    show_in_app
  end

  # config.model Page do
  #   nestable_list true
  #   field :title
  #   field :body
  #   field :parent_id, :enum do
  #     enum do
  #       Page.select(:id).map { |page| page.id } #this is just an example though
  #     end
  #   end
  # end
end
