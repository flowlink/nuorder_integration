module Factories
  class << self
    Dir.glob(File.join(App.root, "spec/support/factories/*.json")) do |file|
      define_method("#{File.basename(file, '.json')}_payload") do
         JSON.parse(IO.read(file))
      end
    end
  end
end
