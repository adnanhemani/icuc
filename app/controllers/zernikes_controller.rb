class ZernikesController < ApplicationController
    include ApplicationHelper  
    def zernike_params
    #    params.require(:zernike).permit(:uploaded_file)
    end
    
    def about
    end
    
    
    def main
        @zernikes = Zernike.zernikes
        @default = Zernike.getdefault # changed name from @params to @default (also from getparams to getdefault) because '@params' is a confusing instance variable name --VP
        @options = Zernike.options
    end 
    
    def manual
        @zernikes = Zernike.zernikes
        @nicknames = Zernike.zNicknames
    end
    
    def set_all_zero
        zer = []
        (0..65).each do |i|
            zer << params[0.to_s]
        end
        Zernike.setZernikes(zer)
        @zernikes = Zernike.zernikes
        redirect_to enter_manually_path
    end
    
    def update
        zer = []
        (0..65).each do |i|
            zer << params[i.to_s]
        end
        #sets in database
        Zernike.setZernikes(zer)
        #get it from the database
        @zernikes = Zernike.zernikes
        redirect_to root_path
    end
    
    def random
        Zernike.random
        @zernikes = Zernike.zernikes
        redirect_to root_path 
    end
    
    def compute
        if params["options"]
            session["options"] = params["options"]
            @checked_options = session["options"]
            @radio_type = @checked_options.keys[0]
            puts "radio_type", @radio_type
        elsif session["options"]
            @checked_options = session["options"]
            @radio_type = params["radio_option"]
            puts "radio type session", @radio_type
        end
	    zernikes = Zernike.zernikes[1,65]
	    if params[:astigmatismTo0]
             # in third row of pyramid,
             zernikes[3] = 0 # zeros out the first coeff
             zernikes[5] = 0 # zeros out the last coeff
        end
        parameters = []
        if params[:astigmatismTo0]
             # in third row of pyramid,
             zernikes[3] = 0 # zeros out the first coeff
             zernikes[5] = 0 # zeros out the last coeff
        end
        # hello to whoever implemented what is written below, can we change the "0..4" to parameters name so everyone knows what these values are?
        # currently, these are either manually set on the main page OR filled in with Zernike.getdefault
        # 0 : pupil diameter from file, 1: pupil defocus from file, 
        # and under "Additional Inputs" 2: wavelength for calculation, 3: output image size, 4: pupil field size
        # I was thinking of changing these numbers to what they actually map to --VP
        (0..4).each do |i|
            parameters << params[i.to_s]
        end 
        
        
        options = []
        Zernike.options.each do |opt|
            if params[:options] != nil and params[:options][opt] == "1"
                options << 1
            else
                options << 0
            end
        end 
        
        #flash[:notice] = zernikes.to_s + parameters.to_s + options.to_s
        # to run matlab code. 
        @files = ApplicationHelper.compute(zernikes, parameters, options)
        
        #flash[:notice] =  zernikes.length.to_s + " " +parameters.length.to_s + " " + options.length.to_s 
        #system("ls app/assets/images/computed* > app/assets/list.txt")
        #files = []
        #f = File.open("app/assets/list.txt", "r")
        
	#value = Zernike.image_types.values_at(@radio_type)
	#puts value

        #f.each_line do |line|
        #    line =~ /(compute.*jpg)/
	#    temp = get_file_image_type(line, @radio_type)
        #    if $1 != nil and temp == value[0]
	#        puts "entered if", line
        #        files << $1
        #    end
        #end
        #@files = files
        #need to remove unique id for this files eventually
    end
    
    def get_file_image_type(file, radio_type)
        image_type_pat = /.*-(.*)\..*$/ 
        file =~ image_type_pat
        return $1
    end
        
    #Upload action ensures that submitted file is uploaded if it meets the requirements
    def upload
       # connected to upload.html.haml form
       # looks for :zernike in params, existence means file is attached
       # significant help from "http://www.tutorialspoint.com/ruby-on-rails/rails-file-uploading.htm"
        if params[:zernike]
            uploaded_file = params[:zernike][:attachment]
            file_name = uploaded_file.original_filename
            jsonified_file = uploaded_file.as_json["tempfile"]
            rfit_extractor(jsonified_file)
            
            coefficients_extractor(jsonified_file) # puts coefficients in a hash, params[:coefficients]
            Zernike.getpupdiam(params[:rfit])
            @zernike_coefficients = params[:coefficients]
            # p @zernike_coefficients.length
            if @zernike_coefficients.nil? or @zernike_coefficients.empty? or @zernike_coefficients.length != 66
                flash[:notice] = "Unable to upload file"
            else
                flash[:notice] = "File successfully uploaded!"
                coef = []
                @zernike_coefficients.each do |c|
                    coef << c[1].to_f
                end
                Zernike.setZernikes(coef)
            end
            redirect_to root_path 
        end
    end
    
    ###
    # app/controllers/documents_controller.rb
    def document_params
        params.require(:document).permit(:file)
    end
    
    private
    def coefficients_extractor(jsonified_file)
        important_lines = /^[^#].*/i  # extracts lines that matter, the ones with numbers
        no_space = /(.+)\s+(.+)\s+(.+)/ # separates the numbers
        coefficients = Hash.new(0)
        for key in jsonified_file
            line = important_lines.match(key)
            if line.nil?
                next
            else
                everything = no_space.match(line[0])
                if not everything.nil?
                    subscript = everything[1]
                    superscript = everything[2]
                    coefficient = everything[3]
                    # puts no_space.match(line[0])[1]
                    coefficients["Z#{subscript}_#{superscript}"] = coefficient
                end
            end
        end
        params[:coefficients] = coefficients
            # format printed loosely is : subscript superscript actual_coefficient
    end
    
    def rfit_extractor(jsonified_file)
        find_rfit = /^#RFIT (.*)\r/i #extracts the RFIT value from the .zer file
        for key in jsonified_file
            line = find_rfit.match(key)
            if line.nil?
                next
            else
                rfit = line[1]
                params[:rfit] = rfit
                p rfit
                return
            end
        end
    end

end
