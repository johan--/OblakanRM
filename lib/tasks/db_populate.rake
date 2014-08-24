namespace :db do
  task :populate, [:records_num] => [:environment] do |t, args|
    args.with_defaults(records_num: 10)
    puts "Creating #{args.records_num} records"
    longitude = 91.41775131225586
    latitude = 53.707579881827854
    args.records_num.to_i.times do
      report = Report.create(
          title: "#{Faker::Lorem.sentence(8+rand(8)).chop}?",
          description: Faker::Lorem.paragraph(rand(3)),
          location: "POINT (#{longitude} #{latitude})",
          status: Status.find(Random.new.rand(1..Status.all.count)),
          user: User.create(email: Faker::Internet.email, username: Faker::Internet.user_name)
      )
      report.update_attribute(:closed_at, Time.now) if report.status.is_final?
    end
  end
end