

// Here we create a very simple instrument. Select the lines and press ctrl+enter
(
SynthDef("simpleSin", {
	arg freq=440, amp=1;
	var osc, osc1, osc2, osc3, osc4;

	osc1=SinOsc.ar(freq);
	osc2=SinOsc.ar(freq*2+0.2);
	//osc3=SinOsc.ar(freq*3);
	osc4=SinOsc.ar(freq*4+0.4);
	osc=0.5*(osc1+0.5*osc2+0.125*osc4);

	Out.ar(0,osc*amp);}).add;
)

// Here there is a test if our instrument is going well
(
var instr;
instr= Synth(\simpleSin);
instr.set(\amp,0.9);
instr.set(\freq,500);
)



//set the server
NetAddr("192.168.1.7",57120);

// online use
(
var instr;
instr = Synth(\simpleSin);

OSCdef('OSCreceiver',
	{
		arg msg;

		var freq,amp;


		msg.postln;
		freq= 440*(2-msg[1]);
		freq.postln;

		amp= msg[3]+1;
		amp.postln;
		instr.set(\freq,freq, \amp,amp);

	},
	"/mobile1/rotation");
)

