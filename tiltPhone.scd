

// Here we create a very simple instrument. Select the lines and press ctrl+enter
(
SynthDef("simpleSin", {
	arg freq=440, amp=1; // here we expect to receive two inputs: frequency and amplitude
	var osc, osc1, osc2, osc3, osc4; // we are going to create several oscillators (sinusoids)

	osc1=SinOsc.ar(freq);  // first oscillator runs at the frequency
	osc2=SinOsc.ar(freq*2+0.2); // this runs at twice the frequency + a little phase
	//osc3=SinOsc.ar(freq*3);
	osc4=SinOsc.ar(freq*4+0.4);
	osc=0.5*(osc1+0.5*osc2+0.125*osc4);  // here the final oscillator is a weighted sum of the many oscillators

	Out.ar(0,osc*amp);}).add; // amp is here defined to the final volume, and set to the output
)

// Here there is a test if our instrument is going well
(
var instr;
instr= Synth(\simpleSin);
instr.set(\amp,0.9);
instr.set(\freq,100);
)



//set the server
NetAddr("192.168.1.7",57120);

// online use
(
var instr; // here we have an instrument
instr = Synth(\simpleSin); //the instrument is simpleSin

OSCdef('OSCreceiver',
	{
		arg msg; // we expect to receive a OSC message, which is a vector

		var freq,amp; // we will have two variables: frequency and amplitude (volume)


		msg.postln; // this shows the msg: msg[0]=tag, msg[1], msg[2], ... are the actual values
		freq= 440*(2-msg[1]); // rotation assigned to frequency
		freq.postln;

		amp= msg[3]+1; // rotation assign to amplitude
		amp.postln;
		instr.set(\freq,freq, \amp,amp); // change the frequency and amplitude of our instrument

	},
	"/mobile1/rotation"); // defined tag.
)

