SinOsc sine[8];
Pan2 panners[8];
ADSR env[8];

float offset[8];
int state[8];

120 => int fundamental;

for(0 => int i; i < 8; i++){
    //sine[i] => dac;
    sine[i] => panners[i] => env[i] => dac;   
    env[i].set(Math.random2(10,60)::ms, Math.random2(10,60)::ms, 0.5, Math.random2(90,400)::ms);
    0 => offset[i];
    0 => sine[i].gain;
    //0.2 => panners[i].gain;
} 


fun void setFund(int freq){
    freq => fundamental;
    freq + offset[0] => sine[0].freq;
    freq*2 + offset[1] => sine[1].freq;
    freq*3 + offset[2] => sine[2].freq;
    freq*4 + offset[3] => sine[3].freq;
    freq*5 + offset[4] => sine[4].freq;
    freq*6 + offset[5] => sine[5].freq;
    freq*7 + offset[6] => sine[6].freq;
    freq*8 + offset[7] => sine[7].freq;   
}

fun void offsetSet(int x, float off){
    off => offset[x];
    off + ((x+1)*fundamental) => sine[x].freq;;   
}

fun void pan(int x, float p){
    panners[x].pan(p);    
}

fun void hit(int x){
    env[x].keyOn(1);    
}

fun void off(int x){
    env[x].keyOff(1);
}

fun void gain(int x, float g){   
    (g * g)*0.1 => g;
    g*(1-(x/10)) => g;
    sine[x].gain(g);
}

MidiIn korg;
MidiMsg msg;
//open midi receiver, exit on fail
if( !korg.open(0) ){
    <<<"Problem connecting to MIDI device">>>;   
}
//function for shred
setFund(fundamental);

fun void serialPoller()
{
    while(1){
        korg => now;
        while(korg.recv(msg)){
            //<<<msg.data1, msg.data2, msg.data3>>>;
            msg.data2 => int channel;
            msg.data3 => int value;
            //<<<"channel : ", channel >>>;
            //<<<"value : ", value >>>;
            
            if(-1 < channel && channel < 8){
                (value$float/127) => float tempFloat;
                gain(channel, tempFloat);
            }
            else if (channel > 15 && channel < 24){
                offsetSet(channel-16, (value-64)*0.1);
            }
            else if(channel > 31 && channel < 40){
                if(value == 127){
                    hit(channel-32);
                }   
                else{
                    off(channel-32);   
                }     
            } 
            else if(channel > 47 && channel < 56){
                47 -=> channel;
                20 *=> channel;
                setFund(channel);      
            }
            else if (channel > 63 && channel < 71){
                64 -=> channel;
                if(value == 127 && state[channel] == 0){
                    hit(channel);   
                    1 => state[channel];
                }
                else if (value == 127 && state[channel] ==1){
                    off(channel);
                    0 => state[channel];   
                }
            }
        }
    }
}   


spork ~ serialPoller();

while(1){
    1::second => now;   
}