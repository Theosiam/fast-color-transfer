function[E] = color_map_similarity(R,S)
   
    R=ceil(rgb2lab(R));
    S=ceil(rgb2lab(S));
     
    Hr=hist_2D_ab(R);
    Hs=hist_2D_ab(S);
    
    X=abs(Hr-Hs);
    E=-sum(X(:));

end