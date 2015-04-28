fs=44100; %Sample rate in Hz
tone_freq=1000; %Signal frequency in Hz
tone_length=2; %Length of time signal in seconds
t=[0:1/fs:tone_length]; %set discrete time values

sine=sin(2*pi*tone_freq.*t); %Produce discrete valued sine wave
square=zeros(1,length(t)); 
for x=[1:1:length(sine)] %Produce discrete valued square wave
    if sine(x)>0
        square(x)=1;
    else square(x)=-1;
    end
end
saw=zeros(1,length(t));
saw(1)=0; 
for x=[2:1:length(t)] %Produce discrete valued saw wave
    if saw(x-1)>=1
        saw(x)=0;
    else saw(x)=saw(x-1)+(1/fs)*tone_freq;
    end
end

plot(t,sine) %Plot time domain signal
axis([0 4/tone_freq -1.2 1.2]); %Only view 4 periods of time domain
title('Time domain signal');
xlabel('Time (s)');
sound(sine,fs); %Listen to the audio of the signal
y=fft(sine,length(t)); %Compute the FFT
f=fs/length(y)*(1:length(y)); %scaling frequency axis by fs
figure; 
plot(f,real(y)) %Plot frequency domain signal
axis([tone_freq*0.95 tone_freq*1.05 0 3500]) 
title('Frequency domain spectrum');
xlabel('Frequency (Hz)');