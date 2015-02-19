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

  config.actions do
    ## With an audit adapter, you can add:
    # history_index
    # history_show


    dashboard # mandatory
    # collection actions
    index # mandatory
    new
    export
    history_index
    bulk_delete
    # member actions
    show
    edit
    delete
    history_show
    show_in_app

    # Add the nestable action for configured models
    nestable do
      visible do
        %w(List Node).include? bindings[:abstract_model].model_name
      end
    end
  end

  config.model Page do
    nestable_list true
    field :title
    field :body
    field :parent_id, :enum do
      enum do
        Page.select(:id).map { |page| page.id } #this is just an example though
      end
    end
  end
end
