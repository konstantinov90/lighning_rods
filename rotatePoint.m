function [newX, newY] = rotatePoint(x, y, angle)

vector = (x + y*1i) * exp(1i * angle);

newX = real(vector);
newY = imag(vector);

end