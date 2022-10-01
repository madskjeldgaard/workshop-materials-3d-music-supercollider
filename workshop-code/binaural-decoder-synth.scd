(
fork{
    // Load resources
    Server.local.sync;
    ~binauralDecoder = FoaDecoderKernel.newCIPIC(subjectID: 21);

    // Make decoder synthdef
    Server.local.sync;
    SynthDef(\binauralDecoder, {|out=0, bypass=0|
        var order = 1;
        var clean = In.ar(out, order.asHoaOrder.size);
        var hoa = In.ar(out, order.asHoaOrder.size);

        // format exchange: HOA >> FOA
        var lowCutFreq = 30.0;  // highpass freq

        // design encoder to exchange (ordering, normalisation)
        var encoder = FoaEncoderMatrix.newHoa1;
        var foa, stereo, sig;

        // exchange (ordering, normalisation)
        // truncate to HOA1
        foa = FoaEncode.ar(hoa.keep(AtkFoa.defaultOrder.asHoaOrder.size), encoder);

        // pre-condition FOA to make it work with FoaProximity
        foa = HPF.ar(foa, lowCutFreq);

        // Exchange reference radius
        foa = FoaProximity.ar(foa, AtkHoa.refRadius);

        // Decode to binaural
        stereo = FoaDecode.ar(in: foa,  decoder: ~binauralDecoder);

        // Pad output with silence after the stereo channels
        stereo = stereo ++ Silent.ar().dup(order.asHoaOrder.size-2);

        // Allow to bypass
        sig = Select.ar(which: bypass,  array: [stereo, clean]);

        ReplaceOut.ar(bus: out,  channelsArray: sig);
    }).add;
}
)