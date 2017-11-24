using Images
using TestImages
using Colors
using HDF5
using Images, ImageView, Colors, FixedPointNumbers


"""
     read_all_from_dir(dir_name,extension)
Reads in all file names from a directory matching the provided suffix.
The '.' should appear!
In the CODE:
    The FILTER function can be written with a DO ... END notation; the
    difference is that it outputs logicals...
"""
files_from_dir(dir_name::AbstractString,file_ext::AbstractString) = (
    filter(readdir(dir_name)) do fn
        isfile(joinpath(dir_name,fn)) && splitext(fn)[2]==file_ext
    end
)


"""
     images_from_dir(dir_name,sizeX,sizeY)
Reads in all images (= JPG ext) into a vector. If the images have different
sizes, it'll set the size to the one required.
"""

images_from_dir(dir_name,sizeX,sizeY) = map(files_from_dir(dir_name,".jpg")) do fn
    img = load(joinpath(dir_name,fn))
    #img = convert(Image{Gray}, img)
    img = Gray.(img)
    res_img = Images.imresize(img, (sizeX,sizeY))
    convert(Array{Float64,2},res_img)[:]'
end

"""
     to_matrix(list_of_vec::Array{Array{Any,2},1})
Collects into a single array the list of lists.
    Technical detail.
"""
function to_matrix(list_of_vec)
    m = length(list_of_vec)
    n = length(list_of_vec[1])
    ret_mat = zeros(m,n)
    for ii=1:m
        ret_mat[ii,:] = list_of_vec[ii][:]'
    end
    return ret_mat
end; # function to_matrix



"""
     write_images_to_hdf5(file_name,data_name,data)
Writes data to a HDF5 file. This is required to work with Mocha. To use this
file, one must use HDF5:
    using HDF5
before being able to call the function.
"""
write_images_to_hdf5(file_name,data_name,data) = h5open(file_name, "w") do file
    write(file, data_name, data)  # alternatively, say "@write file A"
end

"""
     read_images_from_hdf5(file_name,data_name)
Read images from a HDF5 file, this is used for testing purposes. To use
this file, one must use HDF5:
        using HDF5
before being able to call the function.
"""
read_images_from_hdf5(file_name,data_name) = h5open(file_name, "r") do file
    read(file, data_name)
end

"""
     test_script()
Tests the implemented system
"""
function test_script()
    # declaring constants
    img_path = "./Pictures"
    B = images_from_dir("./Pictures",200,200)
    #C = to_matrix(B)
    #write_images_to_hdf5("test_48000.h5","X",C)
end