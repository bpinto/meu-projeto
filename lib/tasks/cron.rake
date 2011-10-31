desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  
  #utilizando o daily cron não é preciso fazer o teste da hora, pois ele roda sempre na hora que foi ativado.
  #if Time.now.hour == 20 # run at midnight
    Rake::Task['crawler:start'].invoke
  #end

end