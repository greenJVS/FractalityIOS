Pod::Spec.new do |spec|
  spec.name         = "FractalCore"
  spec.version      = "1.0.0"
  spec.summary      = "Math core of Fractality."
  spec.description  = "Fractal Core pod. This must be used as math core."
  spec.homepage     = "https://github.com/greenJVS"
  spec.license      = "MIT"
  spec.author             = { "greenJVS" => "green.jvs@gmail.com" }
  spec.platform     = :ios, "11.0"
	spec.source       = { :path => '.' }
	spec.source_files  = 'FractalCore/**/*.swift'
	spec.swift_version = '5.0'

end
