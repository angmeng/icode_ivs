class HelloApi < ActionWebService::API::Base
  api_method :hello_message, :expects => [{:name=>:string}, {:email=>:string}], :returns => [:string]
end
