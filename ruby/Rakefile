require 'rake/testtask'

Rake::TestTask.new('test-page_002') do |t|
	t.libs = [File.expand_path('page_002')]
	t.pattern = 'test/**/tc_*.rb'
	t.warning = true
end

task 'test' => ['test-page_002']
