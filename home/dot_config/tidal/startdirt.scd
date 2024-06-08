// SuperCollider Boot File

(
s.reboot { // server options are only updated on reboot
// configure the sound server: here you could add hardware specific options
// see http://doc.sccode.org/Classes/ServerOptions.html
s.options.numBuffers = 1024 * 256; // increase this if you need to load more samples
s.options.memSize = 8192 * 32; // increase this if you get "alloc failed" messages
s.options.numWireBufs = 64; // increase this if you get "exceeded number of interconnect buffers" messages
s.options.maxNodes = 1024 * 32; // increase this if you are getting drop outs and the message "too many nodes"
s.options.numOutputBusChannels = 2; // set this to your hardware output channel size, if necessary
s.options.numInputBusChannels = 2; // set this to your hardware output channel size, if necessary
// boot the server and start SuperDirt
s.waitForBoot {
    ~dirt.stop; // stop any old ones, avoid duplicate dirt (if it is nil, this won't do anything)
    ~dirt = SuperDirt(2, s); // two output channels, increase if you want to pan across more channels
    // Load mi-ugens synthdefs
    (Platform.userAppSupportDir +/+ "synthdefs" +/+ "mi-ugens.scd").load;

    ~dirt.loadSoundFiles;
    // Load additional samples from ~/Music/Dirt/samples/
    ~dirt.loadSoundFiles(Platform.userHomeDir +/+ "Music" +/+ "Dirt" +/+ "samples" +/+ "*");
    // for example: ~dirt.loadSoundFiles("/Users/myUserName/Dirt/samples/*");
    // s.sync; // optionally: wait for samples to be read
    ~dirt.start(57120, 0 ! 12); // start listening on port 57120, create two busses each sending audio to channel 0

    // optional, needed for convenient access from sclang:
    (
        ~d1 = ~dirt.orbits[0]; ~d2 = ~dirt.orbits[1]; ~d3 = ~dirt.orbits[2];
        ~d4 = ~dirt.orbits[3]; ~d5 = ~dirt.orbits[4]; ~d6 = ~dirt.orbits[5];
        ~d7 = ~dirt.orbits[6]; ~d8 = ~dirt.orbits[7]; ~d9 = ~dirt.orbits[8];
        ~d10 = ~dirt.orbits[9]; ~d11 = ~dirt.orbits[10]; ~d12 = ~dirt.orbits[11];
    );
    
    // define global effects for mutable instruments effects
    ~dirt.orbits.do { |x|
        var clouds = GlobalDirtEffect(\global_mi_clouds, [\cloudspitch, \cloudspos, \cloudssize, \cloudsdens, \cloudstex, \cloudswet, \cloudsgain, \cloudsspread, \cloudsrvb, \cloudsfb, \cloudsfreeze, \cloudsmode, \cloudslofi]);
        var verb = GlobalDirtEffect(\global_mi_verb, [\verbwet, \verbtime, \verbdamp, \verbhp, \verbfreeze, \verbdiff, \verbgain]);
        x.globalEffects = x.globalEffects
            .addFirst(clouds)
            .addFirst(verb); 
        x.initNodeTree;    
    };                     
    // end define global effects for mutable instruments effects
};
s.latency = 0.3; // increase this if you get "late" messages
};
)

