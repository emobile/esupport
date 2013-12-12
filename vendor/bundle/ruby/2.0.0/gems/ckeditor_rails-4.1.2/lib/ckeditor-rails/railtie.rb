module Ckeditor
  module Rails
    class Railtie < ::Rails::Railtie
      initializer 'ckeditor.assets.precompile', group: :all do |app|
        app.config.assets.precompile += %W(
          ckeditor/*.js
          ckeditor/*.css
          ckeditor/*.png
          ckeditor/*.gif
          ckeditor/*.html
          ckeditor/*.md
        )
      end
    end
  end
end
