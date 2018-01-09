require 'rails_helper'
require 'rack/test'

describe PhotosController, type: :controller do
  include Rack::Test::Methods

  context 'POST /photos' do
    it 'uploads a photo from a multipart upload' do
      count = Photo.count
      post '/photos', photo: Rack::Test::UploadedFile.new('spec/support/alex.jpg', 'image/jpeg')
      expect(response).to be_success
      expect(Photo.count).to eq count + 1
    end
  end

  context 'GET /photos/:id' do
    it 'shows information on a specific uploaded photo' do
      post '/photos', photo: Rack::Test::UploadedFile.new('spec/support/alex.jpg', 'image/jpeg')
      photo = Photo.last
      get "/photos/#{photo.id}"
      expect(response).to be_success
    end
  end
end
