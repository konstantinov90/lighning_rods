function [ret, h0, r0] = singlePoleArea(poleHeight, targetHeight)

h = poleHeight;

h0 = 0.85 * h;

r0 = (1.1 - 0.002 * h) * h;

rx = @(hx) r0 / h * (h - hx / 0.85);

ret = rx(targetHeight); % радиус на высоте targetHeight

end