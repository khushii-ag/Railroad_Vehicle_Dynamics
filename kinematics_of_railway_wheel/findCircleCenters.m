function [center1X, center1Y, center2X, center2Y] = findCircleCenters(x1, y1, x2, y2, r)
    % This function finds the two possible centers of a circle given two points on the circle and the radius.

    % Calculate the distance between the two points
    d = sqrt((x2 - x1)^2 + (y2 - y1)^2);

    % Check if the given radius is valid for the given distance
    if r < d / 2
        error('The radius is too small to form a circle with the given points.');
    end

    % Calculate the midpoint of the line segment
    xm = (x1 + x2) / 2;
    ym = (y1 + y2) / 2;

    % Calculate the distance from the midpoint to the circle center
    h_distance = sqrt(r^2 - (d / 2)^2);

    % Find the direction vector perpendicular to the line segment
    dx = x2 - x1;
    dy = y2 - y1;

    % Perpendicular vector components
    perp_dx = -dy;
    perp_dy = dx;

    % Normalize the perpendicular vector
    norm = sqrt(perp_dx^2 + perp_dy^2);
    perp_dx = perp_dx / norm;
    perp_dy = perp_dy / norm;

    % Possible centers of the circle
    center1X = xm + h_distance * perp_dx;
    center1Y = ym + h_distance * perp_dy;

    center2X = xm - h_distance * perp_dx;
    center2Y = ym - h_distance * perp_dy;
end
