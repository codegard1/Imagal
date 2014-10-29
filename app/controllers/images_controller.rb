class ImagesController < ApplicationController

	def new
	  @image = Image.new
	end

	def edit
	end

	def show
	  @image = Image.find(params[:id])
	end

	def create
	  @image = Image.create
	end
end
