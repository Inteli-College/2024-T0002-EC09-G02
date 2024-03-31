import os



regions = ["north", "south", "east", "west", "center"]

# sensors = ["solar","gas","PM","nosie",]

for region in regions:
    for sensor in sensors:
        command = """curl \
  -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Basic Uk00QUJHMzU0S0RRSVg1TjpZZnRHMEl3aXI1TW1OZGNuUHdOd0llTi95SFVocXhVd1krWElucStBUUNCb21XcTEvSGtHV0FWM0EwWXJpWjBn" \
  https://pkc-4v5zz.sa-east-1.aws.confluent.cloud:443/kafka/v3/clusters/lkc-7ko3p1/topics \
  -d '{"topic_name":"north_solar"}'""".replace("north_solar", "sensor"+"/"+region)
        os.system(command)
        