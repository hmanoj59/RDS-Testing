require_relative '../../lib/skejuler/aws/connector'
require 'aws-sdk'

# eds doc: http://docs.aws.amazon.com/sdkforruby/api/Aws/EC2.html

# to backup rds instance
def backup(options = {})
  my_aws = {
    region: ENV['AWS_REGION'],
    access_method: 'api_key',
    access_key: ENV['AWS_API_KEY'],
    secret_key: ENV['AWS_SECRET_KEY']
  }
   conn = ::Skejuler::Aws::Connector.new(my_aws)

   rds = conn.rds # Aws RDS Client library

  rds.describe_db_instances
  instance_id = options.fetch(:instance_id)
  puts instance_id
  # do something on it

end

# rds = Aws::RDS::Client.new(region: 'us-east-1e')
 rds = Aws::RDS::Resource.new( )



# Listing the available RDS Db_instances

# rds.db_instances.each do |db_instance|
#   puts db_instance.id
# end




#    #Creating a DB Instance
#
# puts "Enter the DB Instance identifier"
#  dbinstide = gets.chomp
#  rds.create_db_instance({
#                                      db_name: "TESTSQL",
#                                      db_instance_identifier: dbinstide, # required
#                                      allocated_storage: 5,
#                                      db_instance_class: "db.t2.micro", # required
#                                      engine: "mysql", # required
#                                      master_username: "naga",
#                                      master_user_password: "password",
#                                      # db_security_groups: ["String"],
#                                      # vpc_security_group_ids: ["String"],
#                                      multi_az: false,
#                                      publicly_accessible: true,
#                                   })
# puts "Creating DB Instance, " + dbinstide + " this may take few minutes"



puts "Enter the db instance you need to perform the action"
dbInstanceID = gets.chomp
# dbInstance=rds.db_instance(dbInstanceID)
dbsnapshot=rds.db_snapshot(dbInstanceID)



#  #creating a snapshot of a RDS Instance
#
# dbInstance.create_snapshot({
#                                db_snapshot_identifier: dbInstanceID + ((Time.now).strftime("%Y-%d-%m-%I-%M-%S")), # required
#                                tags: [
#                                    # {
#                                    #     key: "String",
#                                    #     value: "String",
#                                    # },
#                                ],
#                            })
# puts "Creating the snapshot for the instance " + dbInstanceID + " this may take few minutes"
#



#   #Deleting the instance

# dbInstance.delete({
#                       skip_final_snapshot: false,
#                       # final_db_snapshot_identifier: dbInstanceID + ((Time.now).strftime("%Y-%d-%m-%I-%M-%S")),
#                   })
# puts "Deleting the instance " + dbInstanceID + " this may take few minutes"
#
#
#
# #

#   # Restoring the db instance from snapshot

#
# dbInstance.restore({
#                        target_db_instance_identifier: "sqltest2", # required
#                        # restore_time: 2009-9-7T23:45:00Z,
#                         use_latest_restorable_time: true,
#                        # db_instance_class: "String",
#                        # port: 1,
#                        # availability_zone: "String",
#                        # db_subnet_group_name: "String",
#                        # multi_az: false,
#                        publicly_accessible: true,
#                        # auto_minor_version_upgrade: false,
#                        # license_model: "String",
#                        # db_name: "sqldbtest",
#                        # engine: "MySQL 5.6.27",
#                        # iops: 1,
#                        # option_group_name: "String",
#                        # copy_tags_to_snapshot: false,
#                        # tags: [
#                        #     {
#                        #         key: "String",
#                        #         value: "String",
#                        #     },
#                        # ],
#                        # storage_type: "String",
#                        # tde_credential_arn: "String",
#                        # tde_credential_password: "String",
#                        # domain: "String",
#                        # domain_iam_role_name: "String",
#                    })
# puts "Restoring the DB Instance from snapshot, this may take few minutes"



dbsnapshot.restore({
                       db_instance_identifier: "sqltesting", # required
                       # db_instance_class: "String",
                       # port: 1,
                       # availability_zone: "String",
                       # db_subnet_group_name: "String",
                       multi_az: false,
                       publicly_accessible: true,
                       # auto_minor_version_upgrade: false,
                       # license_model: "String",
                       # db_name: "String",
                       # engine: "String",
                       # iops: 1,
                       # option_group_name: "String",
                       # tags: [
                       #     {
                       #         key: "String",
                       #         value: "String",
                       #     },
                       # ],
                       # storage_type: "String",
                       # tde_credential_arn: "String",
                       # tde_credential_password: "String",
                       # domain: "String",
                       # copy_tags_to_snapshot: false,
                       # domain_iam_role_name: "String",
                   })

puts "Restoring the snapshot"
#testing
backup instance_id: 'i-123456'