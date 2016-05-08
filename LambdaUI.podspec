

Pod::Spec.new do |s|
  s.name         = "LambdaUI"
  s.version      = "0.1.3"
  s.summary      = "Lambda driven event handling framework with easy event management and intuitive GCD async support "
  s.description  = <<-DESC
Event handling with lambda functioncs and Grand Central Dispatch ( GCD ) asynchronous ( async ) support
                   DESC
  s.homepage     = "https://github.com/mislavjavor/LambdaUI"
  s.license      =  "MIT"
  s.author             = { "Mislav Javor" => "mislav.javor@outlook.com" }
  s.platform = :ios, "8.0"
  s.source       = { :git => "https://github.com/mislavjavor/LambdaUI.git", :tag => "#{s.version}" }
  s.source_files  = "LambdaUI/**/*.{swift}"
end
