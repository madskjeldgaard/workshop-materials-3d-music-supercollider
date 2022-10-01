(
Pdef(\vilnius,
	Pbind(
		\instrument, \vilniussynth,
		\cutoff, 2500,
		\pan, Pseq([1,(-1)], inf),
		\dur, Pwrand([0.25, 0.5, Rest(0.25)], [0.5, 0.25, 0.25], inf),
		\degree, Pseq([0,1,2], inf) + Pseq([[0,2,5]],inf),
		\scale, Scale.minor,
		\root, 0,
		\octave, 5,
	)
).play;

)
