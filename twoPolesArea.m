function [x, y, color] = twoPolesArea(pole1, pole2, poleHeight, targetHeight)

x1 = pole1.x;
y1 = pole1.y;
x2 = pole2.x;
y2 = pole2.y;
L = sqrt((x1 - x2)^2 + (y1 - y2)^2);
sinAlpha = (y2 - y1) / L;
cosAlpha = (x2 - x1) / L;
Alpha = -1i * log(cosAlpha + 1i*sinAlpha);
h = poleHeight;
hx = targetHeight;

[rx, h0, r0] = singlePoleArea(h, hx);
if L < 4*h
    if L < h
        hc = h0;
    else
        hc = h0 - (0.17 + 3e-4 * h) / (L - h);
    end
    if L < 2*h
        rc = r0;
    else
        rc = r0 * (1 - 0.2 * (L - 2*h) / h );
    end

    rcx = rc * (1 - hx / hc);

    leftHalfCircle = 3*pi/2:-0.01:pi/2;
    rightHalfCircle = leftHalfCircle - pi;
    lhc = leftHalfCircle;
    rhc = rightHalfCircle;
    x = [cos(lhc)*rx [0 L/2 L] cos(rhc)*rx+L [L L/2 0]];
    y = [sin(lhc)*rx [rx rcx rx] sin(rhc)*rx [-rx -rcx -rx] ];

    [x, y] = rotatePoint(x, y, Alpha);
    x = x + x1;
    y = y + y1;
    color = clrMap(Alpha);
else
    x = [];
    y = [];
    color = [0 0 0];
end

end