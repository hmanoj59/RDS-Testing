require 'aws-sdk-core'

module Skejuler
  module Aws

    # AWS Cloud Connector
    class Connector

      # Initialize a new instance of Connector
      # Sample connect_info structure (using API Key):
      # {
      #   region: 'us-east-1',
      #   access_method: 'api_key',
      #   access_key: 'AWS API Key',
      #   secret_key: 'AWS Secret Key'
      # }
      # Sample connect_info structure (using IAM Role):
      # {
      #   region: 'us-east-1',
      #   access_method: 'iam_role',
      #   iam_role_arn: 'IAM Role ARN',
      #   external_id: 'some external id',
      #   name: 'session_name'
      # }
      def initialize(connect_info = {})
        @connect_info = connect_info
        @region = connect_info.fetch(:region, 'us-east-1')
      end

      def ec2
        ::Aws::EC2::Client.new(region: @region, credentials: aws_credential)
      end

      def rds
	       ::Aws::RDS::Client.new(region: @region, credentials: aws_credential)
      end

      def verify_connection()
        return false
      end

      # @return [Array(string)] a list of AWS partition names
      #   ['aws', 'aws-cn', 'aws-us-gov']
      def self.partitions
        ::Aws.partitions
      end

      # @return [Array[string]] a list of AWS regions specific to AWS partition
      def self.regions(partition_name)
        ::Aws.partition(partition_name).regions
      end

      protected

      # @return AWS Credential
      def aws_credential
        # Using key pair (The AWS Key pairs are defined in .env file)
        # please make sure the IAM user has been granted AssumeRole by adding
        # inline policy for the user holding this AWS Key pair
        # {
        #     "Version": "2012-10-17",
        #     "Statement": [
        #         {
        #             "Sid": "Stmt1462788802000",
        #             "Effect": "Allow",
        #             "Action": [
        #                 "sts:AssumeRole"
        #             ],
        #             "Resource": [
        #                 "*"
        #             ]
        #         }
        #     ]
        # }
        if @connect_info.fetch(:access_method) == "IAM Role"
          # using IAM Role access method
          return ::Aws::AssumeRoleCredentials.new(
            # NOTE: We use the API Key credential defined in .env file for host API key pair
            client: ::Aws::STS::Client.new(region: @region),
            role_arn: @connect_info.fetch(:iam_role_arn),
            external_id: @connect_info.fetch(:external_id),
            role_session_name: @connect_info.fetch(:name)
          )
        else
          # using API Key pair method
	  puts @connect_info.inspect
          return ::Aws::Credentials.new(
	    @connect_info.fetch(:access_key),
	    @connect_info.fetch(:secret_key)
          )
        end
      end

    end

  end
end
