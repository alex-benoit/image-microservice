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
    render json: photo_json(photo)
  end

  private

  def photo_json(photo)
    transformations = photo.photo_transformations.map { |t| transformation_json(t) }
    {
      id: photo.id,
      source_id: photo.image.id,
      public_url: photo.image.url(public: true),
      size: photo.image.metadata['size'],
      completed_transformation: transformations
    }
  end

  def transformation_json(transformation)
    {
      id: transformation.id,
      source_id: transformation.image.id,
      public_url: transformation.image.url(public: true),
      size: transformation.image.metadata['size'],
      specs: transformation.specs
    }
  end
end
