namespace :files do
  desc "Revome trash files from the system."
  task :clean => :environment do
    FileUtils.rm_rf("#{Rails.root}/public/system")
    FileUtils.mkdir_p("#{Rails.root}/public/system")
    FileUtils.rm_rf("#{Rails.root}/tmp/cache")
    FileUtils.mkdir_p("#{Rails.root}/tmp/cache")
    p 'Trash files has been removed from the system.'
  end
end