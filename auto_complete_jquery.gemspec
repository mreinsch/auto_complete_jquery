Gem::Specification.new do |s|
  s.name     = "auto_complete_jquery"
  s.version  = "0.2.2"
  s.date     = "2009-06-10"
  s.summary  = "auto-complete method for Rails controllers using Dylan Verheul's jQuery autocomplete plugin"
  s.email    = "michael@mobalean.com"
  s.homepage = "http://github.com/mreinsch/auto_complete_jquery"
  s.description = "This plugin provides a auto-complete method for your controllers to be used with Dylan Verheul's jquery autocomplete plugin."
  s.has_rdoc = true
  s.authors  = ["Chris Bailey", "Michael Reinsch"]
  s.files    = ["CHANGELOG",
		"README.rdoc",
		"Rakefile",
		"auto_complete_jquery.gemspec",
		"init.rb",
		"rails/init.rb",
		"lib/auto_complete_jquery.rb"]
  s.rdoc_options = ["--main", "README.rdoc"]
  s.extra_rdoc_files = ["CHANGELOG", "README.rdoc"]
end
