Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: 'json'} do
    get "/" => "report#process"
  end
  get "/" => "application#index"
  get "report" => "report_controller#index"
  get "run_report" => "report_controller#run_report"
  get "read_pdf" => "report_controller#read_pdf"
  get "get_xls" => "report_controller#generate_xls_report"
  end
