function detection=detect_collision(GBM1,GBM2)
inflate=GBM1.r+GBM2.r;
distance_vector=GBM1.center_position-GBM2.center_position;
distance=(distance_vector'*distance_vector)^0.5;
detection=0;
a_sequence=[4 1 2 3];
b_sequence=[2 3 4 1];
if distance<inflate
    for ii=1:5
        d_point=GBM2.d_points(:,ii);
        in=[0 0 0 0];
        for jj=1:4
            a=GBM1.d_points(:,a_sequence(jj))-GBM1.d_points(:,jj);
            a_length=(a'*a)^0.5;
            b=GBM1.d_points(:,b_sequence(jj))-GBM1.d_points(:,jj);
            b_length=(b'*b)^0.5;
            c=d_point-GBM1.d_points(:,jj);
            c_length=(c'*c)^0.5;
            th1=a'*c/(a_length*c_length);
            th2=b'*c/(b_length*c_length);
            if th1<=1 && th1>=0 && th2<=1 && th2>=0
                in(jj)=1;
            end
        end
        if in(1)==1 && in(2)==1 && in(3)==1 && in(4)==1
            detection=1;
            disp([1 ii])
            break
        end
    end
    if detection==0
        for ii=1:5
            d_point=GBM1.d_points(:,ii);
            in=[0 0 0 0];
            for jj=1:4
                a=GBM2.d_points(:,a_sequence(jj))-GBM2.d_points(:,jj);
                a_length=(a'*a)^0.5;
                b=GBM2.d_points(:,b_sequence(jj))-GBM2.d_points(:,jj);
                b_length=(b'*b)^0.5;
                c=d_point-GBM2.d_points(:,jj);
                c_length=(c'*c)^0.5;
                th1=a'*c/(a_length*c_length);
                th2=b'*c/(b_length*c_length);
                if th1<=1 && th1>=0 && th2<=1 && th2>=0
                    in(jj)=1;
                end
            end
            if in(1)==1 && in(2)==1 && in(3)==1 && in(4)==1
                detection=1;
                disp([2 ii])
                break
            end
        end
    end
end