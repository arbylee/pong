require 'gosu'

def load_path(path)
  Dir.glob(File.join(path, '*')).each do |filename|
    if File.directory? filename
      load_path(filename)
    else
      require_relative File.join('..', filename) if File.extname(filename) == '.rb'
    end
  end
end

load_path('lib')
