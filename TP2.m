clear all
close all
clc

%Q 1:

[x,fe]=audioread("C:\TPs Traitement de signal\voixAnass.ogg");

%Q 2:

%sound(x,fe)
plot(x)

%Q 3:

%sound(x,fe*2)
%sound(x,fe/2)
%sound(x,fe)



%Q 4:

stem(x)


%Q 5:


riennesertde=x(1025:(2.05e05));
%stem(riennesertde)
%sound(riennesertde,fe)

%Q 6:

courir=x((2.239e+05):(2.642e+05));
%sound(courir,fe)

ilfaut=x((2.987e+05):(3.81e+05));
%sound(ilfaut,fe)

partirapoint=x((4e+05):(5.28e+05));
%sound(partirapoint,fe)



%Q 7:
parole=[aa ,b ,c,d];
%sound(parole,fe)



%////////////Synthèse et analyse spectrale d’une gamme de%musique\\\\\\\\\\\



%Q 1:

fe=8192;
te=1/fe;
N=5000;
t=(0:N-1)*te;
m=10*cos(2*pi*262*t);
%sound(m,fe) 


re=10*cos(2*pi*294*t);


%sound(re,fe)
mi=10*cos(2*pi*330*t);



%sound(mi,fe)
fa=10*cos(2*pi*349*t);


%sound(re,fa)
sol=10*cos(2*pi*392*t);



%sound(sol,fe)
la=10*cos(2*pi*440*t);



%sound(la,fe)
si=10*cos(2*pi*494*t);



%sound(si,fe)
mm=10*cos(2*pi*523*t);


%sound(do2,fe)
musique=[do,re,mi,fa,sol,la,si,mm];
sound(musique,fe)
 

%///////////Spectre de la gamme de musique//////////////

%Q 2:

f=(0:N-1)*(fe/N);
spectre_musique=fft(musique);
signalAnalyzer(abs(fftshift(spectre_musique)));
