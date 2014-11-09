def f1(n)
    return (n + 1) if n%2 == 0
    (n - 1)
end

def f0(n)
    n
end

#f-1
def f2(n)
    (f1(n + 1) - 1)
end

#parse mage in 4-tuple sets
def get_4tuple(images_pixels)
    out = Array.new 
    images_pixels.each do |i| 
        j = i.clone
        while(j.size > 0)
            out.push j.pop(4)
        end
    end
    out
end

#lsb inversion; size_p % of image
def invert_pixels(images_pixels, size_p)
    size = images_pixels.size.to_f * images_pixels.size.to_f * size_p.to_f * 0.01
    size.to_i.times do |i|
        t = images_pixels[i/images_pixels.size][i%images_pixels.size]
        t -= 1 if t % 2 == 0
        t += 1 if t % 2 != 0
        images_pixels[i/images_pixels.size][i%images_pixels.size] = t
    end
    images_pixels
end

#lsb inversion random pixels; size_p % of image
def invert_pixels_rand(images_pixels, size_p)
    puts images_pixels[150][160]

    images_pixels.map! {|el| el.clone}
    r = Random.new
    size = images_pixels.size.to_f * images_pixels.size.to_f * size_p.to_f * 0.01
    indexes = Array.new 
    size.to_i.times { indexes.push r.rand(0..images_pixels.size*images_pixels.size - 1)}
    indexes.uniq!
    unless(indexes.size < size.to_i)
        (size.to_i - indexes.size).times {indexes.push r.rand(0..images_pixels.size*images_pixels.size)}
        indexes.uniq!
    end

    indexes.each do |i|
        # puts i 
        # puts i/images_pixels.size
        # puts i%images_pixels.size
        t = images_pixels[i/images_pixels.size][i%images_pixels.size]
        t -= 1 if t % 2 == 0
        t += 1 if t % 2 != 0
        images_pixels[i/images_pixels.size][i%images_pixels.size] = t
    end
    images_pixels
end

#use f-function on 4-tuple with mask
def convert_4tuple(tuple4, mask) 
    4.times do |i|
        tuple4[i] = $f[mask[i]].call(tuple4[i])
    end
    tuple4
end

#discr function
def d_4tuple(tuple4)
    # puts tuple4
    out = 0
    0.upto(2) do |i|
        out += (tuple4[i+1] - tuple4[i]).abs
    end
    out
end

def print_from_key(set, key)
    #puts key
    set.each do |el|
        print "#{el[key]} "
    end
    puts "\n"

end 

def print_from_key_all(set)
    set.each do |el|
        puts "#{el["Rmp"].round(2)} #{el["Rmm"].round(2)} #{el["Smp"].round(2)} #{el["Smm"].round(2)} #{el["Ump"].round(2)} #{el["Umm"].round(2)}"
    end
end
