// Install the ATK Quark
Quarks.install("https://github.com/ambisonictoolkit/atk-sc3.git");

// Recompile / Restart SuperCollider
thisProcess.recompile()

// Download extra stuff
Atk.downloadKernels;
Atk.downloadMatrices;
Atk.downloadSounds;