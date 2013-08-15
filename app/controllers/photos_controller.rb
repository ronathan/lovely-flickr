class PhotosController < ApplicationController
	
	before_action :require_current_user, except: [:show, :search]

	def index
		render text: "Coming soon!"
	end

	def show
		@photo = Photo.find(params[:id])
	end

	def new
		@photo = Photo.new
	end

	def create
		@photo = Photo.new(photo_params)
		@photo.user = @current_user
		if @photo.save
      UserMailer.create_photo(@photo.user).deliver
      redirect_to photo_path(@photo)
    else
      render action: :new
    end
	end

	def buy
		customer = Stripe::Customer.create(
			email: params[:email],
			card: params[:stripeToken]
		)

		Stripe::Charge.create(
			customer: customer.id,
			amount: Photo::PRICE,
			currency: 'cad'
		)

	rescue Stripe::CardError => error
    flash[:error] = error.message
    redirect_to photo_path(params[:id])
	end

	def search
		@results = Photo.search_for params[:query]
	end


	private

	def photo_params
		params.require(:photo).permit(:title, :description, :upload)
	end

end
