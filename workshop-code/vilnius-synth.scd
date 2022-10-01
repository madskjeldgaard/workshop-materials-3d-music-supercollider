(

SynthDef(\vilniussynth, {
	arg freq = 100, amp = 0.25, cutoff = 2550, pan=(1), gate = 1, dur=1, attack=0.01, release=0.99;

	var sig = Saw.ar(freq);
	var env = Env.perc(attack, release);

	// Make an envelope signal
	var done = 2;
	env = env.kr(done, gate, dur);

	// Scale the volume of the signal using an envelope
	sig = sig * env;

	sig = LPF.ar(sig, cutoff);

	// Set the volume of the synth
	sig = sig * amp;

	// Stereo pan
	sig = Pan2.ar(sig, pan);

	Out.ar(0, sig);
}).add

)