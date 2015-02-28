me.dir() + "/drummer.ck" => string drummerID;
Machine.add(drummerID) => int drummerInt;

MidiIn korg;
MidiMsg msg;
//open midi receiver, exit on fail
if( !korg.open(0) ){
 <<<"Problem connecting to MIDI device">>>;   
}
//function for shred

drummer drum;
drum.initalize();
1::second => now;

while(1){
    korg => now;
    
    while(korg.recv(msg)){
        <<<msg.data1, msg.data2, msg.data3>>>;
        if(31 < msg.data2 > 40){
         drum.hit(msg.data2-32);   
        } 
    }
    
}   
