close all
clear all
clc

input = struct(...
    'a', 50, ...
    'b', 80, ...
    'h', 35, ...
    'hx', 18 ...
);

poleOffset = 5; % расстояние от границы ПС до молниеприемника
o = poleOffset;

poles = {...
    struct('x', o, 'y', o),...
    struct('x', o, 'y', input.b - o),...
    struct('x', input.a - o, 'y', o),...
    struct('x', input.a - o, 'y', input.b - o)...
};

rx = singlePoleArea(input.h, input.hx);
x = sin(0:0.001:2*pi)*rx;
y = cos(0:0.001:2*pi)*rx;
dummyX = cellfun(@(pole) pole.x + x, poles, 'uniformoutput', false);
dummyY = cellfun(@(pole) pole.y + y, poles, 'uniformoutput', false);
polesAreasX = [];
polesAreasY = [];
for I = 1:length(poles)
    polesAreasX = [polesAreasX dummyX{I} NaN];
    polesAreasY = [polesAreasY dummyY{I} NaN];
end


subStation = struct(...
    'x', [0 0 input.a, input.a 0], ...
	'y', [0 input.b, input.b, 0 0]...
);

twoPolesAreas = struct('x', [], 'y', []);
for I = 1:length(poles)-1
    for J = I+1:length(poles)
        [x,y] = twoPolesArea(poles{I}, poles{J}, input.h, input.hx);
        twoPolesAreas.x = [twoPolesAreas.x NaN x];
        twoPolesAreas.y = [twoPolesAreas.y NaN y];
    end
end

[x,y] = twoPolesArea(poles{2}, poles{3}, input.h, input.hx);

figure
hold on 
for I = 1:length(poles)-1
    for J = I+1:length(poles)
        [x,y] = twoPolesArea(poles{I}, poles{J}, input.h, input.hx);
%         twoPolesAreas.x = [twoPolesAreas.x NaN x];
%         twoPolesAreas.y = [twoPolesAreas.y NaN y];
        fill(x, y, [1,0.4,0.6], 'facealpha',0.5);
    end
end

plot(subStation.x, subStation.y, '-b', ...
    cellfun(@(pole) pole.x, poles), cellfun(@(pole) pole.y, poles), '*b', ...
    polesAreasX, polesAreasY, 'r-' ...
);



xlim(input.a*[-0.25 1.25]);
ylim(input.b*[-0.25 1.25]);
axis('equal')