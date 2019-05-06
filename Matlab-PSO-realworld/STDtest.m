STD=zeros(2,size(Data1,3));
for i=1:size(Data1,3)
   STD(:,i)=std(Data1(:,:,i),0,2); 
end

for k=1:6
    for i=1:2
        Data(:,k,i)=Data2(i,:,k);
    end
end
p1=Data(:,:,1);
p2=Data(:,:,2);
p1max=max(p1,[],1);
p1min=min(p1,[],1);
p2max=max(p2,[],1);
p2min=min(p2,[],1);

