def create_terraform_task(dir)
  ns = dir.gsub('/', ':')
  namespace ns do
    desc "init on #{dir}"
    task :init do
      cd dir do
        sh 'terraform init'
        end
    end

    desc "fmt on #{dir}"
    task :fmt do
      cd dir do
        sh 'terraform fmt -diff=true'
      end
    end
    
    desc "plan on #{dir}"
    task :plan do
      Rake::Task["#{ns}:fmt"].invoke
      cd dir do
        sh 'terraform plan'
      end
    end

    desc "apply on #{dir}"
    task :apply do
      cd dir do
        sh 'terraform apply'
      end
    end

    desc "refresh on #{dir}"
    task :refresh do
      cd dir do
        sh 'terraform refresh'
      end
    end
  end
end

Dir['**/*'].each do |f|
  if f.include?('backend.tf')
    dir = File.dirname(f)
    if dir != '.'
      create_terraform_task(dir)
    end
  end
end

# All
namespace :all do
  desc 'plan on all'
  task :plan do
    tasks = Rake.application.tasks.select {|t| t.name.match(/plan$/) }
    tasks.each do |t|
      if t.name != 'all:plan'
        t.invoke
      end
    end
  end

  desc 'apply on all'
  task :apply do
    tasks = Rake.application.tasks.select {|t| t.name.match(/apply$/) }
    tasks.each do |t|
      if t.name != 'all:apply'
        t.invoke
      end
    end
  end
end
