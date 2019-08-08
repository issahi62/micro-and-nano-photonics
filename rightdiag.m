function M=rightdiag(v);

[a,b]=size(v);
if a>b
    v=v.';
end
M=v(ones(1,length(v)),:);