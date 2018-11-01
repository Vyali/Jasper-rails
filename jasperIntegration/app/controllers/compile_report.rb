module JasperIntegration
    class CompileReport
        # require 'java'
        # require 'load_jar'        
        # JasperIntegration::LoadJar.load
        # java_import Java::net::sf::jasperreports::engine::JasperCompileManager

        def self.compile_report(jrxml_file, output_dir = nil)
            output_dir ||= File.dirname(jrxml_file)
            output_file = File.join(output_dir, File.basename(jrxml_file, '.jrxml') + '.jasper')
            JasperCompileManager.compile_report_to_file(jrxml_file, output_file)
                    
         end
    end
end
