require_relative '../../lib/skejuler/aws/connector'

# ec2 doc: http://docs.aws.amazon.com/sdkforruby/api/Aws/EC2.html

# to backup ec2 instance
def backup(options = {})
  my_aws = {
    region: ENV['AWS_REGION'],
    access_method: 'api_key',
    access_key: ENV['AWS_API_KEY'],
    secret_key: ENV['AWS_SECRET_KEY']
  }
  conn = ::Skejuler::Aws::Connector.new(my_aws)
  ec2 = conn.ec2 # Aws EC2 Client library

  ec2.describe_instances
  instance_id = options.fetch(:instance_id)
  puts instance_id
  # do something on it
end

rds = Aws::RDS::Resource.new( )



puts "Enter the db instance you need to perform the action"
dbInstanceID = gets.chomp
dbInstance=rds.db_instance(dbInstanceID)


# Testing
backup instance_id: 'i-123456'
