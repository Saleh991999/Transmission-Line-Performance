% function method 
clc;
clear ;
Length=input('Length of transmission line in km\n ');
if ~(Length > 80&& Length <= 240)
    disp('the line can�t be solved by medium model ');
   return;
   
end
r=input('Per km resistance in ohm\n ');
x=input(' Per km reactance in ohm (x) \n ');
y=input('Per km suspectance in Siemens (y)  \n ');
Vl=input('receiving end voltage in kv\n ');
S=input('Receiving power in MVA\n ');
Fi=input('Lagging power factor\n ');
S=S*(10^6);
Vl=Vl*(10^3);
R=r*(Length);
Y=y*Length*j ;
Z=complex(R,x*Length);
fprintf('please choose your perfered model : \n ** write 1 for T-Model\n ** write 2 for pi-Model ');
Method = input(' ');
[A,B,C,D]=bm(Method,Z,Y) ;
Vr=Vl/sqrt(3);
Ir=S/((sqrt(3)*Vl));
IR =((Ir))*complex(cos(-acos(Fi)),sin(-acos(Fi)));
VS=A*Vr+B*IR; %eq 
IS=C*Vr+D*IR;
Ps=3*real(VS*(conj(IS)));
VReg=(abs(VS)-abs(Vr))/abs(Vr)*100;
Pr=S*Fi;
EF=(Pr/Ps)*100;

    disp('load sending end voltage (Volt) = ');
    disp(abs(VS))
    disp('load sending end current (Amp)= ');
    disp(abs(IS))
    disp('Sending end power (watt) = ');
    disp(Ps)
    disp('Loses (watt) = ');
    disp(Ps-Pr)
    disp('Voltage Regulation of the line ');
    disp(VReg)
    disp('Transmission Efficiency of the line');
    disp(EF)
    
    function [a,b,c,d]=bm(M,z,y) 
   
switch M
    case 1
        a=(y/2)*z+1;
        b=z*((y/4)*z+1);
        c=y;
        d=a;
    case 2
        a=(y/2)*z+1 ;
        b=z ;
        c=y*((y/4)*z+1);
        d=a;
    otherwise
        disp('Error : please ONLY Enter 1 or 2')
          M = input(' ');
         [a,b,c,d]=bm(M,z,y) ;       
end 
end
    