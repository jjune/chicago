# =============================================================================
# A rake task to generate UML-ish graphs of your Rails app
# =============================================================================

desc "Create a diagram of your app's controllers and/or models"
task :visualize do
  $LOAD_PATH << "#{File.dirname(__FILE__)}/../lib"
  
  require "rav"

  options = {
    :models      => ENV['MODELS']      != 'no',
    :controllers => ENV['CONTROLLERS'] != 'no'
  }

  filename = ENV['FILENAME'] || 'doc/diagram.png'

  rav = RailsApplicationVisualizer.new(options)
  
  if rav.output(filename)
    puts "Generated #{filename}."
  else
    rav.output "rav-debug.dot"
    puts "Error! Please file a bug report with 'rav-debug.dot' attached."
  end
end
