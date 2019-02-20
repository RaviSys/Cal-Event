CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                        
  config.fog_credentials = {
    provider:              'AWS',                        
    aws_access_key_id:     'xxx',                        
    aws_secret_access_key: 'yyy',                        
    use_iam_profile:       true,                         
    region:                'us-east-1',                  
    host:                  's3.example.com',             
    endpoint:              'https://s3.example.com:8080' 
  }
  config.fog_directory  = 'name_of_bucket'                                      
  config.fog_public     = false                                                 
  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" } 
end
