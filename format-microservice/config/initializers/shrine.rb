require 'shrine/storage/s3'

s3_options = {
  access_key_id:     ENV['digital_ocean_spaces_key'],
  secret_access_key: ENV['digital_ocean_spaces_secret'],
  bucket:            ENV['digital_ocean_spaces_bucket'],
  endpoint:          'https://ams3.digitaloceanspaces.com',
  region:            'ams3'
}

Shrine.storages = {
  store: Shrine::Storage::S3.new(prefix: 'store', upload_options: { acl:  'public-read' }, **s3_options),
  cache: Shrine::Storage::S3.new(prefix: 'cache', upload_options: { acl:  'public-read' }, **s3_options)
}

Shrine.plugin :activerecord
