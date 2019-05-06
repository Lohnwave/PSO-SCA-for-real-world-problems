function [ ObjVal ] = real_world( Chrom,switch1 )
%Chrom=pop;switch1=fun_num
%real world problems
%problem 1: Design of a gear train
%problem 2: parameter estimation for frequencymodulated(FM) sound waves

if switch1==1 
    % Design of a gear train
    %Nind=pop_size;
    %Nvar=Dim
    [Nind,Nvar] = size(Chrom);
    Mat1 = Chrom(:,1);
    Mat2 = Chrom(:,2);
    Mat3 = Chrom(:,3);
    Mat4 = Chrom(:,4);
    Taget = repmat(1/6.931,Nind,1);
    ObjVal = (Taget-(Mat1.*Mat2)./(Mat3.*Mat4)).^2;
elseif switch1==2 %sphere 0
    [Nind,Nvar] = size(Chrom);
    t = 0:2*pi/100:2*pi;
    a1 = repmat(Chrom(:,1),1,size(t,2));
    w1 = repmat(Chrom(:,2),1,size(t,2));
    a2 = repmat(Chrom(:,3),1,size(t,2));
    w2 = repmat(Chrom(:,4),1,size(t,2));
    a3 = repmat(Chrom(:,5),1,size(t,2));
    w3 = repmat(Chrom(:,6),1,size(t,2));
%     a1 = ones(1,size(t))*Chrom(:,1);
%     w1 = ones(1,size(t))*Chrom(:,2);
%     a2 = ones(1,size(t))*Chrom(:,3);
%     w2 = ones(1,size(t))*Chrom(:,4);
%     a3 = ones(1,size(t))*Chrom(:,5);
%     w3 = ones(1,size(t))*Chrom(:,6);
    T = repmat(t,Nind,1);
    y = a1.*sin(w1.*T+a2.*sin(w2.*T+a3.*sin(w3.*T)));
    y0 = sin(5.*T-1.5.*sin(4.8.*T+2.*sin(4.9.*T)));
    
    ObjVal=sum((y-y0).^2,2);
    
end

end

