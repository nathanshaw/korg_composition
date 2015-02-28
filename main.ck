MidiIn korg;
MidiMsg msg;
//open midi receiver, exit on fail
if( !korg.open(0) ){
   //<<<"Problem connecting to MIDI device">>>;   
}
//function for shred

drummer drum;
drum.initalize();
1::second => now;

while(1){
    korg => now;
    
    while(korg.recv(msg)){
        //<<<msg.data1, msg.data2, msg.data3>>>;
        //single hit fro drums
        msg.data2 => int channel;
        msg.data3 => int value;
        //<<<"channel : ", channel >>>;
        //<<<"value : ", value >>>;
        
        if(-1 < channel && channel < 8){
            (value$float/127) => float tempFloat;
            //<<<tempFloat>>>;
        drum.gain(channel, tempFloat);
        }
        else if (channel > 15 && channel < 24){
            1 +=> value;
         drum.changeRate(channel - 16, value$float/15);   
        }
        else if(31 < channel && channel < 40){
            if(value == 127){
                //<<<"triggering drum type :", (channel-32)>>>;
                drum.hit(channel-32);
            }   
        } 
        else if(channel > 47 && channel < 56){
            if(value == 127){
             //<<<"Changing channel ", (channel-48), "to another samples">>>;
             drum.switchSample(channel - 48);
            }   
        }
    }
    
}   
