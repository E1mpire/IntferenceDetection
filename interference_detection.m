fRF=[16000,16300,16600,17000];
fHLO=[12175,12475,12775,13175];
fLLO=3650;
fHIF=3825;
fLIF=175;
B=10;
cnt=4;
%%
%谐波干扰
for i=1:cnt
    for k=1:5  %本振谐波5阶以后较小
        if(RangeDetect(k*fLLO,16000,17000))  %其实上面RF的频率范围是16000~17000
            disp(["阵面",num2str(i),"出现谐波干扰"])
        end
    end

end

%%
%交调干扰
for i=1:cnt
    for m=1:4  %交调干扰一般不超过4阶
        for n=1:4
            fHma=m*fHLO(i)+n*(fHIF+B/2);
            fLma=m*fHLO(i)+n*(fHIF-B/2);
            if(RangeDetect(fHma,16000,17000)||RangeDetect(fLma,16000,17000))
                if(m~=1||n~=1)
                disp(['阵面',num2str(i),'出现',num2str(m),',',num2str(n),'交调干扰'])
                disp(['干扰频率范围:(',num2str(fLma),',',num2str(fHma),')'])
                end
            end
        end
    end
end

%%
%镜频
for i=1:cnt
    for m=1:4
        for n=1:4
            fIM1=abs(m*(fHIF+B/2)+n*fHLO(i));
            fIM2=abs(m*(fHIF-B/2)+n*fHLO(i));
            fIM3=abs(m*(fHIF-B/2)-n*fHLO(i));
            fIM4=abs(m*(fHIF+B/2)-n*fHLO(i));
            fHIM=max([fIM1,fIM2,fIM3,fIM4]);
            fLIM=min([fIM1,fIM2,fIM3,fIM4]);
            if(RangeDetect(fHIM,16000,17000)||RangeDetect(fLIM,16000,17000))
                if(m~=1||n~=1)
                 disp(['阵面',num2str(i),'出现',num2str(m),',',num2str(n),'镜像干扰'])
                end
            end
        end
    end


end

function statue = RangeDetect(num,a,b)
if(num>=a&&num<=b)
    statue = true;
else
    statue = false;
end

end
