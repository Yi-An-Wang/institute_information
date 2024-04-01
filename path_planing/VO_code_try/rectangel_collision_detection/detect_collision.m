function detection=detect_collision(GBM1,GBM2)
inflate=GBM1.r+GBM2.r;
distance_vector=GBM1.center_position-GBM2.center_position;
distance=(distance_vector'*distance_vector)^0.5;
detection=0;
if distance<inflate
    a=GBM1.d_points(:,4)-GBM1.d_points(:,1);
    a_length=(a'*a)^0.5;
    b=GBM1.d_points(:,2)-GBM1.d_points(:,1);
    b_length=(b'*b)^0.5;
    for ii=1:5
        c=GBM2.d_points(:,ii)-GBM1.d_points(:,1);
        c_length=(c'*c)^0.5;
        c_th1=a'*c/(a_length*c_length);
        c_th2=b'*c/(b_length*c_length);
        if c_th1<=1 && c_th1>=0 && c_th2<=1 && c_th2>=0
            detection=1;
            break
        end
    end
    if detection==0
        a=GBM2.d_points(:,4)-GBM2.d_points(:,1);
        a_length=(a'*a)^0.5;
        b=GBM2.d_points(:,2)-GBM2.d_points(:,1);
        b_length=(b'*b)^0.5;
        for ii=1:5
            c=GBM1.d_points(:,ii)-GBM2.d_points(:,1);
            c_length=(c'*c)^0.5;
            c_th1=a'*c/(a_length*c_length);
            c_th2=b'*c/(b_length*c_length);
            if c_th1<=1 && c_th1>=0 && c_th2<=1 && c_th2>=0
                detection=1;
                break
            end
        end
    end
end

if distance<inflate && detection==0
    a=GBM1.d_points(:,1)-GBM1.d_points(:,2);
    a_length=(a'*a)^0.5;
    b=GBM1.d_points(:,3)-GBM1.d_points(:,2);
    b_length=(b'*b)^0.5;
    for ii=1:5
        c=GBM2.d_points(:,ii)-GBM1.d_points(:,2);
        c_length=(c'*c)^0.5;
        c_th1=a'*c/(a_length*c_length);
        c_th2=b'*c/(b_length*c_length);
        if c_th1<=1 && c_th1>=0 && c_th2<=1 && c_th2>=0
            detection=1;
            break
        end
    end
    if detection==0
        a=GBM2.d_points(:,1)-GBM2.d_points(:,2);
        a_length=(a'*a)^0.5;
        b=GBM2.d_points(:,3)-GBM2.d_points(:,2);
        b_length=(b'*b)^0.5;
        for ii=1:5
            c=GBM1.d_points(:,ii)-GBM2.d_points(:,2);
            c_length=(c'*c)^0.5;
            c_th1=a'*c/(a_length*c_length);
            c_th2=b'*c/(b_length*c_length);
            if c_th1<=1 && c_th1>=0 && c_th2<=1 && c_th2>=0
                detection=1;
                break
            end
        end
    end
end

if distance<inflate && detection==0
    a=GBM1.d_points(:,4)-GBM1.d_points(:,3);
    a_length=(a'*a)^0.5;
    b=GBM1.d_points(:,2)-GBM1.d_points(:,3);
    b_length=(b'*b)^0.5;
    for ii=1:5
        c=GBM2.d_points(:,ii)-GBM1.d_points(:,3);
        c_length=(c'*c)^0.5;
        c_th1=a'*c/(a_length*c_length);
        c_th2=b'*c/(b_length*c_length);
        if c_th1<=1 && c_th1>=0 && c_th2<=1 && c_th2>=0
            detection=1;
            break
        end
    end
    if detection==0
        a=GBM2.d_points(:,4)-GBM2.d_points(:,3);
        a_length=(a'*a)^0.5;
        b=GBM2.d_points(:,2)-GBM2.d_points(:,3);
        b_length=(b'*b)^0.5;
        for ii=1:5
            c=GBM1.d_points(:,ii)-GBM2.d_points(:,3);
            c_length=(c'*c)^0.5;
            c_th1=a'*c/(a_length*c_length);
            c_th2=b'*c/(b_length*c_length);
            if c_th1<=1 && c_th1>=0 && c_th2<=1 && c_th2>=0
                detection=1;
                break
            end
        end
    end
end

if distance<inflate && detection==0
    a=GBM1.d_points(:,1)-GBM1.d_points(:,4);
    a_length=(a'*a)^0.5;
    b=GBM1.d_points(:,3)-GBM1.d_points(:,4);
    b_length=(b'*b)^0.5;
    for ii=1:5
        c=GBM2.d_points(:,ii)-GBM1.d_points(:,4);
        c_length=(c'*c)^0.5;
        c_th1=a'*c/(a_length*c_length);
        c_th2=b'*c/(b_length*c_length);
        if c_th1<=1 && c_th1>=0 && c_th2<=1 && c_th2>=0
            detection=1;
            break
        end
    end
    if detection==0
        a=GBM2.d_points(:,1)-GBM2.d_points(:,4);
        a_length=(a'*a)^0.5;
        b=GBM2.d_points(:,3)-GBM2.d_points(:,4);
        b_length=(b'*b)^0.5;
        for ii=1:5
            c=GBM1.d_points(:,ii)-GBM2.d_points(:,4);
            c_length=(c'*c)^0.5;
            c_th1=a'*c/(a_length*c_length);
            c_th2=b'*c/(b_length*c_length);
            if c_th1<=1 && c_th1>=0 && c_th2<=1 && c_th2>=0
                detection=1;
                break
            end
        end
    end
end