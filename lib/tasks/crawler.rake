namespace :crawler do
  desc 'Start'
  task :start => :environment do
    deal = Deal.new
    save_me = SaveMe.new
    save_me.create_deals
  end

  desc 'Start'
  task :all => [:start]
end
