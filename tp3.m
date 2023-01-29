clear all
close all
clc


%% //////////////Suppression du bruit provoqu� par les mouvements //////////////
figure;
%Q 1:
load("ecg.mat");
x=ecg;

%Q 2:
fs=500;
N = length(x);
ts=1/fs;
t=(0:N-1)*ts;
subplot(1,3,1)
plot(t,x);
title("le signal ECG ");
%  zoom sur une p�riode  %xlim([0.5 1.5])


%Q 3:
y = fft(x); 
f2 = (-N/2:N/2-1)*(fs/N);
f =(0:N-1)*(fs/N);
subplot(1,3,2)
%spectre Amplitude centr�
plot(f2,fftshift(abs(y)))
title("spectre Amplitude du signal ECG")

%filtre passe-haut
filtre_haut = ones(size(x));
fc = 0.5;
index_h = ceil(fc*N/fs);
filtre_haut(1:index_h)=0;
%  sym�trie conjugu�



filtre_haut(N-index_h+1:N)=0;
%Application du filtrage
filtre=filtre_haut.*y;



ecg1=ifft(filtre,"symmetric");

%Q 4:


subplot(1,3,3)
plot(t,ecg1);
title("signal filtre ecg1")


 %% ///////// Suppression des interf�rences des lignes �lectriques 50Hz////////////
 
 % transformme de fourier de  signal filtr�e
%  subplot(2,3,4)
%  plot(f2,fftshift(abs(fft(ecg1))))
%  title("TF de ecg1")




%Q 5:
figure;
%  Notch filters est faite pour annuler une frequense exact
notch_filter = ones(size(x));
fc2 = 50;
index_h2 = ceil((fc2*N)/fs)+1; 
notch_filter(index_h2)= 0;
%  sym�trie conjugu�
notch_filter(N-index_h2+2)= 0;

filtre2=notch_filter.*filtre;

%Q 6:

ecg2=ifft(filtre2,"symmetric");
subplot(1,3,1)
plot(f2,fftshift(abs(filtre2)));
title("Spectre de ECG2")
subplot(1,3,2)
plot(t,ecg2);

title("Signal  ECG2")

% subplot(211)
% plot(t,x)
% xlim([0.5 1.5])
% subplot(212)
% plot(t,ecg2)
% xlim([0.5 1.5])


%%//////////////////v Am�lioration du rapport signal sur%%bruit///////////////////////////



%Q 7:

%Filtrage pass-bas
figure;
filtre_bas = zeros(size(x));
%On change a chaque fois la fr�quence est on essaye d'approxim� le r�sultat
%a la represenatation du signal ecg sans bruit qui est represente dans%l'introduction
fc37 = 37;
index_h3 = ceil(fc37*N/fs);
filtre_bas(1:index_h3)=1;
%  sym�trie conjugu�
filtre_bas(N-index_h3+1:N)=1;
ecg3_freq =  filtre_bas.*fft(ecg2);
ecg3 = ifft(ecg3_freq,"symmetric");

%Apr�s plusieur teste on a trouver que frequence 37  esl la plus proche a
%avoir un minumum de bruit

 % Q 8:
 
 
subplot(1,3,1)
plot(t,x)
xlim([0.5 1.5])
title('signal de depart ecg')
subplot(1,3,2)
plot(t,ecg3)
xlim([0.5 1.5])
title('signal ecg3')

%% ////////////Identification de la fr�quence cardiaque avec la fonction d�autocorr�lation///////////////

%Q 9:
figure;
[acf,lags] = xcorr(ecg3,ecg3);
stem(lags/fs,acf)

