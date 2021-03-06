(SynthDef.new(\viola,
{|vib=6, echo=0, rate=1, delay=0, sus=1, limit=1, bits=24, hpf=0, pan=0, scrub=0, verb=0.33, amp=1, freq=0, buf=0, echoOn=0, room=0.3, chop=0, slide=0, grain=0, fmod=0, lpf=20000, slidefrom=1|
var osc, env;
amp = amp / 2;
freq = freq + fmod;
freq = Line.ar(freq * slidefrom, freq * (1 + slide), sus);
freq = Vibrato.kr(freq, rate: vib);
osc=PMOsc.ar(freq, Vibrato.kr(freq, delay: (sus * 0.25), rate: vib, depth: 0.008), 10, mul: (amp / 2));
env=EnvGen.ar(Env.perc(level: amp,curve: 0,attackTime: (0.25 * sus),releaseTime: (0.75 * sus)), doneAction: 2);
osc=HPF.ar(osc, hpf);
osc=LPF.ar(osc, (lpf + 1));
osc=(osc * LFPulse.ar((chop / sus)));
osc=(osc + (CombL.ar(osc, delaytime: echo, maxdelaytime: 2) * echoOn));
osc=Decimator.ar(osc, rate: 44100, bits: bits);

osc = osc * env;
osc = Limiter.ar(osc, level: limit);
osc = Pan2.ar(FreeVerb.ar(osc, verb, room), pan);
	Out.ar(0, osc)}).add;)