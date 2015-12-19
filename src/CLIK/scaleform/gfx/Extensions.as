/**************************************************************************

Filename    :   Extensions.as

Copyright   :   Copyright 2011 Autodesk, Inc. All Rights reserved.

Use of this software is subject to the terms of the Autodesk license
agreement provided at the time of installation or download, or which
otherwise accompanies this software in either electronic or hard copy form.

**************************************************************************/

package scaleform.gfx
{
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import flash.text.TextField

   public final class Extensions
   {       
        // Enable/disable GFx extensions
        static public function set enabled(value:Boolean) : void {}
        static public function get enabled() : Boolean { return false; }
        
        // Enable/disable advance of invisible MovieClips (extensions must be enabled)
        static public function set noInvisibleAdvance(value:Boolean) : void {}
        static public function get noInvisibleAdvance() : Boolean { return false; }

        // Returns a topmost DisplayObject instance that can be found at (x, y) coordinates (stage
        // coord space). The parameter testAll (default - false) lets to search for any displayObject (otherwise, only interactive
        // ones with event handlers will be used).
        static public function getTopMostEntity(x:Number, y:Number, testAll:Boolean = true) : DisplayObject
        { return null; }

        // Returns a topmost DisplayObject instance that can be found at current mouse cursor position. 
        // The parameter testAll (default - false) lets to search for any displayObject (otherwise, only interactive
        // ones with event handlers will be used), mouseIndex specifies an zero-based index of the mouse (default - 0).
        static public function getMouseTopMostEntity(testAll:Boolean = true, mouseIndex:uint = 0) : DisplayObject
        { return null; }

        // set/get mouse cursor type, similar to flash.ui.Mouse.cursor property but supports multiple
        // mouse cursors. 'cursor' param - one of the value of flash.ui.MouseCursor enums.
        static public function setMouseCursorType(cursor:String, mouseIndex:uint = 0) : void {}
        static public function getMouseCursorType(mouseIndex:uint = 0) : String { return ""; }

        // Returns the number of controllers available (extensions must be enabled)
        static public function get numControllers() : uint { return 1; }
        
        // Returns the visibleRect of the stage (extensions must be enabled).
        static public function get visibleRect() : Rectangle { return new Rectangle(0, 0, 0, 0); }
        
        // Toggle EdgeAA per DisplayObject
        //
        // EdgeAA configuration modes for DisplayObject types
        public static const EDGEAA_INHERIT:uint     = 0;    // Inherit the EdgeAA mode of parent; On by default
        public static const EDGEAA_ON:uint          = 1;    // Use EdgeAA for DisplayObject and its children, unless disabled (see EDGEAA_DISABLE)
        public static const EDGEAA_OFF:uint         = 2;    // Do not use EdgeAA for this DisplayObject or its children
        public static const EDGEAA_DISABLE:uint     = 3;    // Disable EdgeAA for this DisplayObject and children, overriding EDGEAA_ON settings.       
        //
        static public function getEdgeAAMode(dispObj:DisplayObject): uint { return EDGEAA_INHERIT; }
        static public function setEdgeAAMode(dispObj:DisplayObject, mode:uint):void { }
        
        // Configure IME support
        static public function setIMEEnabled(textField:TextField, isEnabled:Boolean): void {}
        
        static public var CLIK_addedToStageCallback:Function;

        public static function get isScaleform():Boolean { return false; }
        public static var isGFxPlayer:Boolean=false;
        public static var gfxProcessSound:Function;
   }
}


package scaleform.gfx 
{
    import flash.display.*;
    import flash.geom.*;
    import flash.text.*;
    
    public final class Extensions extends Object
    {
        public function Extensions()
        {
            super();
        }

        public static function set enabled(arg1:Boolean):void
        {
            return;
        }

        public static function get enabled():Boolean
        {
            return false;
        }

        public static function set noInvisibleAdvance(arg1:Boolean):void
        {
            return;
        }

        public static function get noInvisibleAdvance():Boolean
        {
            return false;
        }

        public static function getTopMostEntity(arg1:Number, arg2:Number, arg3:Boolean=true):flash.display.DisplayObject
        {
            return null;
        }

        public static function getMouseTopMostEntity(arg1:Boolean=true, arg2:uint=0):flash.display.DisplayObject
        {
            return null;
        }

        public static function setMouseCursorType(arg1:String, arg2:uint=0):void
        {
            return;
        }

        public static function getMouseCursorType(arg1:uint=0):String
        {
            return "";
        }

        public static function get numControllers():uint
        {
            return 1;
        }

        public static function get visibleRect():flash.geom.Rectangle
        {
            return new flash.geom.Rectangle(0, 0, 0, 0);
        }

        public static function getEdgeAAMode(arg1:flash.display.DisplayObject):uint
        {
            return EDGEAA_INHERIT;
        }

        public static function setEdgeAAMode(arg1:flash.display.DisplayObject, arg2:uint):void
        {
            return;
        }

        public static function setIMEEnabled(arg1:flash.text.TextField, arg2:Boolean):void
        {
            return;
        }

        public static function get isScaleform():Boolean
        {
            return false;
        }

        public static const EDGEAA_INHERIT:uint=0;
        public static const EDGEAA_ON:uint=1;
        public static const EDGEAA_OFF:uint=2;
        public static const EDGEAA_DISABLE:uint=3;
        public static var isGFxPlayer:Boolean=false;
        public static var CLIK_addedToStageCallback:Function;
        public static var gfxProcessSound:Function;
    }
}
