require 'database_cleaner'

namespace :db do
  task :clear, [:models] => [:environment] do |t, args|
    models = args.models
    if models
      ar = []
      if models.include? ' '
        models.split(' ').each {|m| ar << m}
      elsif models.include? ','
        models.split(',').each {|m| ar << m}
      else
        ar << models
      end

      DatabaseCleaner.strategy = :deletion, {only: ar}
      DatabaseCleaner.clean_with :truncation, {only: ar}
    else
      DatabaseCleaner.strategy = :deletion, {:except => %w[spatial_ref_sys]}
      DatabaseCleaner.clean_with :truncation, {:except => %w[spatial_ref_sys]}
      Rake::Task['db:seed'].invoke
    end
  end
end