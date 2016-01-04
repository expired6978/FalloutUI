package Shared.AS3 
{
    import Shared.AS3.COMPANIONAPP.*;
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    
    public dynamic class BSButtonHintBar extends Shared.AS3.BSUIComponent
    {
        public function BSButtonHintBar()
        {
            this.SetButtonHintData = this.SetButtonHintData_Impl;
            super();
            visible = false;
            this.ButtonHintBarInternal_mc = new flash.display.MovieClip();
            addChild(this.ButtonHintBarInternal_mc);
            this._buttonHintDataV = new Vector.<Shared.AS3.BSButtonHintData>();
            this.ButtonPoolV = new Vector.<Shared.AS3.BSButtonHint>();
            return;
        }

        public function get bRedirectToButtonBarMenu():Boolean
        {
            return this._bRedirectToButtonBarMenu;
        }

        public function set bRedirectToButtonBarMenu(arg1:Boolean):*
        {
            if (this._bRedirectToButtonBarMenu != arg1) 
            {
                this._bRedirectToButtonBarMenu = arg1;
                SetIsDirty();
            }
            return;
        }

        public function get BackgroundColor():uint
        {
            return this._backgroundColor;
        }

        public function set BackgroundColor(arg1:uint):*
        {
            if (this._backgroundColor != arg1) 
            {
                this._backgroundColor = arg1;
                SetIsDirty();
            }
            return;
        }

        public function get BackgroundAlpha():Number
        {
            return this._backgroundAlpha;
        }

        public function set BackgroundAlpha(arg1:Number):*
        {
            if (this._backgroundAlpha != arg1) 
            {
                this._backgroundAlpha = arg1;
            }
            return;
        }

        public override function get bShowBrackets():Boolean
        {
            return this._bShowBrackets_Override;
        }

        public override function set bShowBrackets(arg1:Boolean):*
        {
            this._bShowBrackets_Override = arg1;
            SetIsDirty();
            return;
        }

        public override function get bUseShadedBackground():Boolean
        {
            return this._bUseShadedBackground_Override;
        }

        public override function set bUseShadedBackground(arg1:Boolean):*
        {
            this._bUseShadedBackground_Override = arg1;
            SetIsDirty();
            return;
        }

        internal function CanBeVisible():Boolean
        {
            return !this.bRedirectToButtonBarMenu || !bAcquiredByNativeCode;
        }

        public override function onAcquiredByNativeCode():*
        {
            var loc1:*=null;
            super.onAcquiredByNativeCode();
            if (this.bRedirectToButtonBarMenu) 
            {
                this.SetButtonHintData(this._buttonHintDataV);
                loc1 = new Vector.<Shared.AS3.BSButtonHintData>();
                this.SetButtonHintData_Impl(loc1);
                SetIsDirty();
            }
            return;
        }

        internal function SetButtonHintData_Impl(arg1:__AS3__.vec.Vector.<Shared.AS3.BSButtonHintData>):void
        {
            var abuttonHintDataV:__AS3__.vec.Vector.<Shared.AS3.BSButtonHintData>;

            var loc1:*;
            abuttonHintDataV = arg1;
            this._buttonHintDataV.forEach(function (arg1:Shared.AS3.BSButtonHintData, arg2:int, arg3:__AS3__.vec.Vector.<Shared.AS3.BSButtonHintData>):*
            {
                if (arg1) 
                {
                    arg1.removeEventListener(Shared.AS3.BSButtonHintData.BUTTON_HINT_DATA_CHANGE, this.onButtonHintDataDirtyEvent);
                }
                return;
            }, this)
            this._buttonHintDataV = abuttonHintDataV;
            this._buttonHintDataV.forEach(function (arg1:Shared.AS3.BSButtonHintData, arg2:int, arg3:__AS3__.vec.Vector.<Shared.AS3.BSButtonHintData>):*
            {
                if (arg1) 
                {
                    arg1.addEventListener(Shared.AS3.BSButtonHintData.BUTTON_HINT_DATA_CHANGE, this.onButtonHintDataDirtyEvent);
                }
                return;
            }, this)
            this.CreateButtonHints();
            return;
        }

        public function onButtonHintDataDirtyEvent(arg1:flash.events.Event):void
        {
            SetIsDirty();
            return;
        }

        internal function CreateButtonHints():*
        {
            visible = false;
            while (this.ButtonPoolV.length < this._buttonHintDataV.length) 
            {
                if (Shared.AS3.COMPANIONAPP.CompanionAppMode.isOn) 
                {
                    this.ButtonPoolV.push(new Shared.AS3.COMPANIONAPP.MobileButtonHint());
                    continue;
                }
                this.ButtonPoolV.push(new Shared.AS3.BSButtonHint());
            }
            var loc1:*=0;
            while (loc1 < this.ButtonPoolV.length) 
            {
                this.ButtonPoolV[loc1].ButtonHintData = loc1 < this._buttonHintDataV.length ? this._buttonHintDataV[loc1] : null;
                ++loc1;
            }
            SetIsDirty();
            return;
        }

        public override function redrawUIComponent():void
        {
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            super.redrawUIComponent();
            if (this.ShadedBackground_mc && contains(this.ShadedBackground_mc)) 
            {
                removeChild(this.ShadedBackground_mc);
            }
            var loc1:*=false;
            var loc2:*=0;
            var loc3:*=0;
            if (Shared.AS3.COMPANIONAPP.CompanionAppMode.isOn) 
            {
                loc3 = stage.stageWidth - 75;
            }
            var loc4:*=0;
            while (loc4 < this.ButtonPoolV.length) 
            {
                if ((loc6 = this.ButtonPoolV[loc4]).ButtonVisible && this.CanBeVisible()) 
                {
                    loc1 = true;
                    if (!this.ButtonHintBarInternal_mc.contains(loc6)) 
                    {
                        this.ButtonHintBarInternal_mc.addChild(loc6);
                    }
                    if (loc6.bIsDirty) 
                    {
                        loc6.redrawUIComponent();
                    }
                    if (Shared.AS3.COMPANIONAPP.CompanionAppMode.isOn && loc6.Justification == Shared.AS3.BSButtonHint.JUSTIFY_RIGHT) 
                    {
                        loc3 = loc3 - loc6.width;
                        loc6.x = loc3;
                    }
                    else 
                    {
                        loc6.x = loc2;
                        loc2 = loc2 + (loc6.width + 20);
                    }
                }
                else if (this.ButtonHintBarInternal_mc.contains(loc6)) 
                {
                    this.ButtonHintBarInternal_mc.removeChild(loc6);
                }
                ++loc4;
            }
            if (this.ButtonPoolV.length > this._buttonHintDataV.length) 
            {
                this.ButtonPoolV.splice(this._buttonHintDataV.length, this.ButtonPoolV.length - this._buttonHintDataV.length);
            }
            if (!Shared.AS3.COMPANIONAPP.CompanionAppMode.isOn) 
            {
                this.ButtonHintBarInternal_mc.x = (-this.ButtonHintBarInternal_mc.width) / 2;
            }
            var loc5:*=this.ButtonHintBarInternal_mc.getBounds(this);
            this.ButtonBracket_Left_mc.x = loc5.left - this.ButtonBracket_Left_mc.width;
            this.ButtonBracket_Right_mc.x = loc5.right;
            this.ButtonBracket_Left_mc.visible = this.bShowBrackets && !Shared.AS3.COMPANIONAPP.CompanionAppMode.isOn;
            this.ButtonBracket_Right_mc.visible = this.bShowBrackets && !Shared.AS3.COMPANIONAPP.CompanionAppMode.isOn;
            if (ShadedBackgroundMethod == "Flash" && this.bUseShadedBackground) 
            {
                if (!this.ShadedBackground_mc) 
                {
                    this.ShadedBackground_mc = new flash.display.MovieClip();
                }
                loc7 = getBounds(this);
                addChildAt(this.ShadedBackground_mc, 0);
                (loc8 = this.ShadedBackground_mc.graphics).clear();
                loc8.beginFill(this.BackgroundColor, this.BackgroundAlpha);
                loc8.drawRect(loc7.x, loc7.y, loc7.width, loc7.height);
                loc8.endFill();
            }
            visible = loc1;
            return;
        }

        public var ButtonBracket_Left_mc:flash.display.MovieClip;

        public var ButtonBracket_Right_mc:flash.display.MovieClip;

        public var ShadedBackground_mc:flash.display.MovieClip;

        internal var ButtonHintBarInternal_mc:flash.display.MovieClip;

        internal var _buttonHintDataV:__AS3__.vec.Vector.<Shared.AS3.BSButtonHintData>;

        public var ButtonPoolV:__AS3__.vec.Vector.<Shared.AS3.BSButtonHint>;

        internal var _bRedirectToButtonBarMenu:Boolean=true;

        internal var _backgroundColor:uint=0;

        internal var _backgroundAlpha:Number=1;

        internal var _bShowBrackets_Override:Boolean=true;

        internal var _bUseShadedBackground_Override:Boolean=true;

        public var SetButtonHintData:Function;
    }
}
