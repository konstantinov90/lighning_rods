function [x, y] = twoPolesArea(pole1, pole2, poleHeight, targetHeight)

x1 = pole1.x;
y1 = pole1.y;
x2 = pole2.x;
y2 = pole2.y;
L = sqrt((x1 - x2)^2 + (y1 - y2)^2);
sinAlpha = (y2 - y1) / L;
cosAlpha = (x2 - x1) / L;
Alpha = asin(sinAlpha);
h = poleHeight;
hx = targetHeight;

[rx, h0, r0] = singlePoleArea(h, hx);
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

[x, y] = rotatePoint([0 L / 2 L L L / 2 0 0], ...
    [rx rcx rx -rx -rcx -rx rx],...
    Alpha...
);
x = x + x1;
y = y + y1;

end