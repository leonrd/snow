package snow.io.typedarray;

#if js

    @:forward
    @:arrayAccess
    abstract Uint16Array(js.html.Uint16Array)
        from js.html.Uint16Array
        to js.html.Uint16Array {

        @:generic
        public inline function new<T>(
            ?elements:Int,
            ?array:Array<T>,
            ?view:ArrayBufferView,
            ?buffer:ArrayBuffer, ?byteoffset:Int = 0, ?len:Null<Int>
        ) {
            if(elements != null) {
                this = new js.html.Uint16Array( elements );
            } else if(array != null) {
                this = new js.html.Uint16Array( untyped array );
            } else if(view != null) {
                this = new js.html.Uint16Array( untyped view );
            } else if(buffer != null) {
                len = (len == null) ? untyped __js__('undefined') : len;
                this = new js.html.Uint16Array( buffer, byteoffset, len );
            } else {
                this = null;
            }
        }

        @:arrayAccess inline function __set(idx:Int, val:UInt) return this[idx] = val;
        @:arrayAccess inline function __get(idx:Int) : UInt return this[idx];

    }

#else

    import snow.io.typedarray.ArrayBufferView;
    import snow.io.typedarray.TypedArrayType;

    @:forward()
    @:arrayAccess
    abstract Uint16Array(ArrayBufferView) from ArrayBufferView to ArrayBufferView {

        public inline static var BYTES_PER_ELEMENT : Int = 2;

        public var length (get, never):Int;

        @:generic
        public inline function new<T>(
            ?elements:Int,
            ?array:Array<T>,
            ?view:ArrayBufferView,
            ?buffer:ArrayBuffer, ?byteoffset:Int = 0, ?len:Null<Int>
        ) {

            if(elements != null) {
                this = new ArrayBufferView( elements, Uint16 );
            } else if(array != null) {
                this = new ArrayBufferView(0, Uint16).initArray(array);
            } else if(view != null) {
                this = new ArrayBufferView(0, Uint16).initTypedArray(view);
            } else if(buffer != null) {
                this = new ArrayBufferView(0, Uint16).initBuffer(buffer, byteoffset, len);
            } else {
                throw "Invalid constructor arguments for Uint16Array";
            }
        }

    //Public API

            //still busy with this
        public inline function subarray( begin:Int, end:Null<Int> = null) : Uint16Array return this.subarray(begin, end);

    //Internal

        inline function get_length() return this.length;


        @:noCompletion
        @:arrayAccess
        public inline function __get(idx:Int) {
            return ArrayBufferIO.getUint16(this.buffer, this.byteOffset+(idx*BYTES_PER_ELEMENT));
        }

        @:noCompletion
        @:arrayAccess
        public inline function __set(idx:Int, val:UInt) {
            return ArrayBufferIO.setUint16(this.buffer, this.byteOffset+(idx*BYTES_PER_ELEMENT), val);
        }

    }

#end //!js