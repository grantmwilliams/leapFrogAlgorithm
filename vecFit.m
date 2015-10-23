function [F] = vecFit(fit,xy)
    if (fit == 1) % peaks
        F =  3*(1-xy(:,1)).^2.*exp(-(xy(:,1).^2) - (xy(:,2)+1).^2) ... 
           - 10*(xy(:,1)/5 - xy(:,1).^3 - xy(:,2).^5).*exp(-xy(:,1).^2-xy(:,2).^2) ... 
           - 1/3*exp(-(xy(:,1)+1).^2 - xy(:,2).^2);
    
    elseif (fit == 2) % goldsteen
       
        x1bar = 4.*xy(:,1) - 2;
        x2bar = 4.*xy(:,2) - 2;

        fact1a = (x1bar + x2bar + 1).^2;
        fact1b = 19 - 14.*x1bar + 3.*x1bar.^2 - 14.*x2bar + 6.*x1bar.*x2bar + 3.*x2bar.^2;
        fact1 = 1 + fact1a.*fact1b;

        fact2a = (2.*x1bar - 3.*x2bar).^2;
        fact2b = 18 - 32.*x1bar + 12.*x1bar.^2 + 48.*x2bar - 36.*x1bar.*x2bar + 27.*x2bar.^2;
        fact2 = 30 + fact2a.*fact2b;

        prod = fact1.*fact2;

        F = (log(prod) - 8.693) / 2.427;
    end
   
end

