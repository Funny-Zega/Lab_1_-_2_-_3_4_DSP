// 1. Generate a test audio file (440Hz tone for 1 second)
fs = 8000;
t = 0:1/fs:1; 
x_gen = 0.8 * sin(2 * %pi * 440 * t); 
wavwrite(x_gen, fs, "D:\HK252\DSP\Lab_DSP\Lab4\test_audio.wav"); // Save to current working directory

// --- MAIN DEMO: AUDIO PROCESSING ---

// 2. Read the audio file into a matrix
[y, fs_read, bits] = wavread("D:\HK252\DSP\Lab_DSP\Lab4\test_audio.wav");

// 3. Mathematical Operation (DSP): Reduce amplitude (volume) by 50%
y_processed = y * 0.5;

// 4. Save and Play the processed audio
wavwrite(y_processed, fs_read, "D:\HK252\DSP\Lab_DSP\Lab4\processed_audio.wav");
playsnd(y_processed, fs_read);

// 5. Visualize the waveform (plotting the first 100 samples)
figure(1);
plot(y(1:100), 'b'); // Plot original in Blue
plot(y_processed(1:100), 'r'); // Plot processed in Red
title("Audio Waveform: Original (Blue) vs Processed (Red)");
xlabel("Sample [n]");
ylabel("Amplitude");
