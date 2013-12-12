module DeviseHelper
  # A simple way to show error messages for the current devise resource. If you need
  # to customize this method, you can either overwrite it in your application helpers or
  # copy the views to your application.
  #
  # This method is intended to stay simple and it is unlikely that we are going to change
  # it to add more behavior or options.
  def devise_error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.count,
                      :resource => resource.class.model_name.human.downcase)

    html = <<-HTML
        <div  class="row-fluid">
          <div class="block span6" style="border-color:red">
            <a href="#errors" class="block-heading" data-toggle="collapse" style="border-bottom-color:red">#{sentence}</a>
              <div id="errors" class="block-body collapse in">
                <ul>#{messages}</ul>
              </div>
          </div>
        </div>
   HTML
    html.html_safe
  end
end
