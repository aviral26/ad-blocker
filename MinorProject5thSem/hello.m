function  [A]  =  hello(X, n)
A = X;
for i = 1:n
	for j = 2:n
		if (i == j)
			A(i,j) = 1;
		end
	end
end
end


