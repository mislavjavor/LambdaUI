

Pod::Spec.new do |s|
  s.name         = "LambdaUI"
  s.version      = "2.0.0"
  s.summary      = "Closure driven event handling framework with easy event management and intuitive GCD async support "
  s.description  = <<-DESC
Event handling with closures and Grand Central Dispatch ( GCD ) asynchronous ( async ) support. Allows easy event stacking and removal as well as event management.
                   DESC
  s.homepage     = "https://github.com/mislavjavor/LambdaUI"
  s.license      =  "MIT"
  s.author             = { "Mislav Javor" => "mislav.javor@outlook.com" }
  s.platform = :ios, "8.0"
  s.source       = { :git => "https://github.com/mislavjavor/LambdaUI.git", :tag => "#{s.version}" }
  s.source_files  = "Source/**/*.swift"
end
