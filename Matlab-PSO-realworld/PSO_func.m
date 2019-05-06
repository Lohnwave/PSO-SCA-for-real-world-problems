function [Error,gbest,gbestval,allgbestval,fitcount]= PSO_func(Max_Gen,max_FES,Particle_Number,Dimension,VRmin,VRmax,func_num)
%function[Error,gbestval,allgbestval,fitcount] = CLPSO_new_func(Max_Gen,Max_FES,Particle_Number,Dimension,n_c,VRmin,VRmax,func_num)
%[gbest,gbestval,fitcount]= PSO_func('f8',3500,200000,30,30,-5.12,5.12)
rand('state',sum(100*clock));
load fbias_data;%%%
allgbestval=zeros(1,Max_Gen);%%%
me=Max_Gen;
ps=Particle_Number;
D=Dimension;
cc=[2 2];   %acceleration constants
iwt=0.9-(1:me).*(0.5./me);
% iwt=0.5.*ones(1,me);
if length(VRmin)==1
    VRmin=repmat(VRmin,1,D);
    VRmax=repmat(VRmax,1,D);
end
mv=0.5*(VRmax-VRmin);
VRmin=repmat(VRmin,ps,1);
VRmax=repmat(VRmax,ps,1);
Vmin=repmat(-mv,ps,1);
Vmax=-Vmin;
pos=VRmin+(VRmax-VRmin).*rand(ps,D);

%e=feval(fhd,pos',varargin{:});
e=real_world(pos,func_num)';%test real world problems

fitcount=ps;
vel=Vmin+2.*Vmax.*rand(ps,D);%initialize the velocity of the particles
pbest=pos;
pbestval=e; %initialize the pbest and the pbest's fitness value
[gbestval,gbestid]=min(pbestval);
gbest=pbest(gbestid,:);%initialize the gbest and the gbest's fitness value
gbestrep=repmat(gbest,ps,1);
allgbestval(1)=gbestval; %%%

for i=2:me
%       v=c1*r*(pbest-pos)+c2r*(gebst-pos);
        aa=cc(1).*rand(ps,D).*(pbest-pos)+cc(2).*rand(ps,D).*(gbestrep-pos);
        vel=iwt(i).*vel+aa;
        vel=(vel>Vmax).*Vmax+(vel<=Vmax).*vel;
        vel=(vel<Vmin).*Vmin+(vel>=Vmin).*vel;
        pos=pos+vel;
        pos=((pos>=VRmin)&(pos<=VRmax)).*pos...
            +(pos<VRmin).*(VRmin+0.25.*(VRmax-VRmin).*rand(ps,D))+(pos>VRmax).*(VRmax-0.25.*(VRmax-VRmin).*rand(ps,D));
        %e=feval(fhd,pos',varargin{:});
        e=real_world(pos,func_num)';%test real world problems
        fitcount=fitcount+ps;
        tmp=(pbestval<e);
        temp=repmat(tmp',1,D);
        pbest=temp.*pbest+(1-temp).*pos;
        pbestval=tmp.*pbestval+(1-tmp).*e;%update the pbest
        [gbestval,tmp]=min(pbestval);
        allgbestval(i)=gbestval;
        gbest=pbest(tmp,:);
        gbestrep=repmat(gbest,ps,1);%update the gbest
end
gbestval;
gbest;
allgbestval;
fitcount;
Error=gbestval-f_bias(func_num);
end


