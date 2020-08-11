clc;
clear ;

Length=input('Length of transmission line in km\n ');
if ~(Length > 80&& Length <= 240) 
disp('the line can’t be solved by medium model '); 
return ;
end
r=input('Per km resistance in ohm\n ');
x=input(' Per km reactance in ohm (x) \n '); 
y=input('Per km suspectance in Siemens (y) \n ');
Vl=input('receiving end voltage in kv\n ');
S=input('Receiving power in MVA\n ');
Fi=input('Lagging power factor\n ');
S=S*(10^6);
Vl=Vl*(10^3);
R=r*(Length);
Vr=Vl/sqrt(3);
Y=y*Length*j ;
Z=complex(R,x*Length);
disp( 'please choose your perfered model : '); 
disp( '** write 1 for T-Model')
disp( '** write 2 for pi-Model')
Method = input(' ');
switch Method
case 1 %T-model parameters
A=(Y/2)*Z+1; 
B=Z*((Y/4)*Z+1);
C=Y;
D=A;
case 2 % pi-model parameters
A=(Y/2)*Z+1;
B=Z ;
C=Y*((Y/4)*Z+1);
D=A;
otherwise
disp('Error :Re RUN the pr1 OR 2')

return
end
Ir=S/((sqrt(3)*Vl));
IR =((Ir))*complex(cos(-acos(Fi)),sin(-acos(Fi)));
VS=A*Vr+B*IR; %equations of cct equiv
IS=C*Vr+D*IR;
Ps=3*real(VS*(conj(IS)));
VReg=(abs(VS)-abs(Vr))/abs(VS)*100;
Pr=S*Fi;
EF=(Pr/Ps)*100; 
Qs=3*imag(VS*(conj(IS)));
if ( VReg <= 5 && EF >= 90 ) 
disp ('Efficiency and Regulation are within accepted limits') ;

else
disp ('Efficiency and Regulation are not within accepted limits');

end
%
fprintf('\n')
disp('load receiving end voltage (Volt) = ');
disp(abs(Vr))
disp('load sending end current (Amp)= ');
disp(abs(IS))
disp('Sending end power (watt) = ');
disp(Ps)
disp('Loses (watt) = ');
disp(Ps-Pr)
disp('Voltage Regulation of the line (VOLT)');
disp(VReg)
disp('Transmission Efficiency of the line');
disp(EF)