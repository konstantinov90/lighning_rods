function color = clrMap(Alpha)

% Alpha = mod(Alpha, pi/2);

red = cos(Alpha);
green = cos(Alpha + pi*2/3);
blue = cos(Alpha + pi*4/3);

color = abs([red green blue]);

end