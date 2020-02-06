platform :ios, '13.0'
use_frameworks!
inhibit_all_warnings!

def shared_pods
  pod 'DifferenceKit', '1.1.5'
end

target 'UniversalListController' do
  shared_pods
end

abstract_target 'Modules' do
  shared_pods

  target 'Shared'
  target 'SharedUI'
  target 'Search'
  target 'RandomList'
  target 'EntitySearch'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
      config.build_settings['SWIFT_COMPILATION_MODE'] = "wholemodule"

      if config.name.include?("Development")
        config.build_settings['GCC_OPTIMIZATION_LEVEL'] = '0'
        config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = "-Onone"
        config.build_settings['DEBUG_INFORMATION_FORMAT'] = "dwarf"
      elsif config.name.include?("Release")
        config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = "-Osize"
      end
    end
  end
end