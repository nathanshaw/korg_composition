//simple drum machine that can be used with the chronome
public class drummer{
    
    string kick_samples[5];
    me.dir() + "/audio/kick_01.wav" => kick_samples[0];
    me.dir() + "/audio/kick_02.wav" => kick_samples[1];
    me.dir() + "/audio/kick_03.wav" => kick_samples[2];
    me.dir() + "/audio/kick_04.wav" => kick_samples[3];
    me.dir() + "/audio/kick_05.wav" => kick_samples[4];
    
    string snare_samples[3];
    
    me.dir() + "/audio/snare_01.wav" => snare_samples[0];
    me.dir() + "/audio/snare_02.wav" => snare_samples[1];
    me.dir() + "/audio/snare_03.wav" => snare_samples[2];
    
    string hiHatOpen_samples[4];
    
    me.dir() + "/audio/hihat_01.wav" => hiHatOpen_samples[0];
    me.dir() + "/audio/hihat_02.wav" => hiHatOpen_samples[1];
    me.dir() + "/audio/hihat_03.wav" => hiHatOpen_samples[2];
    me.dir() + "/audio/hihat_04.wav" => hiHatOpen_samples[3];
    
    string hiHatClosed_samples[4];
    
    me.dir() + "/audio/hihat_01.wav" => hiHatClosed_samples[0];
    me.dir() + "/audio/hihat_02.wav" => hiHatClosed_samples[1];
    me.dir() + "/audio/hihat_03.wav" => hiHatClosed_samples[2];
    me.dir() + "/audio/hihat_04.wav" => hiHatClosed_samples[3];
    
    string click_samples[5];
    
    me.dir() + "/audio/click_01.wav" => click_samples[0];
    me.dir() + "/audio/click_02.wav" => click_samples[1];
    me.dir() + "/audio/click_03.wav" => click_samples[2];
    me.dir() + "/audio/click_04.wav" => click_samples[3];
    me.dir() + "/audio/click_05.wav" => click_samples[4];
    
    string cowbell_samples[1];
    
    me.dir() + "/audio/cowbell_01.wav" => cowbell_samples[0];
    
    string clap_samples[1];
    
    me.dir() + "/audio/clap_01.wav" => clap_samples[0];
    
    string other_samples[5];
    
    me.dir() + "/audio/stereo_fx_05.wav" => other_samples[0];
    me.dir() + "/audio/stereo_fx_01.wav" => other_samples[1];
    me.dir() + "/audio/stereo_fx_02.wav" => other_samples[2];
    me.dir() + "/audio/stereo_fx_03.wav" => other_samples[3];
    me.dir() + "/audio/stereo_fx_04.wav" => other_samples[4];
    
    SndBuf snare => Pan2 snarep => dac;
    SndBuf kick => Pan2 kickp => dac;
    SndBuf hihato => Pan2 hihatop => dac;
    SndBuf hihatc => Pan2  hihatcp => dac;
    SndBuf click => Pan2 clickp =>  dac;
    SndBuf toms => Pan2  tomsp => dac;
    SndBuf cowbell => Pan2 cowbellp => dac;
    SndBuf other => Pan2 otherp => dac;
    
    fun void initalize(){
        kick_samples[0] => kick.read;
        kick.samples() => kick.pos;
        snare_samples[0] => snare.read;
        snare.samples() => snare.pos;
        hiHatOpen_samples[0] => hihato.read;
        hihato.samples() => hihato.pos;
        hiHatClosed_samples[0] => hihatc.read;
        hihatc.samples() => hihatc.pos;
        click_samples[0] => click.read;
        click.samples() => click.pos;
        kick_samples[1] => toms.read;
        toms.samples() => toms.pos;
        cowbell_samples[0] => cowbell.read;
        cowbell.samples() => cowbell.pos;
        other_samples[1] => other.read;
        other.samples() => other.pos;       
    }
    
    fun void modulate(int drum, float gain, float pan, float rate){
        if (drum == 0){
            pan => kickp.pan;
            gain => hihato.gain;
            rate => hihato.rate;
        }
        else if (drum == 1){
            pan => snarep.pan;
            gain => snare.gain;
            rate => snare.rate;
        }
        else if (drum == 2){
            pan => hihatop.pan;
            gain => hihato.gain;
            rate => hihato.rate;
        }
        else if (drum == 3){
            pan => hihatcp.pan;
            gain => hihatc.gain;
            rate => hihatc.rate;
        }
        else if (drum == 4){
            pan => clickp.pan;
            gain => click.gain;
            rate => click.rate;
        }
        else if (drum == 5){
            pan => tomsp.pan;
            gain => toms.gain;
            rate => toms.rate;
        }
        else if (drum == 6){
            pan => cowbellp.pan;
            gain => cowbell.gain;
            rate => cowbell.rate;
        }
        else if (drum == 7){
            pan => otherp.pan;
            gain => other.gain;
            rate => other.rate;
        }        
    }
    
