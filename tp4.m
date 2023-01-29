clear all; 
close all; 
clc


% Q 1 :

%   x(t) ------->


f1=500;
f2=400;
f3=50;
te=1e-4; 
t=0:te:4-te;

%/////////////tracage de  la function /////////////

 x=sin(2*pi*f1*t)+sin(2*pi*f2*t)+sin(2*pi*f3*t);
 subplot(2,2,1)
  plot(t,x);
% ////////////////transforme de fourier de signale x(t)///////////////
  transf=fft(x);

 N=length(x);       
 fe=1/te;
 f=(0:N-1)*fe/N;
 fshift=(-N/2:N/2-1)*fe/N ;
subplot(2,2,2)
   plot(fshift,fftshift(abs(transf)));
% Q 3:
 k=1;
 wc=50;
 wc2=100;
 wc3=150;
 w=2*pi*f;
  H=(k*1j*w/wc )./(1+1j*w/wc);
 H2=(k*1j*w/wc2)./(1+1j*w/wc2);
 H3=(k*1j*w/wc3)./(1+1j*w/wc3);

% //////////diagramme de bode//////////////

  G=20*log(abs(H));
 G2=20*log(abs(H2));
   G3=20*log(abs(H3));
  ph=angle(H);
  ph2 = angle(H2);
   ph3 = angle(H3);
    hold on 
   subplot(2,1,1) 
   grid on
      
 semilogx(f,G,'b',f,G2,'r',f,G3,'g');
  ylabel('Gain (dB)')
 xlabel('Frequency (rad/s)')
 title('Bode Diagram')
  subplot(2,1,2) 
 grid on 
  semilogx(f,ph,'b',f,ph2,'r',f,ph3,'g');
   ylabel('Phase (deg)');
    xlabel('Frequency (rad/s)');
%Q4:
%wc=50 the best one
%dans le domaine frequentielle se transform en  produit normale

 y1=transf.*H;
y2=transf.*H2;
y3=transf.*H3;
 subplot(1,3,1)
 plot(fshift,fftshift(abs(y1)))
  title(' wc= 50')
  subplot(1,3,2)
 plot(fshift,fftshift(abs(y2)))
 title(' wc= 100')
  subplot(1,3,3)
 plot(fshift,fftshift(abs(y3)))
   title(' wc= 150')
% //////////domaine tomporiel//////////////
 Y1=ifft(y1);
 Y2=ifft(y2);
 Y3=ifft(y3);
 subplot(3,1,1)
  plot(f,Y1)
  title(' wc= 50')
  subplot(3,1,2)
 plot(f,Y2)
 title(' wc=100')
  subplot(3,1,3)
       
  
 plot(f,Y3)
 
 title(' wc= 150')


[music, fs] = audioread('test.wav');
% save('testt.mat', 'y', 'fs');
%load('test.mat');
music = music';
N=length(music);
te = 1/fs;
t = (0:N-1)*te;

f = (0:N-1)*(fs/N);
fshift = (-N/2:N/2-1)*(fs/N);

y_trans = fft(music);
% subplot(3,1,1)
% plot(t,y)
% subplot(3,1,2)
 plot(fshift,fftshift(abs(y_trans)))




k = 1;
fc = 5000;
% //////transmitance complexe ///////
h =1./(1+1j*(f/fc).^100);
h_filter = [h(1:floor(N/2)), flip(h(1:floor(N/2)))];

semilogx(f(1:floor(N/2)),abs( h(1:floor(N/2))),'linewidth',1.5)

% %/////////diagramme de bode en fct de la phase ////////////////
% P = angle(h);
% P1 = angle(H1);
% P2 = angle(H2);

y_filtr = y_trans(1:end-1).*h_filter;

sig_filtred= ifft(y_filtr,"symmetric");

plot(fshift(1:end-1),fftshift(abs(fft(sig_filtred))))




