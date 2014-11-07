require "pnm"
require './rs_m.rb'

$f = [method(:f0), method(:f1), method(:f2)]
mask = [0, 1, 0, -1]

image = PNM.read(ARGV[0]).pixels

images_sample = Array.new
images_sample.push get_4tuple(image.clone)

1.upto(100) do |i|
    images_sample.push get_4tuple(invert_pixels_rand(image.clone, i))
    # print "\r#{i}/100   "
end
# puts ''

samle_result = Array.new

c = 1

images_sample.each do |sample|
    h = Hash.new
    h["Rmp"] = 0.0
    h["Rmm"] = 0.0
    h["Smp"] = 0.0
    h["Smm"] = 0.0
    h["Ump"] = 0.0
    h["Umm"] = 0.0

    #direct
    sample.each do |tuple|
        # puts tuple.to_s
        d_orig = d_4tuple(tuple)
        d_modif = d_4tuple(convert_4tuple(tuple.clone, mask))
        h["Rmp"] += 1.0 if d_orig < d_modif
        h["Smp"] += 1.0 if d_orig > d_modif
        h["Ump"] += 1.0 if d_orig == d_modif
    end

    #reverse (mask)
    mask.map! {|m| m *= -1}

    sample.each do |tuple|
        d_orig = d_4tuple(tuple)
        d_modif = d_4tuple(convert_4tuple(tuple.clone, mask))
        h["Rmm"] += 1.0 if d_orig < d_modif
        h["Smm"] += 1.0 if d_orig > d_modif
        h["Umm"] += 1.0 if d_orig == d_modif
    end

    # print "\r#{c}/#{images_sample.size}       "

    h["Rmp"] /= image.size.to_f**2 /400
    h["Rmm"] /= image.size.to_f**2 /400
    h["Smp"] /= image.size.to_f**2 /400
    h["Smm"] /= image.size.to_f**2 /400
    h["Ump"] /= image.size.to_f**2 /400
    h["Umm"] /= image.size.to_f**2 /400

    samle_result.push h
    c += 1
end



# puts ''

# print_from_key(samle_result, 'Rmp')
# print_from_key(samle_result, 'Rmm')
# print_from_key(samle_result, 'Smp')
# print_from_key(samle_result, 'Smm')
# print_from_key(samle_result, 'Ump')
# print_from_key(samle_result, 'Umm')
print_from_key_all(samle_result)


















