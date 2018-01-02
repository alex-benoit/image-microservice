class PhotosController < ActionController::API
  def create
    photo = Photo.new(image: params[:photo])
    if photo.save
      render json: {
        id: photo.id,
        source_id: photo.image.id,
        public_url: photo.image.url(public: true),
        mime_type: photo.image.mime_type,
        size: photo.image.metadata['size']
      }
    else
      render status: :bad_request
    end
  end

  def show
    photo = Photo.find(params[:id])
    if params['file_format'].present?
      RabbitService.dispatch('format', {
        id: photo.id,
        public_url: photo.image.url(public: true)
      })
    else
      render json: {
        id: photo.id,
        source_id: photo.image.id,
        public_url: photo.image.url(public: true),
        mime_type: photo.image.mime_type,
        size: photo.image.metadata['size']
      }
    end
  end
end
