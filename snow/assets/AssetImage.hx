package snow.assets;

import snow.io.IO;
import snow.types.Types;
import snow.utils.ByteArray;
import snow.utils.Libs;
import snow.assets.Asset;
import snow.assets.AssetSystem;


/**  An asset that contains image file `data` as an `ImageInfo`. Get assets from the `Assets` class, via `app.assets` */
class AssetImage extends Asset {

        /** The `ImageInfo` this asset contains */
    public var data : ImageInfo;
        /** The requested components when loading this image */
    public var components : Int = 4;


    public function new( _assets:Assets, _info:AssetInfo, ?_components:Int=4 ) {

        super( _assets, _info );
        type = AssetType.image;
        components = _components;

    } //new

    public function load( ?onload:AssetImage->Void ) {

        loaded = false;
            //clear any old data in case
        data = null;
            //load the new data
        assets.system.image_load_info( info.path, components, function( ?_image:ImageInfo ) {

            data = _image;

            loaded = true;

            if(onload != null) {
                onload( this );
            }

        });

    } //load

} //AssetImage
