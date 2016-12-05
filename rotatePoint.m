function [newX, newY] = rotatePoint(x, y, angle)

hypo = sqrt(x.^2 + y.^2);

newAngle = angle + asin(y ./ hypo);

newX = cos(newAngle) .* hypo;
newY = sin(newAngle) .* hypo;

end