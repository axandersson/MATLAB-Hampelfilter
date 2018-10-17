% Simple implementation of hampel-filter
% For each sample xi in x, if the difference between abs(mi - xi) > ns *
% MAD, then xi is replaced by mi, where mi is the median of a local window
% around xi, computed with the window size 2*k+1, and MAD is the median absolute
% deviation, computed with the same window around xi. ns is an integer
% specifying the number of MAD's.
% See testhampelfilter.m for example.

function x = hampelfilter(x,k,ns)
x = x(:)'; % Force row vector.
if nargin < 2
    k = 1;
    ns = 2;
elseif nargin < 3
    ns = 2;
end
kappa = 1.4826;
n = length(x);

% Append data to deal with window outside data
xf = [ x(1:k), x, x((end-k+1):end)];
for i = 1:n
   
   idx = i + k;
   xs = xf(idx);
   
   % windows of points
   win = xf((idx-k):(idx+k));
   
   % Compute median
   mi = median(win);
   
   % Compute MAD
   sigma = kappa*median(abs(mi-win));
   
   % Filter
   if abs(xs - mi) > ns*sigma
      x(i) = mi;  
   end
end
