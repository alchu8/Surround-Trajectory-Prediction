function vec_s = reparameterize(vec_t, L)
% takes a vector F parameterized in t, with dimension 2 x T
% returns the vector reparameterized in s, with dimension 1 x 2L
    x = vec_t(1, :);
    y = vec_t(2, :);
    x_t = derivative(x);
    y_t = derivative(y);
    s = cumtrapz( sqrt(x_t.^2 + y_t.^2 ) ); % cumulutive distance tranveled along the arc
    t = 1:1:length(x);
    X = s.';
    V = [ t.', x.', y.' ];
    S = s(end); % S is total arc length
    s0 = s(1);
    Xq = linspace(s0, S, L); % L equally spaced indices between s0 and S
    Vq = interp1(X,V,Xq); % interpolate for t(s) and x(t(s)) and y(t(s))
    x_s = Vq(:,2)'; % Euclidean distances between consecutive points are equal
    y_s = Vq(:,3)';
    temp = [x_s; y_s]; % reparameterized vector in terms of arc length s
    vec_s = temp(:)'; % 1 x 2L
end