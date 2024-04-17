class EventJob < ApplicationJob
  S3_BUCKET           = "jets-s3-test-bucket-001".freeze
  SUBSCRIPTION_PROPS  = {
    FilterPolicyScope: "MessageBody",
    FilterPolicy: {
      Records: {
        s3: {
          object: {
            key: [
              { prefix: "test-prefix/" }
            ]
          }
        }
      }
    }.to_json
  }.freeze
  
  # Example of a job that is triggered by an S3 event with a filter policy
  s3_event(S3_BUCKET, sns_subscription_properties: SUBSCRIPTION_PROPS)
  def filtered
    puts "Filtered event: #{JSON.dump(event)}"
  end

  # Example of a job that is triggered by an S3 event without a filter policy
  s3_event(S3_BUCKET)
  def unfiltered
    puts "Unfiltered event: #{JSON.dump(event)}"
  end
end
