defmodule Brot do
    def mandelbrot(c, m) do
        z0 = Cmplx.new(0,0)
        i = 0
        test(i, z0, c, m)
    end
    def test(i , z0, c, m) do
        if (i == m) do 
            0
        else 
            if (Cmplx.abs(z0) > 2) do
                i 
            else 
                test(i+1, Cmplx.add(Cmplx.sqr(z0), c), c, m)
            end    
        end 
    end
end