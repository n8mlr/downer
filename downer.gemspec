# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{downer}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nate Miller"]
  s.date = %q{2010-07-16}
  s.default_executable = %q{downer}
  s.description = %q{Downer is a tool used to download a list of urls from a website thorugh HTTP.}
  s.email = %q{nate@natemiller.org}
  s.executables = ["downer"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "bin/downer",
     "downer.gemspec",
     "features/step_definitions/downer_steps.rb",
     "features/support/env.rb",
     "features/user_starts_downer_with_valid_args.feature",
     "features/user_starts_downer_without_args.feature",
     "lib/downer.rb",
     "lib/downer/application.rb",
     "lib/downer/download_item.rb",
     "lib/downer/download_manager.rb",
     "lib/downer/download_worker.rb",
     "lib/downer/options.rb",
     "spec/downer/application_spec.rb",
     "spec/downer/download_item_spec.rb",
     "spec/downer/download_manager_spec.rb",
     "spec/downer/download_worker_spec.rb",
     "spec/downer/generator_spec.rb",
     "spec/fixtures/some_images.txt",
     "spec/spec.opts",
     "spec/spec_helper.rb",
     "version.yml"
  ]
  s.homepage = %q{http://github.com/nate63179/downer}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Bulk downloading utitlity}
  s.test_files = [
    "spec/downer/application_spec.rb",
     "spec/downer/download_item_spec.rb",
     "spec/downer/download_manager_spec.rb",
     "spec/downer/download_worker_spec.rb",
     "spec/downer/generator_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
  end
end

