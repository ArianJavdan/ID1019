defmodule Mandel do

    #def rows(width, height, trans, depth, list) when list == [] do 
    #    list2 = rows(width, height, trans, depth, )
    # end

     def onerow(0, height, trans, depth, list) do
        
        list
    end
        def rows(_, 0, trans, depth, list) do 
        list
    end
    def onerow(width, height, trans, depth, list) do
        #generate compelx number
       
        comp = trans.(width, height)
        #calculate depth
       
        de = Brot.mandelbrot(comp, depth)
        #convert depth to color         
       
        color = Color.convert(de, depth)
       
        onerow((width - 1), height, trans, depth, [color | list])
    end


    def rows(width, height, trans, depth, list) do
        
        one = onerow(width, height, trans, depth, [])
        rows(width, (height - 1), trans, depth, [one | list])
    end



    def mandelbrot(width, height, x, y, k, depth) do
        trans = fn(w, h) ->
            Cmplx.new(x + k * (w - 1), y - k * (h - 1))
        end
        rows(width, height, trans, depth, [])
    end

end