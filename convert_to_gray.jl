#short julia script to make a gray copy of the pictures in the images directory

using Images
function convert_images_to_standard_format()
    dirname = "Pictures";
    dirgray = "GrayPictures";
    dirrgb = "RGBPictures";
    sizeX = 400;
    sizeY = 400;
    gray="_gray";
    rgb="_rgb";
    jpg=".jpg";
    #create the directory in which the grayscale picture will be saved
    mkdir("./GrayPictures");
    mkdir("./RGBPictures");

    c=1;
    
        #traverse pictures and filter by appropiate format
            for i in filter(x -> ismatch(r"\.jpg|\.png|\.jpeg", x), readdir(dirname))
                img = load("./$dirname/$i")
                #convert to gray
                imgg = Gray.(img)
                #resize the gray images
                res_gray_img = Images.imresize(imgg, (sizeX,sizeY))
                #resize the rgb images
                res_rgb_img= Images.imresize(img,(sizeX,sizeY))
                
               
                #Createing names for each picture
                grayname= string(c, gray, jpg)
                rgbname= string(c, rgb, jpg)

                #save gray image to the desired directory
                img = save("./$dirgray/$grayname", res_gray_img)
                #save rgb image to the desired directory
                img = save("./$dirrgb/$rgbname", res_rgb_img)
                c += 1
            end
end