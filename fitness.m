function [F] = fitness(fit,idx,xy)
    if (fit == 1) % peaks
        x = xy(idx,1);
        y = xy(idx,2);
        
        F =  3*(1-x)^2*exp(-(x^2) - (y+1)^2) ... 
           - 10*(x/5 - x^3 - y^5)*exp(-x^2-y^2) ... 
           - 1/3*exp(-(x+1)^2 - y^2);
       
    elseif (fit == 2) % goldsteen
        x1bar = 4*xy(idx,1) - 2;
        x2bar = 4*xy(idx,2) - 2;

        fact1a = (x1bar + x2bar + 1)^2;
        fact1b = 19 - 14*x1bar + 3*x1bar^2 - 14*x2bar + 6*x1bar*x2bar + 3*x2bar^2;
        fact1 = 1 + fact1a*fact1b;

        fact2a = (2*x1bar - 3*x2bar)^2;
        fact2b = 18 - 32*x1bar + 12*x1bar^2 + 48*x2bar - 36*x1bar*x2bar + 27*x2bar^2;
        fact2 = 30 + fact2a*fact2b;

        prod = fact1*fact2;

        F = (log(prod) - 8.693) / 2.427;
    end
end

