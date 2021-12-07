%% Programing Assignment 2

%%
% *Joint 1 can spin the full 360 wihtout hitting itself. This command takes
% user input. Can be extended if robot needs to maek multiple turns.*
theta1 = input('Please enter joint 1''s rotation in degrees (-360 to 360): ');

% Checks if the value entered is out of the range.
if theta1>360 || theta1<-360
    theta1 = input('\nOut of bounds!!! Please enter joint 1''s rotation in degrees (-360 to 360): ');
end

%%
%%
% *Joint 2 cannot spin fully because it will collide with itself. Since thickness is unknown it will just stop at its absolute limit assuming zero thickness.*
theta2 = input('Enter the rotation for joint 2 in degrees (-180 to 180): ');
%%
% Checks if the value entered is out of the range.
if theta2>180 || theta2<-180
    theta2 = input('\nOut of bounds!!! Please enter joint 2''s rotation in degrees (-180 to 180): ');
end

%%
%%
% *Extension depends on length of rod.*
d3 = input('Enter the value for the prismatic joint to extend (0 to 2): ');

% Checks if the value entered is out of the range.
if d3>2 || d3<0
    d3 = input('\nOut of bounds!!! Enter postive value not greater than 2: ');
end

%%
%%
% *Lengths of the arms.*
d1 = 1; %length of arm piece one
a1 = 1; %length of arm piece two
a2 = 1; %length of arm piece three

%%
%%
% *Creates even steps for plotting.*
a = linspace(0,theta1,50); %creates even steps up to the first entered angle for plotting
b = linspace(0,theta2,50); %creates even steps up to the second entered angle for plotting
c = linspace(0,d3,50); %creates even steps up to the prismatic length enetered for plotting

%%
%%
% *For Loop allows for iterations. This mimics movement.*
for i= 1:length(a)

    link1 = bigmatrix(0,0,0,a(i)); %uses the function I created to calculate the DH big matrix for each link
    link2 = bigmatrix(a1,0,d1,b(i));
    link3 = bigmatrix(a2,0,c(i),0);

    joint1 = link1*link2; %calcultes the end position of the arm extending from the second joint

    eff = link1*link2*link3; %location of end efffector
    
    y = plot3([0 link1(1,4)], [0 link1(1,4)], [0 d1],'r'... %arm 1 plot
        ,[link1(1,4) joint1(1,4)], [link1(2,4) joint1(2,4)], [d1 d1],'g'... %arm 2 plot
        ,[joint1(1,4) eff(1,4)], [joint1(2,4) eff(2,4)], [d1 d1],'b'... %arm 3 plot
        ,[eff(1,4) eff(1,4)], [eff(2,4) eff(2,4)],[1 eff(3,4)]... %arm 4 plot
        ,eff(1,4),eff(2,4),eff(3,4),'o');
    xlabel('x');
    ylabel('y');
    zlabel('z');
    axis([-2 2 -2 2 0 d3+1.5])
    
datacursormode on
datatip(y(4),eff(1,4),eff(2,4),eff(3,4)); %plots eff point

F(i) = getframe(gcf); %records video

pause(0.05) %pauses loop

end

%%
%%
% *Display EFF Matrix
disp(eff)
%%
% *Records Video and saves it to a file.*
newVid = VideoWriter('Programming 2 Movie.mp4', 'MPEG-4'); 
open(newVid);
writeVideo(newVid,F);
close(newVid);