namespace :report do
  desc 'Geocode all objects without coordinates.'
  task :fill_address => :environment do
    sleep_timer = ENV['SLEEP'] || ENV['sleep'] || 1.to_f
    p 'Filling addresses... (1 sec sleep)'
    Report.where('address is null').each do |r|
      r.geocode; r.save
      sleep(sleep_timer.to_f) unless sleep_timer.nil?
    end
  end

  task :refill_address => :environment do
    sleep_timer = ENV['SLEEP'] || ENV['sleep'] || 1.to_f
    p 'Refilling addresses... (1 sec sleep)'
    Report.all.each do |r|
      r.geocode; r.save
      sleep(sleep_timer.to_f) unless sleep_timer.nil?
    end
  end
end