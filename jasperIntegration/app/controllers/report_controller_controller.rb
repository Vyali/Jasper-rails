class ReportControllerController < ApplicationController
  require 'java'
  require 'load_jar'
  require 'my_data_bean'
  require 'compile_report'

  JasperIntegration::LoadJar.load
  


  java_import Java::net::sf::jasperreports::engine::data::JRXmlDataSource
  java_import Java::net::sf::jasperreports::engine::util::FileResolver
  java_import Java::net::sf::jasperreports::engine::util::JRLoader
  java_import Java::net::sf::jasperreports::export::SimpleOutputStreamExporterOutput
  java_import Java::net::sf::jasperreports::export::SimpleXlsReportConfiguration
  java_import Java::net::sf::jasperreports::engine::JasperPrint
  java_import Java::net::sf::jasperreports::engine::JasperRunManager
  java_import Java::net::sf::jasperreports::export::SimpleExporterInput
  java_import Java::java::io::ByteArrayInputStream
  java_import Java::java::io::BufferedInputStream
  java_import Java::java::util::Locale
  java_import Java::java::util::Map
  java_import Java::java::util::HashMap
  java_import Java::java::util::ArrayList
  java_import Java::java::lang::Byte
  java_import Java::net::sf::jasperreports::engine::export::JRXlsExporter
  java_import Java::org::apache::poi::hssf::util::HSSFColor
  java_import Java::net::sf::jasperreports::engine::DefaultJasperReportsContext
  java_import Java::net::sf::jasperreports::engine::JasperFillManager
  java_import Java::net::sf::jasperreports::engine::util::JRSaver
  java_import Java::net::sf::jasperreports::engine::export::ooxml::JRXlsxExporter
  java_import Java::net::sf::jasperreports::export::SimpleXlsxReportConfiguration
  java_import Java::java::io::FileOutputStream
  java_import Java::net::sf::jasperreports::engine::data::JRBeanCollectionDataSource 
  java_import Java::net::sf::jasperreports::engine::JasperCompileManager
  java_import Java::DataBean



  def generate_xls_report
    JasperIntegration::CompileReport.compile_report('E:\report\templates\sales\TestReport.jrxml')
      # generating data source
      jasper_file_path ='E:\report\templates\sales\TestReport.jasper'
      jrprint_file_path = 'E:\report\templates\sales\TestReport.jrprint'
      
      
      jdataBean = DataBean.new
      jdataBean.setName('Ambirsh')
      jdataBean.setCountry('India')
      
      jdataBean2 = DataBean.new
      jdataBean2.setName('Ayush')
      jdataBean2.setCountry('USA')

      arlist = ArrayList.new
      arlist.add(jdataBean) 
      arlist.add(jdataBean2)
      j
      rbeanCollectionDataSource = JRBeanCollectionDataSource.new(arlist)
      nmapobj = HashMap.new    
      source_f = java::io::File.new(jasper_file_path)
     
   
   
      mjasper_print_obj = JasperFillManager.fillReport(jasper_file_path,nmapobj,jrbeanCollectionDataSource)
      JRSaver.saveObject(mjasper_print_obj,jrprint_file_path)
    
      source_file =  java::io::File.new(jrprint_file_path)
      jasper_print =JRLoader.loadObject(source_file)

      dest_file = java::io::File.new(source_file.getParent(), jasper_print.getName()+"2"+".xlsx")
      
      exporter = JRXlsxExporter.new()
      exporter.setExporterInput(SimpleExporterInput.new(jasper_print.to_java(Java::net::sf::jasperreports::engine::JasperPrint)))
      exporter.setExporterOutput(SimpleOutputStreamExporterOutput.new(dest_file))
      configuration =  SimpleXlsxReportConfiguration.new
      configuration.setDetectCellType(true)
      configuration.setCollapseRowSpan(false)
      exporter.setConfiguration(configuration)
      exporter.exportReport()




  end


  def report_generate(jasper_name, data, params = {})
      jasper_dir = "E:/report/templates/sales"
      namespace, jasper_name = namespace_extract(jasper_name)
      file_resolver(params, namespace)
      file_name = File.join(jasper_dir || '.', namespace,
                            jasper_name + '.jasper')
      jasper_content = File.read(file_name)
      data = { jasper_name => data }.to_xml
      xpath_criteria = "/hash/#{jasper_name}/#{jasper_name.singularize}"
      source = JRXmlDataSource.new(
          ByteArrayInputStream.new(data.to_java_bytes), xpath_criteria)
      input = BufferedInputStream.new(
          ByteArrayInputStream.new(jasper_content.to_java_bytes))
      String.from_java_bytes(
          JasperRunManager.runReportToPdf(input, params, source))



  end

  def namespace_extract(name)
    parts = name.split('/')
    jasper_name = parts.pop
    namespace = parts.join('/')
    [namespace, jasper_name]
  end

  def file_resolver(params, namespace = '')
    resolver = Class.new { include FileResolver }.new
    image_directory = ''
    resolver.singleton_class.instance_eval do
      define_method :resolve_file do |filename|
        java::io::File.new(File.join(image_directory, namespace, filename))
      end
    end
    params['REPORT_FILE_RESOLVER'] = resolver
  end



  def generate_pdf_report
    pdf_content  = report_generate('JasperRportFileName',[{name: 'Ayush',country:'India'}])
    
    ff = File.open('your\report\file\path\newfile.pdf', 'wb' )
    ff.write(pdf_content)
    ff.close

  end



  
end
