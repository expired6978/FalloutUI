package Shared.AS3 
{
    import Shared.*;
    import Shared.AS3.COMPANIONAPP.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    
    public dynamic class BSButtonHint extends Shared.AS3.BSUIComponent
    {
        public function BSButtonHint()
        {
            super();
            visible = false;
            mouseChildren = false;
            this.bButtonFlashing = false;
            this._strCurrentDynamicMovieClipName = "";
            this.DynamicMovieClip = null;
            this._DyanmicMovieHeight = this.textField_tf.height;
            this._DynamicMovieY = this.textField_tf.y;
            this.SetUpTextFields(this.textField_tf);
            this.SetUpTextFields(this.IconHolderInstance.IconAnimInstance.Icon_tf);
            this.SetUpTextFields(this.SecondaryIconHolderInstance.IconAnimInstance.Icon_tf);
            this._hitArea = new flash.display.Sprite();
            this._hitArea.graphics.beginFill(0);
            this._hitArea.graphics.drawRect(0, 0, 1, 1);
            this._hitArea.graphics.endFill();
            this._hitArea.visible = false;
            this._hitArea.mouseEnabled = false;
            addEventListener(flash.events.MouseEvent.CLICK, this.onTextClick);
            addEventListener(flash.events.MouseEvent.MOUSE_OVER, this.onMouseOver);
            addEventListener(flash.events.MouseEvent.MOUSE_OUT, this.onMouseOut);
            return;
        }

        public override function redrawUIComponent():void
        {
            super.redrawUIComponent();
            hitArea = null;
            if (contains(this._hitArea)) 
            {
                removeChild(this._hitArea);
            }
            visible = this.ButtonVisible;
            if (visible) 
            {
                this.redrawPrimaryButton();
                this.redrawDynamicMovieClip();
                this.redrawTextField();
                this.redrawSecondaryButton();
                this.SetFlashing(this._buttonHintData.ButtonFlashing);
                this.redrawHitArea();
                addChild(this._hitArea);
                hitArea = this._hitArea;
            }
            return;
        }

        public function SetFlashing(arg1:Boolean):*
        {
            if (arg1 != this.bButtonFlashing) 
            {
                this.bButtonFlashing = arg1;
                this.IconHolderInstance.gotoAndPlay(arg1 ? "Flashing" : "Default");
            }
            return;
        }

        internal function UpdateIconTextField(arg1:flash.text.TextField, arg2:String):*
        {
            var loc4:*=undefined;
            arg1.text = arg2;
            var loc1:*=this.GetExpectedFont();
            var loc2:*=arg1.getTextFormat().font;
            if (loc1 != loc2) 
            {
                loc4 = new flash.text.TextFormat(loc1);
                arg1.setTextFormat(loc4);
            }
            var loc3:*=this.UsePCKey ? -1.5 : 0;
            if (arg1.y != loc3) 
            {
                arg1.y = loc3;
            }
            return;
        }

        internal function redrawDynamicMovieClip():void
        {
            var loc1:*=null;
            var loc2:*=NaN;
            if (this._buttonHintData.DynamicMovieClipName != this._strCurrentDynamicMovieClipName) 
            {
                if (this.DynamicMovieClip) 
                {
                    removeChild(this.DynamicMovieClip);
                }
                if (this.UseDynamicMovieClip) 
                {
                    loc1 = flash.utils.getDefinitionByName(this._buttonHintData.DynamicMovieClipName) as Class;
                    this.DynamicMovieClip = new (loc1 as Class)();
                    addChild(this.DynamicMovieClip);
                    loc2 = this._DyanmicMovieHeight / this.DynamicMovieClip.height;
                    this.DynamicMovieClip.scaleX = loc2;
                    this.DynamicMovieClip.scaleY = loc2;
                    this.DynamicMovieClip.alpha = this.AllButtonsDisabled ? DISABLED_GREY_OUT_ALPHA : 1;
                    this.DynamicMovieClip.x = this.Justification != JUSTIFY_LEFT ? this.IconHolderInstance.x - this.DynamicMovieClip.width - DYNAMIC_MOVIE_CLIP_BUFFER : this.IconHolderInstance.width + DYNAMIC_MOVIE_CLIP_BUFFER;
                    this.DynamicMovieClip.y = this._DynamicMovieY;
                }
            }
            return;
        }

        internal function redrawTextField():void
        {
            this.textField_tf.visible = !this.UseDynamicMovieClip;
            if (this.textField_tf.visible) 
            {
                Shared.GlobalFunc.SetText(this.textField_tf, this.ButtonText, false, true, false);
                this.textField_tf.alpha = this.AllButtonsDisabled ? DISABLED_GREY_OUT_ALPHA : 1;
                this.textField_tf.x = this.Justification != JUSTIFY_LEFT ? this.IconHolderInstance.x - this.textField_tf.width : this.IconHolderInstance.width;
            }
            return;
        }

        internal function onButtonHintDataDirtyEvent(arg1:flash.events.Event):void
        {
            SetIsDirty();
            return;
        }

        internal function redrawSecondaryButton():void
        {
            this.SecondaryIconHolderInstance.visible = this._buttonHintData.hasSecondaryButton;
            if (this.SecondaryIconHolderInstance.visible) 
            {
                this.UpdateIconTextField(this.SecondaryIconHolderInstance.IconAnimInstance.Icon_tf, this.SecondaryControllerButton);
                this.SecondaryIconHolderInstance.alpha = this.SecondaryButtonDisabled ? DISABLED_GREY_OUT_ALPHA : 1;
                this.SecondaryIconHolderInstance.x = this.UseDynamicMovieClip ? this.DynamicMovieClip.x + this.DynamicMovieClip.width + DYNAMIC_MOVIE_CLIP_BUFFER : this.textField_tf.x + this.textField_tf.width;
            }
            return;
        }

        internal function redrawPrimaryButton():void
        {
            this.UpdateIconTextField(this.IconHolderInstance.IconAnimInstance.Icon_tf, this.ControllerButton);
            this.IconHolderInstance.alpha = this.ButtonDisabled ? DISABLED_GREY_OUT_ALPHA : 1;
            this.IconHolderInstance.x = this.Justification != JUSTIFY_LEFT ? -this.IconHolderInstance.width : 0;
            return;
        }

        internal function redrawHitArea():void
        {
            var loc1:*=this.getBounds(this);
            this._hitArea.x = loc1.x;
            this._hitArea.width = loc1.width;
            this._hitArea.y = loc1.y;
            this._hitArea.height = loc1.height;
            return;
        }

        internal function GetExpectedFont():String
        {
            var loc1:*=null;
            var loc2:*=false;
            if (this.UsePCKey) 
            {
                loc1 = "$MAIN_Font";
            }
            else 
            {
                loc2 = !this.bMouseOver && !this.bButtonPressed;
                loc1 = loc2 ? "$Controller_buttons_inverted" : "$Controller_buttons";
            }
            return loc1;
        }

        public function set ButtonHintData(arg1:Shared.AS3.BSButtonHintData):void
        {
            if (this._buttonHintData) 
            {
                this._buttonHintData.removeEventListener(Shared.AS3.BSButtonHintData.BUTTON_HINT_DATA_CHANGE, this.onButtonHintDataDirtyEvent);
            }
            this._buttonHintData = arg1;
            if (this._buttonHintData) 
            {
                this._buttonHintData.addEventListener(Shared.AS3.BSButtonHintData.BUTTON_HINT_DATA_CHANGE, this.onButtonHintDataDirtyEvent);
            }
            SetIsDirty();
            return;
        }

        internal function SetUpTextFields(tf:flash.text.TextField):*
        {
            tf.autoSize = flash.text.TextFieldAutoSize.LEFT;
            tf.antiAliasType = flash.text.AntiAliasType.NORMAL;
        }

        public function get PCKey():String
        {
            if (this._buttonHintData.PCKey) 
            {
                return this.Justification != JUSTIFY_LEFT ? "(" + this._buttonHintData.PCKey : this._buttonHintData.PCKey + ")";
            }
            return "";
        }

        public function get SecondaryPCKey():String
        {
            if (this._buttonHintData.SecondaryPCKey) 
            {
                return "(" + this._buttonHintData.SecondaryPCKey;
            }
            return "";
        }

        internal function get UsePCKey():Boolean
        {
            return iPlatform == Shared.PlatformChangeEvent.PLATFORM_PC_KB_MOUSE && !NameToTextMap.hasOwnProperty(this._buttonHintData.PCKey);
        }

        public function get ControllerButton():String
        {
            var loc1:*="";
            if (!(iPlatform == Shared.PlatformChangeEvent.PLATFORM_MOBILE) && this.UsePCKey) 
            {
                loc1 = this.PCKey;
            }
            else 
            {
                var loc2:*=iPlatform;
            }
            return loc1;
        }

        public function get SecondaryControllerButton():String
        {
            var loc1:*="";
            if (this._buttonHintData.hasSecondaryButton) 
            {
                if (!(iPlatform == Shared.PlatformChangeEvent.PLATFORM_MOBILE) && this.UsePCKey) 
                {
                    loc1 = this.SecondaryPCKey;
                }
                else 
                {
                    var loc2:*=iPlatform;
                }
            }
            return loc1;
        }

        public function get ButtonText():String
        {
            return this._buttonHintData.ButtonText;
        }

        public function get Justification():uint
        {
            if (Shared.AS3.COMPANIONAPP.CompanionAppMode.isOn) 
            {
                return this._buttonHintData == null ? JUSTIFY_LEFT : this._buttonHintData.Justification;
            }
            return this._buttonHintData.Justification;
        }

        public function get ButtonDisabled():Boolean
        {
            return this._buttonHintData.ButtonDisabled;
        }

        public function get SecondaryButtonDisabled():Boolean
        {
            return this._buttonHintData.SecondaryButtonDisabled;
        }

        public function get AllButtonsDisabled():Boolean
        {
            return this.ButtonDisabled && (!this._buttonHintData.hasSecondaryButton || this.SecondaryButtonDisabled);
        }

        public function get ButtonVisible():Boolean
        {
            return this._buttonHintData && this._buttonHintData.ButtonVisible;
        }

        public function get UseDynamicMovieClip():Boolean
        {
            return this._buttonHintData.DynamicMovieClipName.length > 0;
        }

        public function onTextClick(arg1:flash.events.Event):void
        {
            if (!this.ButtonDisabled && this.ButtonVisible) 
            {
                this._buttonHintData.onTextClick();
            }
            return;
        }

        public function get bButtonPressed():Boolean
        {
            return this._bButtonPressed;
        }

        public function set bButtonPressed(arg1:Boolean):*
        {
            if (this._bButtonPressed != arg1) 
            {
                this._bButtonPressed = arg1;
                SetIsDirty();
            }
            return;
        }

        public function get bMouseOver():Boolean
        {
            return this._bMouseOver;
        }

        public function set bMouseOver(arg1:Boolean):*
        {
            if (this._bMouseOver != arg1) 
            {
                this._bMouseOver = arg1;
                SetIsDirty();
            }
            return;
        }

        internal function onMouseOver(arg1:flash.events.MouseEvent):*
        {
            this.bMouseOver = true;
            return;
        }

        protected function onMouseOut(arg1:flash.events.MouseEvent):*
        {
            this.bMouseOver = false;
            return;
        }

        internal static const DISABLED_GREY_OUT_ALPHA:Number=0.5;

        public static const JUSTIFY_RIGHT:uint=0;

        public static const JUSTIFY_LEFT:uint=1;

        internal static const DYNAMIC_MOVIE_CLIP_BUFFER:int=3;

        internal static const NameToTextMap:Object={"Xenon_A":"A", "Xenon_B":"B", "Xenon_X":"C", "Xenon_Y":"D", "Xenon_Select":"E", "Xenon_LS":"F", "Xenon_L1":"G", "Xenon_L3":"H", "Xenon_L2":"I", "Xenon_L2R2":"J", "Xenon_RS":"K", "Xenon_R1":"L", "Xenon_R3":"M", "Xenon_R2":"N", "Xenon_Start":"O", "_Positive":"P", "_Negative":"Q", "_Question":"R", "_Neutral":"S", "Left":"T", "Right":"U", "Down":"V", "Up":"W", "Xenon_R2_Alt":"X", "Xenon_L2_Alt":"Y", "PSN_A":"a", "PSN_Y":"b", "PSN_X":"c", "PSN_B":"d", "PSN_Select":"z", "PSN_L3":"f", "PSN_L1":"g", "PSN_L1R1":"h", "PSN_LS":"i", "PSN_L2":"j", "PSN_L2R2":"k", "PSN_R3":"l", "PSN_R1":"m", "PSN_RS":"n", "PSN_R2":"o", "PSN_Start":"p", "_DPad_LR":"q", "_DPad_UD":"r", "_DPad_Left":"t", "_DPad_Right":"u", "_DPad_Down":"v", "_DPad_Up":"w", "PSN_R2_Alt":"x", "PSN_L2_Alt":"y"};

        public var textField_tf:flash.text.TextField;

        public var IconHolderInstance:flash.display.MovieClip;

        public var SecondaryIconHolderInstance:flash.display.MovieClip;

        internal var _hitArea:flash.display.Sprite;

        internal var DynamicMovieClip:flash.display.MovieClip;

        internal var _strCurrentDynamicMovieClipName:String;

        internal var _DyanmicMovieHeight:Number;

        internal var _DynamicMovieY:Number;

        internal var _buttonHintData:Shared.AS3.BSButtonHintData;

        internal var bButtonFlashing:Boolean;

        var _bButtonPressed:Boolean=false;

        var _bMouseOver:Boolean=false;
    }
}
