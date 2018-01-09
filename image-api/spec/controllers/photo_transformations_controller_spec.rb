require 'rails_helper'
require 'rack/test'

describe PhotoTransformationsController, type: :controller do
  include Rack::Test::Methods

  before(:each) do
    post '/photos', photo: Rack::Test::UploadedFile.new('spec/support/alex.jpg', 'image/jpeg')
    @photo = Photo.last
    @count = @photo.photo_transformations.count
  end

  context 'GET /photos/:id/transform' do
    it 'format transforms' do
      get "/photos/#{@photo.id}/transform?format=png"
      expect(@photo.photo_transformations.count).to eq(@count + 1)
      expect(PhotoTransformation.last.specs).to eq({ "format" => 'png' })
    end

    it 'does not reupload if already transformed' do
      get "/photos/#{@photo.id}/transform?format=png&size=100x100"
      get "/photos/#{@photo.id}/transform?format=png&size=100x100"
      get "/photos/#{@photo.id}/transform?format=png&size=100x100"
      expect(@photo.photo_transformations.count).to eq(@count + 1)
    end

    # it 'fails if format not supported' do
    #   get "/photos/#{@photo.id}/transform?format=abc"
    #   expect(response.status).to eq(400)
    # end
  end

  context 'GET /transformations/:id' do
    it 'shows information on a specific transformed photo' do
      get "/photos/#{@photo.id}/transform?format=png&size=100x100"
      transformation = PhotoTransformation.last
      get "/transformations/#{transformation.id}"
      expect(response).to be_success
    end
  end
end
