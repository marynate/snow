package snow.platform.native.audio;

import snow.audio.Audio;
import snow.types.Types;


class SoundStream extends snow.audio.Sound {


        /** The length of bytes for a single buffer to queue up to stream. default: 176400, about 1 second in 16 bit mono.*/
    public var buffer_length : Int;
        /** The number of buffers to use in the queue for streaming. default: 4` */
    public var buffer_count : Int;
        /** The get function, assign a function here if you want to stream data to the source manually, like generative sound. */
    public var data_get : Int->Int->AudioDataBlob;
        /** The seek function, assign a function here if you want to stream data to the source manually, like generative sound. */
    public var data_seek : Int->Bool;


    public function new( _manager:Audio, _name:String ) {

        super(_manager, _name);

        buffer_length = _manager.lib.config.native.audio_buffer_length;
        buffer_count = _manager.lib.config.native.audio_buffer_count;

        data_get = default_data_get;
        data_seek = default_data_seek;

    } //new

        /** Default data seek implementation for `SoundStream` uses `assets.system.audio_seek_source` */
    function default_data_seek( _to:Int ) : Bool {

        return manager.lib.assets.platform.audio_seek_source( info, _to );

    } //default_data_seek

        /** Default data get implementation for `SoundStream` uses `assets.system.audio_load_portion` */
    function default_data_get( _start:Int, _length:Int ) : AudioDataBlob {

        return manager.lib.assets.platform.audio_load_portion( info, _start, _length );

    } //default_data_get

} //SoundStream
