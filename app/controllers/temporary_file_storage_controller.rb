class TemporaryFileStorageController < ApplicationController
  def new
  	@tempfile = TemporaryFileStorage.new
  	# render :json => @tempfile
  	# return
  end
  def index
  	@tempfile = TemporaryFileStorage.new
  	render :json => params
  	return
  	# @tempfile = TemporaryFileStorage.new
  	# render :json => @tempfile
  	# return
  end
  def create
  	render :json => params
  	return
  	# @tempfile = TemporaryFileStorage.new
  	# render :json => @tempfile
  	# return
  end
end
