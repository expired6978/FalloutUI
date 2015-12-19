package Shared.AS3 
{
    import Shared.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    
    public dynamic class BSUIComponent extends flash.display.MovieClip
    {
        public function BSUIComponent()
        {
            super();
            this._bIsDirty = false;
            this._iPlatform = Shared.PlatformChangeEvent.PLATFORM_INVALID;
            this._bPS3Switch = false;
            this._bAcquiredByNativeCode = false;
            this._bracketPair = new Shared.AS3.BSBracketClip();
            addEventListener(flash.events.Event.ADDED_TO_STAGE, this.onAddedToStageEvent);
            return;
        }

        public function onAcquiredByNativeCode():*
        {
            this._bAcquiredByNativeCode = true;
            return;
        }

        internal final function onEnterFrameEvent(arg1:flash.events.Event):void
        {
            removeEventListener(flash.events.Event.ENTER_FRAME, this.onEnterFrameEvent, false);
            if (this.bIsDirty) 
            {
                this.requestRedraw();
            }
            return;
        }

        internal final function onAddedToStageEvent(arg1:flash.events.Event):void
        {
            removeEventListener(flash.events.Event.ADDED_TO_STAGE, this.onAddedToStageEvent);
            this.onAddedToStage();
            addEventListener(flash.events.Event.REMOVED_FROM_STAGE, this.onRemovedFromStageEvent);
            return;
        }

        internal function requestRedraw():void
        {
            if (stage) 
            {
                stage.addEventListener(flash.events.Event.RENDER, this.onRenderEvent);
                addEventListener(flash.events.Event.ENTER_FRAME, this.onEnterFrameEvent, false, 0, true);
                stage.invalidate();
            }
            return;
        }

        internal final function onRemovedFromStageEvent(arg1:flash.events.Event):void
        {
            removeEventListener(flash.events.Event.REMOVED_FROM_STAGE, this.onRemovedFromStageEvent);
            this.onRemovedFromStage();
            addEventListener(flash.events.Event.ADDED_TO_STAGE, this.onAddedToStageEvent);
            return;
        }

        public function get bPS3Switch():Boolean
        {
            return this._bPS3Switch;
        }

        internal final function onSetPlatformEvent(arg1:flash.events.Event):*
        {
            var loc1:*=arg1 as Shared.PlatformChangeEvent;
            this.SetPlatform(loc1.uiPlatform, loc1.bPS3Switch);
            return;
        }

        public function UpdateBrackets(arg1:Boolean):*
        {
            if (this._bShowBrackets && width > this.bracketCornerLength && height > this._bracketCornerLength) 
            {
                if (arg1) 
                {
                    this._bracketPair.redrawUIComponent(this, this.bracketLineWidth, this.bracketCornerLength, new flash.geom.Point(this._bracketPaddingX, this.bracketPaddingY), this.BracketStyle);
                }
                addChild(this._bracketPair);
            }
            else 
            {
                this._bracketPair.ClearBrackets();
            }
            return;
        }

        public function onAddedToStage():void
        {
            dispatchEvent(new Shared.PlatformRequestEvent(this));
            if (stage) 
            {
                stage.addEventListener(Shared.PlatformChangeEvent.PLATFORM_CHANGE, this.onSetPlatformEvent);
            }
            if (this.bIsDirty) 
            {
                this.requestRedraw();
            }
            return;
        }

        public function get bIsDirty():Boolean
        {
            return this._bIsDirty;
        }

        public function get iPlatform():Number
        {
            return this._iPlatform;
        }

        public function onRemovedFromStage():void
        {
            if (stage) 
            {
                stage.removeEventListener(Shared.PlatformChangeEvent.PLATFORM_CHANGE, this.onSetPlatformEvent);
                stage.removeEventListener(flash.events.Event.RENDER, this.onRenderEvent);
            }
            return;
        }

        public function get bAcquiredByNativeCode():Boolean
        {
            return this._bAcquiredByNativeCode;
        }

        public function get bShowBrackets():Boolean
        {
            return this._bShowBrackets;
        }

        public function set bShowBrackets(arg1:Boolean):*
        {
            if (this.bShowBrackets != arg1) 
            {
                this._bShowBrackets = arg1;
                this.SetIsDirty();
            }
            return;
        }

        public function redrawUIComponent():void
        {
            return;
        }

        public function get bracketLineWidth():Number
        {
            return this._bracketLineWidth;
        }

        public function set bracketLineWidth(arg1:Number):void
        {
            if (this._bracketLineWidth != arg1) 
            {
                this._bracketLineWidth = arg1;
                this.SetIsDirty();
            }
            return;
        }

        public function get bUseShadedBackground():Boolean
        {
            return this._bUseShadedBackground;
        }

        public function get bracketCornerLength():Number
        {
            return this._bracketCornerLength;
        }

        public function set bracketCornerLength(arg1:Number):void
        {
            if (this._bracketCornerLength != arg1) 
            {
                this._bracketCornerLength = arg1;
                this.SetIsDirty();
            }
            return;
        }

        public function SetPlatform(arg1:Number, arg2:Boolean):void
        {
            if (!(this._iPlatform == arg1) || !(this._bPS3Switch == arg2)) 
            {
                this._iPlatform = arg1;
                this._bPS3Switch = arg2;
                this.SetIsDirty();
            }
            return;
        }

        public function get bracketPaddingX():Number
        {
            return this._bracketPaddingX;
        }

        public function set bracketPaddingX(arg1:Number):void
        {
            if (this._bracketPaddingX != arg1) 
            {
                this._bracketPaddingX = arg1;
                this.SetIsDirty();
            }
            return;
        }

        internal final function onRenderEvent(arg1:flash.events.Event):void
        {
            var arEvent:flash.events.Event;
            var bBracketsDrawn:*;
            var preDrawBounds:flash.geom.Rectangle;
            var postDrawBounds:flash.geom.Rectangle;

            var loc1:*;
            bBracketsDrawn = undefined;
            preDrawBounds = null;
            postDrawBounds = null;
            arEvent = arg1;
            removeEventListener(flash.events.Event.ENTER_FRAME, this.onEnterFrameEvent, false);
            if (stage) 
            {
                stage.removeEventListener(flash.events.Event.RENDER, this.onRenderEvent);
            }
            if (this.bIsDirty) 
            {
                this.ClearIsDirty();
                try 
                {
                    bBracketsDrawn = contains(this._bracketPair);
                    if (bBracketsDrawn) 
                    {
                        removeChild(this._bracketPair);
                    }
                    preDrawBounds = getBounds(this);
                    this.redrawUIComponent();
                    postDrawBounds = getBounds(this);
                    this.UpdateBrackets(!bBracketsDrawn || !(preDrawBounds == postDrawBounds));
                }
                catch (e:Error)
                {
                    trace(this + " " + this.name + ": " + e.getStackTrace());
                }
            }
            if (this.bIsDirty) 
            {
                addEventListener(flash.events.Event.ENTER_FRAME, this.onEnterFrameEvent, false, 0, true);
            }
            return;
        }

        public function get bracketPaddingY():Number
        {
            return this._bracketPaddingY;
        }

        public function set bracketPaddingY(arg1:Number):void
        {
            if (this._bracketPaddingY != arg1) 
            {
                this._bracketPaddingY = arg1;
                this.SetIsDirty();
            }
            return;
        }

        public function get BracketStyle():String
        {
            return this._bracketStyle;
        }

        public function set BracketStyle(arg1:String):*
        {
            if (this._bracketStyle != arg1) 
            {
                this._bracketStyle = arg1;
                this.SetIsDirty();
            }
            return;
        }

        public function set bUseShadedBackground(arg1:Boolean):*
        {
            if (this._bUseShadedBackground != arg1) 
            {
                this._bUseShadedBackground = arg1;
                this.SetIsDirty();
            }
            return;
        }

        public function get ShadedBackgroundType():String
        {
            return this._shadedBackgroundType;
        }

        public function set ShadedBackgroundType(arg1:String):*
        {
            if (this._shadedBackgroundType != arg1) 
            {
                this._shadedBackgroundType = arg1;
                this.SetIsDirty();
            }
            return;
        }

        public function get ShadedBackgroundMethod():String
        {
            return this._shadedBackgroundMethod;
        }

        public function set ShadedBackgroundMethod(arg1:String):*
        {
            if (this._shadedBackgroundMethod != arg1) 
            {
                this._shadedBackgroundMethod = arg1;
                this.SetIsDirty();
            }
            return;
        }

        public function SetIsDirty():void
        {
            this._bIsDirty = true;
            this.requestRedraw();
            return;
        }

        internal final function ClearIsDirty():void
        {
            this._bIsDirty = false;
            return;
        }

        internal var _bIsDirty:Boolean;

        internal var _iPlatform:Number;

        internal var _bPS3Switch:Boolean;

        internal var _bAcquiredByNativeCode:Boolean;

        internal var _bShowBrackets:Boolean=false;

        internal var _shadedBackgroundType:String="normal";

        internal var _shadedBackgroundMethod:String="Shader";

        internal var _bracketPair:Shared.AS3.BSBracketClip;

        internal var _bUseShadedBackground:Boolean=false;

        internal var _bracketLineWidth:Number=1.5;

        internal var _bracketPaddingX:Number=0;

        internal var _bracketStyle:String="horizontal";

        internal var _bracketPaddingY:Number=0;

        internal var _bracketCornerLength:Number=6;
    }
}
