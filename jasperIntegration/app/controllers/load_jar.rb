module JasperIntegration
  class LoadJar
    def self.load
      Dir.entries( 'E:/dir/for/jars').each do |lib|
        require File.join( 'E:/dir/for/jars', lib) if lib =~ /\.jar$/
      end
    end
  end
end