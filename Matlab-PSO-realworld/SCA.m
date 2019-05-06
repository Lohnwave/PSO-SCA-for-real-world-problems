%function [Error,gbest,gbestval,allgbestval,fitcount,S,mutation_num]=SCA(Max_iteration,Max_FES,N,dim,C,lb,ub,func_num)
% function[Error,gbest,gbestval,allgbestval,fitcount,S,mutation_num] = SBSM_SCA_BY(max_iteration,max_FES,n_p,n_d,n_c,rang_l,rang_r,func_num)
function[Error,gbest,gbestval,allgbestval,fitcount] = SCA(Max_iteration,Max_FES,N,dim,lb,ub,func_num)    
Error=0;
mutation_num=0;
allgbestval=zeros(1,Max_iteration);%%%
load fbias_data;%%%
%Initialize the set of random solutions
Boundary_no= size(ub,2); % numnber of boundaries
% If the boundaries of all variables are equal and user enter a signle
% number for both ub and lb
if Boundary_no==1
    X=rand(N,dim).*(ub-lb)+lb;
end
% If each variable has a different lb and ub
if Boundary_no>1
    for i=1:dim
        ub_i=ub(i);
        lb_i=lb(i);
        X(:,i)=rand(N,1).*(ub_i-lb_i)+lb_i;
    end
end

Destination_position=zeros(1,dim);
Destination_fitness=inf;

% Convergence_curve=zeros(1,Max_iteration);
Objective_values = zeros(1,size(X,1));
fitcount=0;

% Calculate the fitness of the first set and find the best one
for i=1:size(X,1)
    Objective_values(1,i)=real_world(X(i,:),func_num);%test real world problems
    fitcount=fitcount+1;
    if i==1
        Destination_position=X(i,:);
        Destination_fitness=Objective_values(1,i);
    elseif Objective_values(1,i)<Destination_fitness
        Destination_position=X(i,:);
        Destination_fitness=Objective_values(1,i);
    end
    
    All_objective_values(1,i)=Objective_values(1,i);
end
allgbestval(1,1)=Destination_fitness;
%Diversity analysis
S=zeros(Max_iteration,1);
x_d_avr=repmat(sum(X,1)/N,N,1);
temp=(X-x_d_avr).^2;
temp=sqrt(sum(temp,2))';
S(1)=sum(temp)/N;
%Main loop
t=2; % start from the second iteration since the first iteration was dedicated to calculating the fitness
while t<=Max_iteration && fitcount<=Max_FES
    
    % Eq. (3.4)
    a = 2;

    r1=a-t*((a)/Max_iteration); % r1 decreases linearly from a to 0
    
    % Update the position of solutions with respect to destination
    for i=1:size(X,1) % in i-th solution
        for j=1:size(X,2) % in j-th dimension
            
            % Update r2, r3, and r4 for Eq. (3.3)
            r2=(2*pi)*rand();
            r3=2*rand;
            r4=rand();
            
            % Eq. (3.3)
            if r4<0.5
                % Eq. (3.1)
                X(i,j)= X(i,j)+(r1*sin(r2)*abs(r3*Destination_position(j)-X(i,j)));
            else
                % Eq. (3.2)
                X(i,j)= X(i,j)+(r1*cos(r2)*abs(r3*Destination_position(j)-X(i,j)));
            end
            
        end
                 
    end
    
    for i=1:size(X,1)
         
        % Check if solutions go outside the search spaceand bring them back
        Flag4ub=X(i,:)>ub;
        Flag4lb=X(i,:)<lb;
        X(i,:)=(X(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
        
        % Calculate the objective values
        Objective_values(1,i)=real_world(X(i,:),func_num);%test real world problems
        fitcount=fitcount+1;
        % Update the destination if there is a better solution
        if Objective_values(1,i)<Destination_fitness
            Destination_position=X(i,:);
            Destination_fitness=Objective_values(1,i);
        end
    end
    
  
     allgbestval(1,t)=Destination_fitness;
%     if mod(t,100)==0
%        fprintf('\niteration=%d gbest=%e error=%e',t,Destination_fitness,abs(Destination_fitness-f_bias(varargin{:})));
%     end
    x_d_avr=repmat(sum(X,1)/N,N,1);
    temp=(X-x_d_avr).^2;
    temp=sqrt(sum(temp,2))';
    S(t)=sum(temp)/N;
    % Increase the iteration counter
    t=t+1;
end
allgbestval(1,Max_iteration)=Destination_fitness;
S=S';
% a=S;
% file_name= [ 'SCA_',num2str(varargin{:}),'_a.mat'];
% save (file_name,'a');
gbestval=Destination_fitness;
gbest=Destination_position;
allgbestval;
fitcount;
Error=gbestval-f_bias(func_num);
end