%Dual Simplex method

%Max z = -2x1-x3
%st
%-x1-x2+x3<=-5 ---------->  -x1-x2+x3+s1=-5
%-x1+2x2-4x3<=-8 -----------> -x1+2x2-4x3+s2=-8
%x1,x2,x3>=0

a=[-1 -1 1 1 0;-1 2 -4 0 1]
b=[-5;-8]
A=[a b]
bv = [4 5]
cost = [-2 0 -1 0 0 0]
ZjCj = cost(bv)*A-cost
table = [ZjCj ; A]
array2table(table)
Run=true
while Run
    sol = A(:,end)
    if any(sol<0)
        [leaving_val pvt_row] = min(sol)
        for i=1:size(A,2)-1
            if A(pvt_row,i)<0
                ratio(i) = abs(ZjCj(i)/A(pvt_row,i))
            else
                ratio(i) = inf
            end
        end
        [entering_val pvt_col] = min(ratio)
        bv(pvt_row) = pvt_col
        pvt_key = A(pvt_row,pvt_col)
        A(pvt_row,:) = A(pvt_row,:)/pvt_key
        for i=1:size(A,1)
            if i~=pvt_row
                A(i,:) = A(i,:)-A(pvt_row,:)*A(i,pvt_col)
            end
        end
        ZjCj = cost(bv)*A - cost;
        new_table = [ZjCj ; A]
        array2table(new_table)
    else
        Run = false
        obj_val = ZjCj(end)
    end
end
