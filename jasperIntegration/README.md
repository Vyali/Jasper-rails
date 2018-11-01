# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* JRuby version                       9.2.0
* Rails versio                        5.0.7
* Build Tool                           maven dependency 


* Deployment instructions
  pull using git 
  
  1.install maven for dependency reolution (This project needed jasper related jar(pom) mentioned in pom.xml and also one more jar file is     needed DataBean.jar)
  2. run this command for downloading needed dependencies 
    $> mvn clean dependency:copy-dependencies -DoutputDirectory=/dir/for/jars
  3. In report_controller_controller.rb
  
  
  generate_xls_report() 
  call this method to generate report in xlsx format 
  
  generate_pdf_report
  To generate pdf format report
  
  *Jar file explanation
  databean.jar
  
  DataBean class looks like this 
  
  
  public class DataBean{

    String name;
    String country;

    public void setName(String n){
        name=n;
    }

    public void setCountry(String c)
    {
        country = c;
    }

    public String getCountry(){
        return country;
    }
    public String getName(){
        return name;
    }
}



Here name and country properties are the field name in .jrxml file 
Jasper will actually look for getFiledName() method i.e here it will look for getName() and getCountry() method 

jasper field will look something like this 

<field name="name" class="java.lang.String">
		<fieldDescription><![CDATA[name]]></fieldDescription>
	</field>
  


* ...
