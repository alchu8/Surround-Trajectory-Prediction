function distance=MatLabLCSS(a, b, delta, epsilon, transpose)
% Time Series matching using the Longest Common Subsequence within region of delta and epsilon.
%
% distance = lcsMatching(a, b, delta, epsilon, transpose)
%
% INPUT:
% a = [m x 2] time series A
% b = [n x 2] time series B
% delta = time matching region (left & right)
% epsilon = spatial matching region (up & down)
% transpose = [optional parameter] how much to shift the time series
%             vertically, so as the matching is better visualized
%
% OUTPUT:
% The distance between A and B defined as 1 - LCSS(A,B) / min(|A|, |B|)    
%
% Original LCS script for discrete symbols by Roger Jang.
% Time Series Matching, Minimum Bounding Envelope and 
% Point Correspondense added by Michail Vlachos, 2002
%
% BEGIN COPYRIGHT NOTICE
%
%    lcsMatching code -- (c) 2002 Michalis Vlachos (http://www.cs.ucr.edu/~mvlachos)
%
%    This code is provided as is, with no guarantees except that 
%    bugs are almost surely present.  Published reports of research 
%    using this code (or a modified version) should cite the 
%    article that describes the algorithm: 
%
%      M. Vlachos, M. Hadjieleftheriou, D. Gunopulos, E. Keogh:  
%      "Indexing Multi-Dimensional Time-Series with Support for Multiple Distance Measures",
%      In Proc. of 9th SIGKDD, Washington, DC, 2003
%      
%    Comments and bug reports are welcome.  Email to mvlachos@cs.ucr.edu 
%    I would also appreciate hearing about how you used this code, 
%    improvements that you have made to it.
%
%    You are free to modify, extend or distribute this code, as long 
%    as this copyright notice is included whole and unchanged.  
%
%    END COPYRIGHT NOTICE


% some checks
setTranspose = 1;
if nargin == 0, demo; return; end
if nargin < 4 ,
    disp('distance = lcsMatching(a, b, delta, epsilon, transpose)');
end
if nargin < 5,
    setTranspose = 0;
end


m = size(a,1);
n = size(b,1);

% put the shorter first
if n<m,
    temp = a;
    a = b;
    b = temp;
    m = size(a,1);
    n = size(b,1);
end

lcstable = zeros(m+1, n+1);
prevx = zeros(m+1, n+1);
prevy = zeros(m+1, n+1);
% Find LCS using dynamic programming
for i=1:m,
   for j = (i-delta):1:(i+delta),
      
      if (j>0 && j<n)
      
        if ( norm(a(i,:) - b(j,:)) <= epsilon)
            lcstable(i+1,j+1) = lcstable(i,j)+1;
            prevx(i+1,j+1) = i;
            prevy(i+1,j+1) = j;
        elseif (lcstable(i,j+1) > lcstable(i+1,j))
            lcstable(i+1,j+1) = lcstable(i,j+1);
            prevx(i+1,j+1) = i;
            prevy(i+1,j+1) = j+1;
        else
            lcstable(i+1,j+1) = lcstable(i+1,j);
            prevx(i+1,j+1) = i+1;
            prevy(i+1,j+1) = j;
        end 
      end
   end
end

% Get rid of initial conditions
lcstable = lcstable(2:end, 2:end);
disp(lcstable);
disp(max(lcstable(m, :)));
prevx = prevx(2:end, 2:end)-1;
prevy = prevy(2:end, 2:end)-1;

% ====== LCS distance 
[lcs, pos]= max(lcstable(m, :));
distance = 1 - lcs / (min(m,n));
disp(distance);

% ====== Optimal path of the dynamical programming

now = [m, pos];
prev = [prevx(now(1), now(2)), prevy(now(1), now(2))];
lcs_path = now;
while all(prev>0),
    now = prev;
    prev = [prevx(now(1), now(2)), prevy(now(1), now(2))];
    lcs_path = [lcs_path; now];
end 
lcs_path = flipud(lcs_path);


% matching points
temp = lcstable((lcs_path(:,2)-1)*m+lcs_path(:,1)); % LCS count along the path
temp = [0; temp];
index = find(diff(temp));
match_point = lcs_path(index, :);