    fun void pan(int x, float p){
        
        if (x == 0){
            p => kickp.pan;
        }
        else if (x == 1){
            p => snarep.pan;     
        }
        else if (x == 2){
            p => hihatop.pan;     
        }
        else if (x == 3){
            p => hihatcp.pan;
        }
        else if (x == 4){
            p => clickp.pan;
        }
        else if (x == 5){
            p => tomsp.pan;
        }
        else if (x == 6){
            p => cowbellp.pan;
        }
        else if (x == 7){
            p => otherp.pan;
        }
    }
    
    
    fun void hit(int x){
        
        if (x == 0){
            0 => kick.pos;
        }
        else if (x == 1){
            0 => snare.pos;     
        }
        else if (x == 2){
            0 => hihato.pos;     
        }
        else if (x == 3){
            0 => hihatc.pos;
        }
        else if (x == 4){
            0 => click.pos;
        }
        else if (x == 5){
            0 => toms.pos;
        }
        else if (x == 6){
            0 => cowbell.pos;
        }
        else if (x == 7){
            0 => other.pos;
        }
    }
    
    fun void gain(int x, float g){
        
        if (x == 0){
            g => kick.gain;   
        }
        else if (x == 1){
            g => snare.gain; 
        }
        else if (x == 2){
            g => hihato.gain;
        }
        else if (x == 3){
            g => hihatc.gain;
        }
        else if (x == 4){
            g => click.gain;
        }
        else if (x == 5){
            g => toms.gain;
        }
        else if (x == 6){
            g => cowbell.gain;
        }
        else if (x == 7){
            g => other.gain;
        }
    }
    
    fun void changeRate(int x, float r){
        
        if (x == 0){
            r => kick.rate;   
        }
        else if (x == 1){
            r => snare.rate; 
        }
        else if (x == 2){
            r => hihato.rate;
        }
        else if (x == 3){
            r => hihatc.rate;
        }
        else if (x == 4){
            r => click.rate;
        }
        else if (x == 5){
            r*2 => toms.rate;
        }
        else if (x == 6){
            r => cowbell.rate;
        }
        else if (x == 7){
            r => other.rate;
        }
    }
    fun void switchSample(int x){
        
        if (x == 0){
            kick_samples[ Math.random2(0, 500) % kick_samples.cap()] => kick.read;
            kick.samples() => kick.pos;   
        }
        else if (x == 1){
            snare_samples[ Math.random2(0, 500) % snare_samples.cap()] => snare.read;         
            snare.samples() => snare.pos;   
        }
        else if (x == 2){
            hiHatOpen_samples[ Math.random2(0, 500) % hiHatOpen_samples.cap()] => hihato.read;
            hihato.samples() => hihato.pos;   
        }
        else if (x == 3){
            hiHatClosed_samples[ Math.random2(0, 500) % hiHatClosed_samples.cap()] => hihatc.read;
            hihatc.samples() => hihatc.pos;   
        }
        else if (x == 4){
            click_samples[ Math.random2(0, 500) % click_samples.cap()] => click.read;
            click.samples() => click.pos;   
        }
        else if (x == 5){
            kick_samples[ Math.random2(0, 500) % kick_samples.cap()] => toms.read;
            toms.samples() => toms.pos;   
        }
        else if (x == 6){
            cowbell_samples[ Math.random2(0, 500) % cowbell_samples.cap()] => cowbell.read;
            cowbell.samples() => cowbell.pos;   
        }
        else if (x == 7){
            other_samples[ Math.random2(0, 500) % other_samples.cap()] => other.read;
            other.samples() => other.pos;   
        }
    }
    
    fun void switchSample(int x, int y){
        
        if (x == 0){
            kick_samples[ y % kick_samples.cap()] => kick.read;
        }
        else if (x == 1){
            snare_samples[ y % snare_samples.cap()] => snare.read;      
        }
        else if (x == 2){
            hiHatOpen_samples[ y % hiHatOpen_samples.cap()] => hihato.read;
        }
        else if (x == 3){
            hiHatClosed_samples[ y % hiHatClosed_samples.cap()] => hihatc.read;
        }
        else if (x == 4){
            click_samples[ y % click_samples.cap()] => click.read;
        }
        else if (x == 5){
            kick_samples[ y % kick_samples.cap()] => toms.read;
            
        }
        else if (x == 6){
            cowbell_samples[ y % cowbell_samples.cap()] => cowbell.read;
            
        }
        else if (x == 7){
            other_samples[ y % other_samples.cap()] => other.read;
        }
    }
}
