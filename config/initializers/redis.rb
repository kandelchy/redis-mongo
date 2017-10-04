redis_options = {
  url: 'redis://example-test',
  sentinels: [ { host: "127.0.0.1", port: 26379 },
               { host: "127.0.0.1", port: 26379 },
               { host: "127.0.0.1", port: 26379 }],
  role: 'master'
}


$REDIS = Redis.new(redis_options)

$messageno=1
puts $REDIS.set("number","***********SENDING MESSAGE No. #{$messageno} *********")
# while true
#   begin
#     messageno=messageno+1
#     # puts REDIS.set "key" , "********messageno*****""
#     puts REDIS.set("number","***********SENDING MESSAGE No. #{messageno} *********")
#     puts messageno
#   rescue => e
#     puts "failed?", e
#     sleep 5
#   end
#   sleep 2
#
# end
