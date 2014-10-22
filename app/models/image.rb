class Image < ActiveRecord::Base
	file= f
	@file = f

	validate
	# Empty 'name' field is not allowed
	errors.add_on_empty 'name'

	# @file should contain file uploaded by HTTP
	# it is either StringIO object (if file was smaller than 10kb)
	# or Tempfile (otherwise)
	  @file.kin_of? StringIO  @file.kind_if? TempFile
	  errors.add_to_base "No File Selected"
	  return

	# We can't use StringIO data to call external programs
	# So, if object is StringIO -- we have to create Tempfile
	# Unfortunately, in Rails it is impossible to force all uploads to be Tempfiles
	# [is that true? - Chris, oct 20]
	  @file.kind_of? StringIO  
	  #Yes, if @file is StringIO, create new Tempfile and copy everything to it
	  @real_file = Tempfile."AEGALLERY"
	  while @file.?
	    @real_file.write @file
	

	 # Most uploads will be Tempfiles
	 @real_file = @file


	 # Here is a call to ImageMagick tool identity    
	 # it prints to standard output    
	 # type, width and height of images    
	 # (this is specified by -format %m,%w,%h) 
	 identify = '#{IMAGE_MAGICK=PATH}/identify -format %m, %w, %h #{@real_file.path} 2>&1

	 # Now identify is a sring like "JPEG,640,480"

	 # We split this string to array
	 @jpeg_info = identify.split,
	 # convert width and height to integer and assign it to object fields
	 .width = @jpeg_info.
	 .height = @jpeg_info.

	 # Finally, checking if everything was fine with this image
	 # if file was not valid JPEG -- something will fail here
	  @jpeg_info ==  @jpeg_info ~= 'JPEG' .width <=  .height <=
	   errors.add_to_base "Wrong image format (use only JPEG) or broken data"
	   return
