function z = affine_transformation(p1, p2)

z = zeros(2,3);
A = sym('a', [1 6]);

for i = 1:2
    for j = 1:3
        eqn(i,j)= A(1+(i-1)*3)*p1(1,j)+ A(2+(i-1)*3)*p1(2,j)+ A(3+(i-1)*3) == p2(i,j);
    end
end

S1 = solve([eqn(1,1),eqn(1,2),eqn(1,3)]);
S2 = solve([eqn(2,1),eqn(2,2),eqn(2,3)]);

z(1,1)= vpa(S1.a1);
z(1,2)= vpa(S1.a2);
z(1,3)= vpa(S1.a3);
z(2,1)= vpa(S2.a4);
z(2,2)= vpa(S2.a5);
z(2,3)= vpa(S2.a6);
end
