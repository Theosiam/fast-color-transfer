function [m,s,k,p] = k_means_opt_lab_Image(img)
    
    
    % img: η εικόνα εισόδου πρέπει να είναι σε μορφή L*α*β*
    % m: ως έξοδος m είναι οι τιμές mean κάθε cluster για τα επίπεδα α & β
    % (η αλλιώς centroids).
    %
    % πχ:     α*    β*                    (έστω 3 clusters)
    %    m= [ 3.2  6.3] c1   κάθε γραμμή αφορά εναν ξεχωριστό cluster
    %       [ 4.1  2.1] c2   ενώ κάθε στήλη απο τις 2, τις τιμές α* & β*.
    %       [ 1.1  9.2] c3
    %
    % την ίδια μορφή ακολουθεί και η μεταβλητή s που αφορά τις τιμές
    % standard deviation για κάθε cluster.
    % k: ως έξοδος ο αριθμός των cluster (!ο αριθμός των cluster παράγεται
    % αυτόματα με τον κανόνα elbow.
    %---------------------------------------------------------------------
    
    L=img(:,:,1);
    a=img(:,:,2);
    b=img(:,:,3);
    o=size(img);
    m=o(1);
    n=o(2);
    tot=m*n;
    
    X=[a(:) b(:)];
    
    %NA TO AFAIRESW
 
    %end
    
    
    eva=evalclusters(X,'kmeans','silhouette','KList',1:3);
    k=eva.OptimalK;
    
    
    if isnan(k)
        k=1;
    end
    
    [idx,Centroids]=kmeans(X,k,'Replicates',3);
    
    m=Centroids;
    s=zeros(k,2);
    p=zeros(k,1);
    C=[];
    
    for i=1:k
        C=X(find(idx==i),:);
        s(i,:)=std(C);
        l=length(C);
        p(i)=l/tot;
        C=[];
    end
    
    
    
    
end

