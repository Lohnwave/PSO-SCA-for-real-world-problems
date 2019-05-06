clear all
clc;



D=[4,6];
C=10;  %分群
fun_num={'Problem 1: Design of a gear train','Problem 2: parameter estimation for frequencymodulated(FM) sound waves'};
%rang=[-32,32;-100,100;-600,600;-5.12,5.12;-30,30;-500,500];
Xmin=[12,-6.4];
Xmax=[60,6.35];
%Xmin=-100;
%Xmax=100;
pop_size=10;
iter_max=[2000,3000];
max_fes=[20000,30000];
runs=30;
func_number=2;
%algorithm_Name={'SBSM_SCA','SCA','SBSM_SCA_BY','SCA_SBSM'};
algorithm_Name={'SCA','PSO_func'};
% Data1=zeros(func_number,runs,size(BSO_algorithm_Name,2));
% Data2=zeros(func_number,runs,size(BSO_algorithm_Name,2));
% %Data3=zeros(runs,D,func_number,size(BSO_algorithm_Name,2));
% Data3=zeros(runs,iter_max,size(BSO_algorithm_Name,2));
Data1=zeros(func_number,runs,size(algorithm_Name,2));
Data2=zeros(func_number,runs,size(algorithm_Name,2));
M_num=zeros(func_number,runs,size(algorithm_Name,2));
%Data3=zeros(runs,iter_max,size(algorithm_Name,2));
t=zeros(func_number,runs,size(algorithm_Name,2));
f_mean=zeros(func_number,size(algorithm_Name,2));
t_mean=zeros(func_number,size(algorithm_Name,2));
E_mean=zeros(func_number,size(algorithm_Name,2));

for k=1:size(algorithm_Name,2)
    fprintf('Algorithm =\t %d %s\n',k,algorithm_Name{k});
    for i=1:func_number
        fprintf('Problem =\t %s\n',fun_num{i});
        for j=1:runs
            fprintf('run =\t %d\n',j);
            BSOFUNC=algorithm_Name{k};
            tic;
            [Error,gbest,gbestval,allgbestval,fitcount]=feval(BSOFUNC,iter_max(i),max_fes(i),pop_size,D(i),Xmin(i),Xmax(i),i);
%             function[Error,gbest,gbestval,allgbestval,fitcount,S] = SBSM_SCA(fhd,max_iteration,max_FES,n_p,n_d,n_c,rang_l,rang_r,varargin)
           t(i,j,k)=toc;%计时
           Data1(i,j,k)=Error; 
           Data2(i,j,k)=gbestval;
           %Data3(j,:,i,k)=allgbestval;
        end
        f_mean(i,k)=mean(Data2(i,:,k),2);
        t_mean(i,k)=mean(t(i,:,k),2);
        E_mean(i,k)=mean(Data1(i,:,k),2);
    end
end


fprintf('run i end=\t %d\n',i);
file_name= [ '01real_world','_30runs.mat'];
save (file_name);
 
     
  









