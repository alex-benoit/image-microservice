class PhotoTransformationsController < ActionController::API
  def create
    # unless PhotoTransformation::SUPPORTED_FORMATS.include? params[:format]
    #   return render json: { error: 'format not supported' }, status: :bad_request
    # end

    photo = Photo.find(params[:id])
    transformation_specs = params.except(:id, :controller, :action)
    transformation = photo.photo_transformations.find_by(specs: transformation_specs)
    if transformation
      redirect_to transformation_path(transformation)
    else
      image = MiniMagick::Image.open(photo.image.url(public: true))
      transformation_specs.each do |spec, value|
        image.send(spec, value)
      end
      transformation = PhotoTransformation.new(
        photo: photo,
        specs: transformation_specs,
        image: File.open(image.path)
      )
      if transformation.save
        redirect_to transformation_path(transformation)
      else
        render status: :bad_request
      end
    end
  end

  def show
    transformation = PhotoTransformation.find(params[:id])
    render json: transformation_json(transformation)
  end

  private

  def transformation_json(transformation)
    {
      id: transformation.id,
      source_id: transformation.image.id,
      public_url: transformation.image.url(public: true),
      size: transformation.image.metadata['size'],
      specs: transformation.specs,
      original_photo_id: transformation.photo.id,
      original_photo_link: transformation.photo.image.url(public: true)
    }
  end
end
