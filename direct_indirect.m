clc;
clear all;
close all;

% Number of Nodes
numNodes=75;
% Maximum range of nodes
range=250;
%Location of sensor nodes initialization
nodePositions= zeros(numNodes,3);

%Distance from node to sink
node_to_sink= zeros(numNodes,1);

% Node status
voids= zeros(numNodes,1);
% Keep track of no. of neighbour
no_of_neighbour= zeros(numNodes,1)
% Keep track of Direct void nodes
DV=zeros(numNodes,1)
% keep track of neighbours of each node
neighbour=zeros(numNodes,numNodes);
% find distance between neighbours of each node to sink
neighbour_sink=zeros(numNodes,numNodes);



% Monitoring field area in 3-D
max_x=1000;
max_y=1000;
max_z=1000;

% Sink location in 3D
sink_x=(max_x/2);
sink_y= (max_y/2);
sink_z=0;

% Randomly deploy nodes
for i=1:numNodes
    nodePositions(i,1) = rand * max_x;
    nodePositions(i,2) = rand * max_y; 
    nodePositions(i,3) = rand * max_z;
end


% Finds the distance between node to sink
for i=1:numNodes
    distance= sqrt((nodePositions(i,1)-sink_x)^2 + ...
    (nodePositions(i,1)-sink_x)^2 + (nodePositions(i,1)-sink_x)^2);
    node_to_sink(i,1)= distance;
end

%Find neighbour of all nodes
for i =1: numNodes
    index=1;
    for j= 1:numNodes
        if ( i==j)
            continue;
        end
        node_other(i,j)= sqrt((nodePositions(i,1)-nodePositions(j,1))^2 + ...
        (nodePositions(i,2)-nodePositions(j,2))^2 + (nodePositions(i,3)-nodePositions(j,3))^2);
        if(node_other(i,j) <= range)
            neighbour(i,index)= j;
            index = index + 1;
        end
        
    end
    no_of_neighbour(i,1)=sum(neighbour(i,:)~= 0)
    
end
    
% find neighbour with minimum distance for all  nodes
for i=1:numNodes
    for k=1:no_of_neighbour(i)
        neighbour_sink(i,k)=sqrt((nodePositions(neighbour(i,k),1)-sink_x)^2 + ...
        (nodePositions(neighbour(i,k),2)-sink_y)^2 + (nodePositions(neighbour(i,k),3)-sink_z)^2);
    end
    neighbour_sink(neighbour_sink ==0) = 9999;
    [M, I] =min(neighbour_sink(i,:));
     min_neighbour_sink= M;
     
     % store the neighbouring node with min. distance to sink
     node_to_sink(i,2)=min_neighbour_sink;
     if ( (node_to_sink(i,2) > node_to_sink(i,1)) && (node_to_sink(i,1) > range))
         DV(i)= 1;
     end
end

  %%%%% logic to find indirect void nodes%%%%%%%%%%%%%%%%





     
neighbour=zeros(numNodes,numNodes);
neighbour_sink=zeros(numNodes,numNodes);

 
 
 
% Find neighbouring nodes for all nodes
for i =1: numNodes
    for j= 1:numNodes
        if ( i==j)
            continue;
        end
        node_other(i,j)= sqrt((nodePositions(i,1)-nodePositions(j,1))^2 + ...
        (nodePositions(i,2)-nodePositions(j,2))^2 + (nodePositions(i,3)-nodePositions(j,3))^2);
        if(node_other(i,j) <= range)
            neighbour(i,index)= j;
            index = index + 1;
        end
    
    end
  sender=i;
  delivered=0;
  void=0;
    
 while ( delivered==0 && void==0)
   index=1;
     
     if ( node_to_sink(i,1) <= range)
        voids(sender,1)=0;
        delivered =1;
        break;
    end
        
    for j= 1:numNodes
        if ( i==j)
            continue;
        end
        node_other(i,j)= sqrt((nodePositions(i,1)-nodePositions(j,1))^2 + ...
        (nodePositions(i,2)-nodePositions(j,2))^2 + (nodePositions(i,3)-nodePositions(j,3))^2);
        if(node_other(i,j) <= range)
            neighbour(i,index)= j;
            index = index + 1;
        end
    end
    index=1;
    no_of_neighbour(i,1)=sum(neighbour(i,:)~= 0)
    
    
    % Find the distance between neighbour node to sink
    for k=1:no_of_neighbour(i)
        neighbour_sink(i,k)=sqrt((nodePositions(neighbour(i,k),1)-sink_x)^2 + ...
        (nodePositions(neighbour(i,k),2)-sink_y)^2 + (nodePositions(neighbour(i,k),3)-sink_z)^2);
    end
    neighbour_sink(neighbour_sink ==0) = 9999;
    [M, I] =min(neighbour_sink(i,:));
     min_neighbour_sink= M;
     node_to_sink(i,2)=min_neighbour_sink;
     if ( node_to_sink(i,2) > node_to_sink(i,1))
         voids(sender,1)=1;
         delivered=0;
         void=1;
     end
     
     next_hop= neighbour(i,I);
     i=next_hop;
  end
    
end

   
    
  % while (delivery == 0 && void==0 )
       
     
     
    




