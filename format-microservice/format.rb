require 'bunny'

conn = Bunny.new
conn.start
ch = conn.create_channel
q  = ch.queue('format')

q.subscribe(block: true) do |delivery_info, metadata, payload|
  puts "Received #{payload}"
end
