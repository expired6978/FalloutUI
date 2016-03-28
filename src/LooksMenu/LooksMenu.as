package 
{
    import Shared.*;
    import Shared.AS3.*;
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
	import flash.geom.*;
    import scaleform.gfx.*;
	import utils.Debug;
    
    public dynamic class LooksMenu extends Shared.IMenu
    {
		internal const AllModeInputMap:Object={"Done":0, "Accept":1, "Cancel":2, "XButton":3, "YButton":4, "LTrigger":5, "RTrigger":6, "LShoulder":7, "RShoulder":8, "Left":9, "Right":10, "Up":11, "Down":12};
        internal const StartModeInputMapKBM:Object={"Done":0, "F":1, "B":2, "Accept":3, "X":4, "KeyLeft":5, "KeyRight":6};
        internal const FaceHairModeInputMap:Object={"Done":0, "KeyDown":1, "Cancel":2, "T":3, "C":4};
        internal const BodyModeInputMap:Object={"Done":1, "Accept":1, "Cancel":2};
        internal const SculptModeInputMap:Object={"Done":1, "Accept":1, "Cancel":2, "KeyDown":9, "KeyUp":10, "KeyLeft":7, "KeyRight":8};
        internal const FeatureModeInputMap:Object={"Done":1, "Accept":1, "Cancel":2, "Space":3, "R":4, "KeyLeft":7, "KeyRight":8};
        internal const FeatureCategoryModeInputMap:Object={"Accept":1, "Cancel":2, "R":4};
        internal const InputMapA:Array=[this.StartModeInputMapController, this.FaceHairModeInputMap, this.BodyModeInputMap, this.SculptModeInputMap, this.FaceHairModeInputMap, this.FeatureModeInputMap, this.FeatureCategoryModeInputMap];
        internal const StartModeFunctionsReleased:Array=[ConfirmCloseMenu, FaceMode, BodyMode, ExtrasMode, ChangeSex, CharacterPresetLeft, CharacterPresetRight, PresetMode, undefined, undefined, undefined, undefined, undefined];
        internal const FaceModeFunctionsReleased:Array=[ConfirmCloseMenu, SculptMode, StartMode, TypeMode, ColorMode, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined];
        internal const BodyModeFunctionsReleased:Array=[undefined, AcceptChanges, CancelChanges, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined];
        internal const SculptModeFunctionsReleased:Array=[undefined, AcceptChanges, CancelChanges, undefined, undefined, undefined, undefined, SculptModeRotateLeft, SculptModeRotateRight, SculptModeShrink, SculptModeEnlarge, SculptModeOut, SculptModeIn];
        internal const HairModeFunctionsReleased:Array=[ConfirmCloseMenu, StyleMode, StartMode, TypeMode, ColorMode, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined];
        internal const FeatureModeFunctionsReleased:Array=[undefined, undefined, CancelChanges, FeaturesApply, undefined, undefined, undefined, FeatureModeLBumper, FeatureModeRBumper, undefined, undefined, undefined, undefined];
        internal const FeatureCategoryModeFunctionsReleased:Array=[undefined, undefined, StartMode, undefined, FeaturesClear, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined];
        internal const InputFunctionsA:Array=[StartModeFunctionsReleased, FaceModeFunctionsReleased, BodyModeFunctionsReleased, SculptModeFunctionsReleased, HairModeFunctionsReleased, FeatureModeFunctionsReleased, FeatureCategoryModeFunctionsReleased];
        internal const StartModeInputMapController:Object={"Done":0, "Accept":1, "B":2, "XButton":3, "YButton":4, "KeyLeft":5, "KeyRight":6};
        internal const FeatureIntensityStep:Number=0.01;
        internal const FeatureIntensityRampDurationCeiling:Number=3;
        internal const FeatureIntensityRampEffect:Number=0.09;
        internal const ColorChangeRateSlow:Number=0.5;
        internal const ColorChangeRateFast:Number=0.2;
        internal const ColorChangeRateIncreaseAt:Number=1;
        internal const SLIDER_STEP_SIZE:Number=0.1;
        internal const SLIDER_MIN:Number=-1;
        internal const SLIDER_MAX:Number=1;
        internal const X_AXIS:uint=0;
        internal const Y_AXIS:uint=1;
        internal const Z_AXIS:uint=2;
        internal const X_ROT_AXIS:uint=3;
        internal const Y_ROT_AXIS:uint=4;
        internal const Z_ROT_AXIS:uint=5;
        internal const X_SCALE_AXIS:uint=6;
        internal const Y_SCALE_AXIS:uint=7;
        internal const Z_SCALE_AXIS:uint=8;
        internal const LEFT_RIGHT:uint=0;
        internal const UP_DOWN:uint=1;
        internal const BUMPERS:uint=2;
        internal const DPADX:uint=3;
        internal const DPADY:uint=4;
        internal const HeadPartEyes:int=2;
        internal const HeadPartHair:int=3;
        internal const HeadPartFacialHair:int=4;
        internal const HeadPartTeeth:int=8;
        internal const HeadPartNone:Number=4294967295;
        internal const DISABLED_ALPHA:Number=0;
        internal const START_MODE:uint=0;
        internal const BANTER_EYES:uint=1;
        internal const FACE_MODE:uint=1;
        internal const BODY_MODE:uint=2;
        internal const SCULPT_MODE:uint=3;
        internal const HAIR_MODE:uint=4;
        internal const FEATURE_MODE:uint=5;
        internal const FEATURE_CATEGORY_MODE:uint=6;
		internal const PRESET_MODE:uint=7;
        internal const AST_HAIR:uint=0;
        internal const AST_HAIR_COLOR:uint=1;
        internal const AST_BEARD:uint=2;
        internal const AST_EYES:uint=3;
        internal const AST_EXTRAS:uint=4;
        internal const AST_COLOR:uint=5;
        internal const AST_MORPHS:uint=6;
        internal const AST_COUNT:uint=7;
        internal const UNDO_WEIGHT:uint=0;
        internal const UNDO_SCULPT:uint=1;
        internal const UNDO_HAIRCOLOR:uint=2;
        internal const UNDO_HAIRSTYLE:uint=3;
        internal const UNDO_BEARD:uint=4;
        internal const UNDO_EXTRAS:uint=5;
        internal const UNDO_COLOR:uint=6;
        internal const UNDO_MORPHS:uint=7;
        internal const BANTER_GENERAL:uint=0;
        internal const BANTER_NOSE:uint=2;
        internal const BANTER_MOUTH:uint=3;
        internal const BANTER_HAIR:uint=4;
        internal const BANTER_BEARD:uint=5;
        internal const EDIT_CHARGEN:uint=0;
        internal const EDIT_REMAKE_UNUSED:int=1;
        internal const EDIT_HAIRCUT:uint=2;
        internal const EDIT_BODYMOD:uint=3;
        protected var _buttonHintDataV:__AS3__.vec.Vector.<Shared.AS3.BSButtonHintData>;
		protected var buttonHint_StartMode_BodyPreset:Shared.AS3.BSButtonHintData;
		protected var buttonHint_StartMode_Preset:Shared.AS3.BSButtonHintData;
        protected var buttonHint_StartMode_Face:Shared.AS3.BSButtonHintData;
        protected var buttonHint_StartMode_Extras:Shared.AS3.BSButtonHintData;
        protected var buttonHint_StartMode_Sex:Shared.AS3.BSButtonHintData;
        protected var buttonHint_StartMode_Body:Shared.AS3.BSButtonHintData;
        internal var LastSelectedExtraGroup:uint=0;
        internal var CurrentExtraColor:uint=0;
        internal var CurrentExtraGroup:uint=4294967295;
        public var CurrentBoneID:uint=4294967295;
        public var FacialBoneRegions:Array;
        internal var FeatureListChangeLock:int=0;
        internal var LastColorChangeAt:Number=0;
        internal var _BumperJustPressed:Boolean=false;
        internal var _BumperDurationHeld:Number=0;
        internal var CurrentExtraNumColors:uint=0;
        internal var CurrentFeatureIntensity:Number=0;
        internal var AppliedMorphIndex:uint=0;
        internal var AppliedMorphIntensity:Number=0;
        internal var PreviousStageFocus:flash.display.InteractiveObject;
        public var FeaturePanel_mc:flash.display.MovieClip;
        public var uiCharacterPresetCount:*=0;
        public var LeftStickHelp_tf:*;
        public var FacePartLabel_tf:*;
        public var LoadingSpinner_mc:flash.display.MovieClip;
        public var ButtonHintBar_mc:flash.display.MovieClip;
        public var WeightTriangle_mc:flash.display.MovieClip;
        protected var buttonHint_StartMode_Done:Shared.AS3.BSButtonHintData;
        protected var buttonHint_FeatureCategoryMode_Back:Shared.AS3.BSButtonHintData;
        protected var buttonHint_FeatureCategoryMode_Select:Shared.AS3.BSButtonHintData;
        protected var buttonHint_FeatureCategoryMode_RemoveAll:Shared.AS3.BSButtonHintData;
        protected var buttonHint_EditCancel:Shared.AS3.BSButtonHintData;
        protected var buttonHint_FeatureMode_Apply:Shared.AS3.BSButtonHintData;
        protected var buttonHint_EditAccept:Shared.AS3.BSButtonHintData;
        protected var buttonHint_FeatureMode_Modifier:Shared.AS3.BSButtonHintData;
        internal var eMode:uint=0;
        internal var ControlAxes:Array;
        public var Cursor_mc:flash.display.MovieClip;
        internal var eFeature:uint=7;
        internal var _controlsEnabled:Boolean=true;
        internal var EditMode:uint=0;
        internal var AllowChangeSex:Boolean=false;
        internal var _loading:Boolean=false;
        internal var _dirty:Boolean=false;
        internal var _bconfirmClose:Boolean=false;
        internal var UndoDataSculptingTransform:Array;
        internal var _bisFemale:Boolean=false;
        internal var CurrentActor:uint=0;
        internal var bInitialized:Boolean=false;
        public var BGSCodeObj:Object;
        internal var BlockNextAccept:*=false;
        internal var LetFeatureListHandleClick:*=true;
        protected var buttonHint_SculptMode_Scale:Shared.AS3.BSButtonHintData;
        protected var buttonHint_SculptMode_Rotate:Shared.AS3.BSButtonHintData;
        protected var buttonHint_SculptMode_Slide:Shared.AS3.BSButtonHintData;
        internal var TriangleSize:Number=200;
        protected var buttonHint_SculptMode_Move:Shared.AS3.BSButtonHintData;
        protected var buttonHint_FaceMode_Back:Shared.AS3.BSButtonHintData;
        protected var buttonHint_FaceMode_Color:Shared.AS3.BSButtonHintData;
        protected var buttonHint_FaceMode_Type:Shared.AS3.BSButtonHintData;
        protected var buttonHint_HairMode_Style:Shared.AS3.BSButtonHintData;
        protected var buttonHint_FaceMode_Sculpt:Shared.AS3.BSButtonHintData;
        internal var CurrentSelectedExtra:uint=0;
		
		public static var GlobalTintColors:Array=[1.0, 0.0, 1.0, 1.0];
		
        public function LooksMenu()
        {
			this.buttonHint_StartMode_BodyPreset = new Shared.AS3.BSButtonHintData("$PRESET", "F5", "PSN_L3", "Xenon_L3", 1, this.PresetMode);
            this.buttonHint_StartMode_Face = new Shared.AS3.BSButtonHintData("$FACE", "F", "PSN_A", "Xenon_A", 1, this.FaceMode);
            this.buttonHint_StartMode_Extras = new Shared.AS3.BSButtonHintData("$EXTRAS", "E", "PSN_X", "Xenon_X", 1, this.ExtrasMode);
            this.buttonHint_StartMode_Sex = new Shared.AS3.BSButtonHintData("$SEX", "X", "PSN_Y", "Xenon_Y", 1, this.ChangeSex);
            this.buttonHint_StartMode_Body = new Shared.AS3.BSButtonHintData("$BODY", "B", "PSN_B", "Xenon_B", 1, this.BodyMode);
            this.buttonHint_StartMode_Preset = new Shared.AS3.BSButtonHintData("$$FACE 01", "A", "PSN_L2", "Xenon_L2", 1, this.CharacterPresetRight);
            this.buttonHint_FaceMode_Sculpt = new Shared.AS3.BSButtonHintData("$SCULPT", "S", "PSN_A", "Xenon_A", 1, this.SculptMode);
            this.buttonHint_HairMode_Style = new Shared.AS3.BSButtonHintData("$STYLE", "S", "PSN_A", "Xenon_A", 1, this.StyleMode);
            this.buttonHint_FaceMode_Type = new Shared.AS3.BSButtonHintData("$TYPE", "T", "PSN_X", "Xenon_X", 1, this.TypeMode);
            this.buttonHint_FaceMode_Color = new Shared.AS3.BSButtonHintData("$COLOR", "C", "PSN_Y", "Xenon_Y", 1, this.ColorMode);
            this.buttonHint_FaceMode_Back = new Shared.AS3.BSButtonHintData("$BACK", "Esc", "PSN_B", "Xenon_B", 1, this.StartMode);
            this.buttonHint_SculptMode_Move = new Shared.AS3.BSButtonHintData("$MOVE", "LMOUSE", "PSN_LS", "Xenon_LS", 1, null);
            this.buttonHint_SculptMode_Slide = new Shared.AS3.BSButtonHintData("$SLIDE", "MOUSEWHEEL", "_DPad_UD", "_DPad_UD", 1, null);
            this.buttonHint_SculptMode_Rotate = new Shared.AS3.BSButtonHintData("$ROTATE", "A", "PSN_L1", "Xenon_L1", 1, this.SculptModeRotateLeft);
            this.buttonHint_SculptMode_Scale = new Shared.AS3.BSButtonHintData("$SCALE", "S", "_DPad_LR", "_DPad_LR", 1, this.SculptModeShrink);
            this.buttonHint_FeatureMode_Modifier = new Shared.AS3.BSButtonHintData("100%", "A", "PSN_L1", "Xenon_L1", 1, this.FeatureModeLBumper);
            this.buttonHint_EditAccept = new Shared.AS3.BSButtonHintData("$ACCEPT", "E", "PSN_A", "Xenon_A", 1, this.AcceptChanges);
            this.buttonHint_FeatureMode_Apply = new Shared.AS3.BSButtonHintData("$APPLY", "SPACE", "PSN_X", "Xenon_X", 1, this.FeaturesApply);
            this.buttonHint_EditCancel = new Shared.AS3.BSButtonHintData("$CANCEL", "Esc", "PSN_B", "Xenon_B", 1, this.CancelChanges);
            this.buttonHint_FeatureCategoryMode_RemoveAll = new Shared.AS3.BSButtonHintData("$REMOVE ALL", "R", "PSN_Y", "Xenon_Y", 1, this.FeaturesClear);
            this.buttonHint_FeatureCategoryMode_Select = new Shared.AS3.BSButtonHintData("$SELECT", "E", "PSN_A", "Xenon_A", 1, this.SelectCategory);
            this.buttonHint_FeatureCategoryMode_Back = new Shared.AS3.BSButtonHintData("$BACK", "Esc", "PSN_B", "Xenon_B", 1, this.PreviousMode);
            this.buttonHint_StartMode_Done = new Shared.AS3.BSButtonHintData("$DONE", "Enter", "PSN_Start", "Xenon_Start", 1, this.ConfirmCloseMenu);
            this.FacialBoneRegions = new Array();
            this.ControlAxes = [this.X_AXIS, this.Y_AXIS, this.X_ROT_AXIS, this.X_SCALE_AXIS, this.Z_AXIS];
            super();
            this.BGSCodeObj = new Object();
            this.eMode = this.START_MODE;
            scaleform.gfx.Extensions.enabled = true;
            stage.focus = this;
            stage.stageFocusRect = false;
            addEventListener(flash.events.KeyboardEvent.KEY_DOWN, onKeyDown);
            addEventListener(Shared.AS3.BSScrollingList.SELECTION_CHANGE, onFeatureSelectionChange);
            addEventListener(Shared.AS3.BSScrollingList.ITEM_PRESS, onFeatureSelected);
            this.WeightTriangle_mc.WeightTriangleHitArea_mc.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, onWeightTriangleChange);
            this.WeightTriangle_mc.WeightTriangleHitArea_mc.addEventListener(flash.events.MouseEvent.MOUSE_MOVE, onWeightTriangleChange);
            this.buttonHint_StartMode_Preset.SetSecondaryButtons("D", "PSN_R2", "Xenon_R2");
            this.buttonHint_StartMode_Preset.secondaryButtonCallback = this.CharacterPresetRight;
            this.buttonHint_SculptMode_Slide.DynamicMovieClipName = "SlideIcon";
            this.buttonHint_SculptMode_Rotate.SetSecondaryButtons("D", "PSN_R1", "Xenon_R1");
            this.buttonHint_SculptMode_Rotate.secondaryButtonCallback = this.SculptModeRotateRight;
            this.buttonHint_SculptMode_Rotate.DynamicMovieClipName = "RotationIcon";
            this.buttonHint_SculptMode_Scale.SetSecondaryButtons("W", "", "");
            this.buttonHint_SculptMode_Scale.secondaryButtonCallback = this.SculptModeEnlarge;
            this.buttonHint_FeatureMode_Modifier.SetSecondaryButtons("D", "PSN_R1", "Xenon_R1");
            this.buttonHint_FeatureMode_Modifier.secondaryButtonCallback = this.FeatureModeLBumper;
            this._buttonHintDataV = new Vector.<Shared.AS3.BSButtonHintData>();
			this._buttonHintDataV.push(this.buttonHint_StartMode_BodyPreset);
            this._buttonHintDataV.push(this.buttonHint_StartMode_Preset);
            this._buttonHintDataV.push(this.buttonHint_StartMode_Face);
            this._buttonHintDataV.push(this.buttonHint_StartMode_Extras);
            this._buttonHintDataV.push(this.buttonHint_StartMode_Sex);
            this._buttonHintDataV.push(this.buttonHint_StartMode_Body);
            this._buttonHintDataV.push(this.buttonHint_FaceMode_Sculpt);
            this._buttonHintDataV.push(this.buttonHint_HairMode_Style);
            this._buttonHintDataV.push(this.buttonHint_FaceMode_Type);
            this._buttonHintDataV.push(this.buttonHint_FaceMode_Color);
            this._buttonHintDataV.push(this.buttonHint_FaceMode_Back);
            this._buttonHintDataV.push(this.buttonHint_SculptMode_Move);
            this._buttonHintDataV.push(this.buttonHint_SculptMode_Slide);
            this._buttonHintDataV.push(this.buttonHint_SculptMode_Rotate);
            this._buttonHintDataV.push(this.buttonHint_SculptMode_Scale);
            this._buttonHintDataV.push(this.buttonHint_FeatureMode_Modifier);
            this._buttonHintDataV.push(this.buttonHint_EditAccept);
            this._buttonHintDataV.push(this.buttonHint_FeatureMode_Apply);
            this._buttonHintDataV.push(this.buttonHint_EditCancel);
            this._buttonHintDataV.push(this.buttonHint_StartMode_Done);
            this._buttonHintDataV.push(this.buttonHint_FeatureCategoryMode_Select);
            this._buttonHintDataV.push(this.buttonHint_FeatureCategoryMode_RemoveAll);
            this._buttonHintDataV.push(this.buttonHint_FeatureCategoryMode_Back);
            this.ButtonHintBar_mc.SetButtonHintData(this._buttonHintDataV);
            this.UpdateButtons();
            this.bInitialized = true;
            this.__setProp_ButtonHintBar_mc_LooksMenuBase_Shared_0();
			trace("Loaded LooksMenu");
			root.addEventListener("F4SE::Initialized", onF4SEInitialized);
        }
				
		override protected function onStageInit(event:flash.events.Event)
        {
			super.onStageInit(event);
            /*trace("Stage inited");
			_controlsEnabled = true;
			_bisFemale = true;
			SetPlatform(0, false);
			this.BGSCodeObj = new Object();
			this.BGSCodeObj["StartBodyEdit"] = function() { }
			this.BGSCodeObj["WeightPointChange"] = function(x: Number, y: Number) { SetWeightPoint(x,y); }
			this.eMode = this.BODY_MODE;
			//utils.Debug.dump("LooksMenu", this, false, 0, function(a_obj){ return ["BGSCodeObj"]; } );
			try
			{
				UpdateButtons();
			}
			catch(e:Error)
			{
				
			}
			onApplyColorChange(1.0, 0, 0, 1.0);*/
        }
		
		public function onApplyColorChange(r, g, b, multiplier): Array
		{
			var rint:uint = r * 255;
			var gint:uint = g * 255;
			var bint:uint = b * 255;
			var mint:uint = multiplier * 255;
			try 
            {
				WeightTriangle_mc.CurrentWeightTick_mc.transform.colorTransform = new ColorTransform(0.0, 0.0, 0.0, 1.0, rint, gint, bint, mint);
				WeightTriangle_mc.Triangle_mc.transform.colorTransform = new ColorTransform(0.0, 0.0, 0.0, 1.0, rint, gint, bint, mint);
                LoadingSpinner_mc.transform.colorTransform = new ColorTransform(0.0, 0.0, 0.0, 1.0, rint, gint, bint, 0);
       			ButtonHintBar_mc.ButtonBracket_Left_mc.transform.colorTransform = new ColorTransform(0.0, 0.0, 0.0, 1.0, rint, gint, bint, mint);
				ButtonHintBar_mc.ButtonBracket_Right_mc.transform.colorTransform = new ColorTransform(0.0, 0.0, 0.0, 1.0, rint, gint, bint, mint);
				
				var textColor: uint = (mint << 24) | (rint << 16) | (gint << 8) | bint;
				FacePartLabel_tf.textColor = textColor;
				WeightTriangle_mc.Large_tf.textColor = textColor;
				WeightTriangle_mc.Thin_tf.textColor = textColor;
				WeightTriangle_mc.Muscular_tf.textColor = textColor;
				
				trace(ButtonHintBar_mc.ButtonPoolV.length);
				for(var i = 0; i < ButtonHintBar_mc.ButtonPoolV.length; i++)
				{
					trace(ButtonHintBar_mc.ButtonPoolV[i]);
					trace(ButtonHintBar_mc.ButtonPoolV[i].textField_tf);
					trace(ButtonHintBar_mc.ButtonPoolV[i].IconHolderInstance.IconAnimInstance.Icon_tf);
					trace(ButtonHintBar_mc.ButtonPoolV[i].SecondaryIconHolderInstance.IconAnimInstance.Icon_tf);
					ButtonHintBar_mc.ButtonPoolV[i].textField_tf.textColor = textColor;
            		ButtonHintBar_mc.ButtonPoolV[i].IconHolderInstance.IconAnimInstance.Icon_tf.textColor = textColor;
            		ButtonHintBar_mc.ButtonPoolV[i].SecondaryIconHolderInstance.IconAnimInstance.Icon_tf.textColor = textColor;
				}
            }
            catch (e:Error)
            {

            };

			return [1.0, 1.0, 1.0, 1.0];
		}
		
		public function onF4SEInitialized(event:flash.events.Event)
		{
			trace("F4SE Initialized.");
			try 
            {
				utils.Debug.dump("LooksMenu", this.FeaturePanel_mc, false, 0, root.f4se.GetMembers);
			}
			catch(e:Error)
			{
				trace("Failed to dump");
			};
		}

        public function set isFemale(arg1:*):*
        {
            this._bisFemale = arg1;
        }

        public function set enableControls(arg1:Boolean):*
        {
            this._controlsEnabled = arg1;
        }

        public function set loading(arg1:Boolean):*
        {
            if (this._loading != arg1) 
            {
                this._loading = arg1;
                this.UpdateButtons();
            }
        }

        public function CharacterPresetStepperGetDispInfo(arg1:Object, arg2:uint):*
        {
            arg1.DisplayLabel = "$FACE";
            arg1.DisplayIndex = arg2 + 1;
        }

        public function DetailColorStepperGetDispInfo(arg1:Object, arg2:uint):*
        {
            arg1.DisplayLabel = "$COLOR";
            arg1.DisplayIndex = arg2 + 1;
        }

        public function UpdateButtons():*
        {
            var loc3:*=undefined;
            var loc4:*=undefined;
            var loc1:*=this.GetBoneRegionIndexFromCurrentID();
            var loc2:*=this.eMode == this.SCULPT_MODE || this.eMode == this.FEATURE_MODE;
			this.buttonHint_StartMode_BodyPreset.ButtonVisible = this.bInitialized && this.eMode == this.START_MODE && this.EditMode == this.EDIT_CHARGEN;
            this.buttonHint_StartMode_Preset.ButtonVisible = this.bInitialized && this.eMode == this.START_MODE && this.EditMode == this.EDIT_CHARGEN;
            this.buttonHint_StartMode_Face.ButtonVisible = this.bInitialized && this.eMode == this.START_MODE && (this.EditMode == this.EDIT_CHARGEN || this.EditMode == this.EDIT_BODYMOD);
            this.buttonHint_StartMode_Extras.ButtonVisible = this.bInitialized && this.eMode == this.START_MODE && (this.EditMode == this.EDIT_CHARGEN || this.EditMode == this.EDIT_BODYMOD);
            this.buttonHint_StartMode_Sex.ButtonVisible = this.bInitialized && this.eMode == this.START_MODE && this.EditMode == this.EDIT_CHARGEN && this.AllowChangeSex;
            this.buttonHint_StartMode_Body.ButtonVisible = this.bInitialized && this.eMode == this.START_MODE && (this.EditMode == this.EDIT_CHARGEN || this.EditMode == this.EDIT_BODYMOD);
            this.buttonHint_StartMode_Done.ButtonVisible = this.bInitialized && (this.eMode == this.START_MODE || this.eMode == this.HAIR_MODE && this.EditMode == this.EDIT_HAIRCUT);
            this.buttonHint_FaceMode_Sculpt.ButtonVisible = this.eMode == this.FACE_MODE && (this.EditMode == this.EDIT_CHARGEN || this.EditMode == this.EDIT_BODYMOD);
            this.buttonHint_HairMode_Style.ButtonVisible = this.eMode == this.HAIR_MODE && (this.EditMode == this.EDIT_CHARGEN || this.EditMode == this.EDIT_HAIRCUT);
            this.buttonHint_FaceMode_Type.ButtonVisible = this.eMode == this.FACE_MODE && (this.EditMode == this.EDIT_CHARGEN || this.EditMode == this.EDIT_BODYMOD) || this.eMode == this.HAIR_MODE && this.EditMode == this.EDIT_HAIRCUT && !this._bisFemale;
            this.buttonHint_FaceMode_Color.ButtonVisible = this.eMode == this.FACE_MODE && (this.EditMode == this.EDIT_CHARGEN || this.EditMode == this.EDIT_BODYMOD) || this.eMode == this.HAIR_MODE && (this.EditMode == this.EDIT_CHARGEN || this.EditMode == this.EDIT_HAIRCUT);
            this.buttonHint_FaceMode_Back.ButtonVisible = (this.EditMode == this.EDIT_CHARGEN || this.EditMode == this.EDIT_BODYMOD) && (this.eMode == this.FACE_MODE || this.eMode == this.HAIR_MODE);
            this.buttonHint_EditAccept.ButtonVisible = this.eMode == this.SCULPT_MODE || this.eMode == this.FEATURE_MODE || this.eMode == this.BODY_MODE;
            this.buttonHint_EditCancel.ButtonVisible = this.eMode == this.SCULPT_MODE || this.eMode == this.FEATURE_MODE || this.eMode == this.BODY_MODE;
            this.buttonHint_SculptMode_Move.ButtonVisible = this.eMode == this.SCULPT_MODE && (this.GetValidAxis(this.X_AXIS) || this.GetValidAxis(this.Y_AXIS));
            this.buttonHint_SculptMode_Slide.ButtonVisible = this.eMode == this.SCULPT_MODE && this.GetValidAxis(this.Z_AXIS);
            this.buttonHint_SculptMode_Rotate.ButtonVisible = this.eMode == this.SCULPT_MODE && this.GetValidAxis(this.X_ROT_AXIS);
            this.buttonHint_SculptMode_Scale.ButtonVisible = this.eMode == this.SCULPT_MODE && this.GetValidAxis(this.X_SCALE_AXIS);
            this.buttonHint_FeatureMode_Modifier.ButtonVisible = this.eMode == this.FEATURE_MODE && this.CurrentFeatureIntensity > 0 && !(this.CurrentExtraNumColors == 1);
            this.buttonHint_FeatureMode_Apply.ButtonVisible = this.eMode == this.FEATURE_MODE && this.eFeature == this.AST_EXTRAS;
            this.buttonHint_FeatureCategoryMode_RemoveAll.ButtonVisible = this.eMode == this.FEATURE_CATEGORY_MODE;
            this.buttonHint_FeatureCategoryMode_Select.ButtonVisible = this.eMode == this.FEATURE_CATEGORY_MODE;
            this.buttonHint_FeatureCategoryMode_Back.ButtonVisible = this.eMode == this.FEATURE_CATEGORY_MODE;
            this.Cursor_mc.visible = !this._loading && !(this.EditMode == this.EDIT_HAIRCUT) && (this.eMode == this.FACE_MODE || this.eMode == this.HAIR_MODE);
            this.LoadingSpinner_mc.alpha = this._loading ? 1 : 0;
            this.FacePartLabel_tf.alpha = !(this.EditMode == this.EDIT_HAIRCUT) && !(this.eMode == this.START_MODE) && !(this.eMode == this.BODY_MODE) && !(this.eMode == this.FEATURE_CATEGORY_MODE) && (!(this.eMode == this.FEATURE_MODE) || !(this.eFeature == this.AST_EXTRAS));
            this.WeightTriangle_mc.alpha = this.eMode != this.BODY_MODE ? 0 : 1;
            this.FeaturePanel_mc.visible = this.eMode == this.FEATURE_MODE || this.eMode == this.FEATURE_CATEGORY_MODE;
            this.FeaturePanel_mc.Brackets_mc.BracketExtents_mc.visible = this.eMode == this.FEATURE_MODE || this.eMode == this.FEATURE_CATEGORY_MODE;
            var loc5:*=this.eMode;
            switch (loc5) 
            {
                case this.START_MODE:
                {
                    loc3 = this.bInitialized ? this.BGSCodeObj.GetLastCharacterPreset() : 0;
                    this.buttonHint_StartMode_Preset.ButtonText = "$$FACE " + (loc3 < 9 ? "0" : "") + (loc3 + 1).toString();
                    break;
                }
                case this.FACE_MODE:
                {
                    this.eFeature = this.AST_COUNT;
					loc4 = this.CurrentBoneID;
                    if (loc4 < uint.MAX_VALUE) 
                    {
                        if (this.FacialBoneRegions[this.CurrentActor][loc1].headPart != this.HeadPartFacialHair) 
                        {
                            if (this.EditMode == this.EDIT_CHARGEN || this.EditMode == this.EDIT_BODYMOD) 
                            {
                                if (this.FacialBoneRegions[this.CurrentActor][loc1].associatedPresetGroup == null) 
                                {
                                    this.buttonHint_FaceMode_Type.ButtonEnabled = false;
                                }
                                else 
                                {
                                    this.buttonHint_FaceMode_Type.ButtonText = "$TYPE";
                                    this.buttonHint_FaceMode_Type.ButtonEnabled = true;
                                }
                                this.buttonHint_FaceMode_Type.ButtonVisible = true;
                            }
                            else 
                            {
                                this.buttonHint_FaceMode_Type.ButtonVisible = false;
                            }
                        }
                        else if (this.EditMode != this.EDIT_CHARGEN) 
                        {
                            this.buttonHint_FaceMode_Type.ButtonVisible = false;
                        }
                        else 
                        {
                            this.buttonHint_FaceMode_Type.ButtonText = "$FACIAL HAIR";
                            this.buttonHint_FaceMode_Type.ButtonEnabled = true;
                            this.buttonHint_FaceMode_Type.ButtonVisible = true;
                        }
                    }
                    else if (this.EditMode == this.EDIT_CHARGEN || this.EditMode == this.EDIT_BODYMOD) 
                    {
                        this.buttonHint_FaceMode_Type.ButtonText = "$TYPE";
                        this.buttonHint_FaceMode_Type.ButtonEnabled = false;
                        this.buttonHint_FaceMode_Type.ButtonVisible = true;
                    }
                    else 
                    {
                        this.buttonHint_FaceMode_Type.ButtonVisible = false;
                    }
                    if (this.EditMode == this.EDIT_CHARGEN || this.EditMode == this.EDIT_BODYMOD) 
                    {
                        this.buttonHint_FaceMode_Color.ButtonEnabled = loc5 = loc4;
                        this.buttonHint_FaceMode_Sculpt.ButtonEnabled = loc5;
                    }
                    else 
                    {
                        this.buttonHint_FaceMode_Sculpt.ButtonVisible = false;
                    }
                    this.FacePartLabel_tf.visible = this.buttonHint_FaceMode_Type.ButtonEnabled && this.buttonHint_FaceMode_Type.ButtonVisible || this.buttonHint_FaceMode_Sculpt.ButtonEnabled && this.buttonHint_FaceMode_Sculpt.ButtonVisible || this.buttonHint_FaceMode_Color.ButtonEnabled && this.buttonHint_FaceMode_Color.ButtonVisible;
                    this.FacePartLabel_tf.alpha = this.CurrentBoneID < uint.MAX_VALUE ? 1 : 0;
                    if (this.CurrentBoneID < uint.MAX_VALUE) 
                    {
                        Shared.GlobalFunc.SetText(this.FacePartLabel_tf, this.FacialBoneRegions[this.CurrentActor][loc1].name, false, true);
                    }
                    break;
                }
                case this.HAIR_MODE:
                {
                    this.eFeature = this.AST_HAIR;
                    if (this.EditMode == this.EDIT_HAIRCUT) 
                    {
                        this.buttonHint_FaceMode_Type.ButtonText = "$FACIAL HAIR";
                        this.buttonHint_FaceMode_Type.ButtonEnabled = true;
                    }
                    this.buttonHint_HairMode_Style.ButtonEnabled = true;
                    this.buttonHint_FaceMode_Color.ButtonEnabled = true;
                    this.FacePartLabel_tf.visible = true;
                    this.FacePartLabel_tf.alpha = this.EditMode == this.EDIT_CHARGEN || this.EditMode == this.EDIT_HAIRCUT ? 1 : 0;
                    Shared.GlobalFunc.SetText(this.FacePartLabel_tf, "$HAIR", false, true);
                    break;
                }
                case this.BODY_MODE:
                {
                    break;
                }
                case this.SCULPT_MODE:
                {
                    Shared.GlobalFunc.SetText(this.FacePartLabel_tf, this.FacialBoneRegions[this.CurrentActor][loc1].name, false, true);
                    break;
                }
                case this.FEATURE_CATEGORY_MODE:
                {
                    this.buttonHint_FeatureCategoryMode_RemoveAll.ButtonEnabled = this.BGSCodeObj.GetHasDetailsApplied();
                    break;
                }
                case this.FEATURE_MODE:
                {
                    if (this.eFeature == this.AST_BEARD) 
                    {
                        Shared.GlobalFunc.SetText(this.FacePartLabel_tf, "$FACIAL HAIR", false, true);
                    }
                    break;
                }
            }
            if (this.bInitialized) 
            {
                this.BGSCodeObj.SetSculptMode(this.eMode == this.SCULPT_MODE);
                this.BGSCodeObj.SetFeatureMode(this.eMode == this.FEATURE_MODE);
                this.BGSCodeObj.SetBumpersRepeat(loc2);
            }
        }

        public function set currentBoneRegionID(arg1:uint):*
        {
            this.CurrentBoneID = arg1;
            this.UpdateButtons();
        }

        public function get menuMode():uint
        {
            return this.eMode;
        }

        public function set menuMode(arg1:uint):*
        {
            this.eMode = arg1 < uint.MAX_VALUE ? arg1 : this.START_MODE;
            if (this.EditMode != this.EDIT_HAIRCUT) 
            {
                if (arg1 != this.HAIR_MODE) 
                {
                    if (arg1 == this.FACE_MODE) 
                    {
                        this.ShowHairHighlight(false);
                    }
                }
                else 
                {
                    this.ShowHairHighlight(true);
                }
            }
            this.UpdateButtons();
        }

        public function SetCursorPosition(arg1:Number, arg2:Number):*
        {
            this.Cursor_mc.x = arg1 * 1280;
            this.Cursor_mc.y = arg2 * 720;
            this.LoadingSpinner_mc.x = this.Cursor_mc.x;
            this.LoadingSpinner_mc.y = this.Cursor_mc.y;
        }

        internal function onWeightTriangleChange(event:flash.events.MouseEvent):void
        {
            var x:*=NaN;
            var y:*=NaN;
            if (event.buttonDown && this.eMode == this.BODY_MODE) 
            {
                x = Shared.GlobalFunc.Lerp(0, 1, 0, this.TriangleSize, event.localX, true);
                y = Shared.GlobalFunc.Lerp(0, 1, 0, this.TriangleSize, event.localY, true);
                this.BGSCodeObj.WeightPointChange(x, y);
            }
        }

        public function SetWeightPoint(x:Number, y:Number):*
        {
            this.WeightTriangle_mc.CurrentWeightTick_mc.x = Shared.GlobalFunc.Lerp(0, this.TriangleSize, 0, 1, x, true);
            this.WeightTriangle_mc.CurrentWeightTick_mc.y = Shared.GlobalFunc.Lerp(0, this.TriangleSize, 0, 1, y, true);
        }

        public function ProcessUserEvent(control:String, arg2:Boolean):Boolean
        {
            var handled: Boolean = false;
            if (!(eMode == START_MODE) || !(control == "Cancel") || !(uiPlatform == Shared.PlatformChangeEvent.PLATFORM_PC_KB_MOUSE)) 
            {
				var controlId:* = getInput(control);
                if (!arg2 && !confirmClose && !(InputFunctionsA[eMode][controlId] == null)) 
                {
                    InputFunctionsA[eMode][controlId]();
                    if (!(control == "Up") && !(control == "Down") && !(control == "Left") && !(control == "Right")) 
                    {
                        handled = true;
                    }
                    if (control == "Accept") 
                    {
                        if (eMode == this.FEATURE_MODE || eMode == this.FEATURE_CATEGORY_MODE) 
                        {
                            BlockNextAccept = true;
                        }
                    }
                }
            }
            return handled;
        }

        public function onKeyDown(event:flash.events.KeyboardEvent):*
        {
			var input = getInput(event.keyCode);
            if (visible && !confirmClose && !(InputFunctionsA[eMode][input] == null)) 
            {
                InputFunctionsA[eMode][input]();
            }
        }

        internal function getInput(keyCode: String):*
        {
            var result = null;
            if (_controlsEnabled) {
                if (eMode == START_MODE && uiPlatform == Shared.PlatformChangeEvent.PLATFORM_PC_KB_MOUSE) {
                    result = StartModeInputMapKBM[keyCode];
                } else {
                    result = InputMapA[eMode][keyCode];
                }
				if (!result) {
                    result = AllModeInputMap[keyCode];
                }
            }
			
            return result;
        }

        internal function UpdateFeatureModifierButtonHint():*
        {
            var loc1:*=NaN;
            if (this.CurrentExtraGroup < uint.MAX_VALUE && this.CurrentSelectedExtra < uint.MAX_VALUE) 
            {
                var loc2:*=this.CurrentExtraNumColors;
                switch (loc2) 
                {
                    case 0:
                    {
                        this.buttonHint_FeatureMode_Modifier.ButtonVisible = this.CurrentFeatureIntensity > 0;
                        if (this.CurrentFeatureIntensity > 0) 
                        {
                            this.buttonHint_FeatureMode_Modifier.ButtonText = uint(this.CurrentFeatureIntensity * 100).toString() + "%";
                        }
                        this.buttonHint_FeatureMode_Modifier.ButtonEnabled = this.CurrentFeatureIntensity > 0;
                        this.buttonHint_FeatureMode_Modifier.SecondaryButtonEnabled = this.CurrentFeatureIntensity < 1;
                        break;
                    }
                    case 1:
                    {
                        this.buttonHint_FeatureMode_Modifier.ButtonVisible = false;
                        break;
                    }
                    default:
                    {
                        this.buttonHint_FeatureMode_Modifier.ButtonVisible = true;
                        this.buttonHint_FeatureMode_Modifier.ButtonEnabled = this.CurrentExtraColor > 0;
                        this.buttonHint_FeatureMode_Modifier.SecondaryButtonEnabled = this.CurrentExtraColor < (this.CurrentExtraNumColors - 1);
                        this.buttonHint_FeatureMode_Modifier.ButtonText = "$$COLOR " + (this.CurrentExtraColor < 9 ? "0" : "") + (this.CurrentExtraColor + 1).toString();
                        break;
                    }
                }
                loc1 = this.BGSCodeObj.GetDetailIntensity(this.CurrentExtraGroup, this.CurrentSelectedExtra);
                this.buttonHint_FeatureMode_Apply.ButtonText = loc1 > 0 ? "$REMOVE" : "$APPLY";
            }
            else if (this.eFeature != this.AST_MORPHS) 
            {
                this.buttonHint_FeatureMode_Modifier.ButtonVisible = false;
            }
            else 
            {
                this.buttonHint_FeatureMode_Modifier.ButtonVisible = this.CurrentFeatureIntensity > 0;
                if (this.CurrentFeatureIntensity > 0) 
                {
                    this.buttonHint_FeatureMode_Modifier.ButtonText = uint(this.CurrentFeatureIntensity * 100).toString() + "%";
                }
            }
        }

        internal function FeatureMode(a_feature:uint):*
        {
            eMode = FEATURE_MODE;
            eFeature = a_feature;
            UpdateButtons();
            BGSCodeObj.ClearBoneRegionTint();
            var panelTitle = "$TYPE";
            var groupIndex:uint = eFeature != AST_EXTRAS ? CurrentBoneID : CurrentExtraGroup;
            var featureData:uint = BGSCodeObj.GetFeatureData(FeaturePanel_mc.List_mc.entryList, eFeature, groupIndex);
            FeatureListChangeLock++;
            FeaturePanel_mc.List_mc.InvalidateData();
            var boneIndex = GetBoneRegionIndexFromCurrentID();
            switch (eFeature) 
            {
                case AST_HAIR:
                {
                    ShowHairHighlight(false);
                    BGSCodeObj.CreateUndoPoint(UNDO_HAIRSTYLE);
                    panelTitle = "$STYLE";
                    UpdateFeatureModifierButtonHint();
                    break;
                }
                case AST_HAIR_COLOR:
                {
                    ShowHairHighlight(false);
                    BGSCodeObj.CreateUndoPoint(UNDO_HAIRCOLOR);
                    panelTitle = "$COLOR";
                    UpdateFeatureModifierButtonHint();
                    break;
                }
                case AST_BEARD:
                {
                    BGSCodeObj.CreateUndoPoint(UNDO_BEARD);
                    UpdateFeatureModifierButtonHint();
                    break;
                }
                case AST_COLOR:
                {
                    var region = FacialBoneRegions[CurrentActor][boneIndex].headPart;
                    Shared.GlobalFunc.SetText(FacePartLabel_tf, region != HeadPartEyes ? "$SKIN TONE" : "$EYE COLOR", false);
                    BGSCodeObj.CreateUndoPoint(UNDO_COLOR, CurrentBoneID);
                    panelTitle = "$COLOR";
                    UpdateFeatureModifierButtonHint();
                    break;
                }
                case AST_EYES:
                {
                    Shared.GlobalFunc.SetText(FacePartLabel_tf, "$EYE COLOR", false);
                    BGSCodeObj.CreateUndoPoint(UNDO_COLOR, CurrentBoneID);
                    panelTitle = "$COLOR";
                    UpdateFeatureModifierButtonHint();
                    break;
                }
                case AST_EXTRAS:
                {
                    panelTitle = BGSCodeObj.GetExtraGroupName(CurrentExtraGroup);
                    BGSCodeObj.CreateUndoPoint(UNDO_EXTRAS);
                    if (CurrentExtraGroup < uint.MAX_VALUE) 
                    {
                        if (featureData == uint.MAX_VALUE) 
                        {
                            featureData = 0;
                        }
                        CurrentSelectedExtra = featureData;
                        if (!BGSCodeObj.GetDetailIntensity(CurrentExtraGroup, CurrentSelectedExtra)) 
                        {
                            BGSCodeObj.SetDetailIntensity(CurrentExtraGroup, CurrentSelectedExtra, Number(1), true);
                            CurrentFeatureIntensity = 1;
                        }
                        CurrentExtraNumColors = BGSCodeObj.GetDetailColorCount(CurrentExtraGroup, CurrentSelectedExtra);
                        CurrentExtraColor = BGSCodeObj.GetDetailColor(CurrentExtraGroup, CurrentSelectedExtra);
                        UpdateFeatureModifierButtonHint();
                    }
                    break;
                }
                case AST_MORPHS:
                {
                    BGSCodeObj.CreateUndoPoint(UNDO_MORPHS);
                    CurrentFeatureIntensity = FacialBoneRegions[CurrentActor][boneIndex].presetIntensity;
                    AppliedMorphIndex = featureData;
                    AppliedMorphIntensity = CurrentFeatureIntensity;
                    UpdateFeatureModifierButtonHint();
                    break;
                }
            }
            FeaturePanel_mc.List_mc.InvalidateData();
            FeatureListChangeLock--;
            FeaturePanel_mc.List_mc.selectedIndex = featureData;
            Shared.GlobalFunc.SetText(FeaturePanel_mc.Brackets_mc.Label_tf, panelTitle, false, true);
            FeaturePanel_mc.Brackets_mc.UpperHorizontalLine_mc.x = FeaturePanel_mc.Brackets_mc.Label_tf.x + FeaturePanel_mc.Brackets_mc.Label_tf.textWidth + 5;
            FeaturePanel_mc.Brackets_mc.UpperHorizontalLine_mc.width = FeaturePanel_mc.Brackets_mc.UpperRightCorner_mc.x - FeaturePanel_mc.Brackets_mc.UpperHorizontalLine_mc.x;
            PreviousStageFocus = stage.focus;
            stage.focus = FeaturePanel_mc.List_mc;
        }

        internal function SelectCategory():*
        {
            CurrentExtraGroup = LastSelectedExtraGroup;
            FeatureMode(AST_EXTRAS);
        }

        internal function FeatureCategoryMode()
        {
            eMode = FEATURE_CATEGORY_MODE;
            UpdateButtons();
            BGSCodeObj.GetFeatureData(FeaturePanel_mc.List_mc.entryList, AST_EXTRAS, uint.MAX_VALUE);			
            FeatureListChangeLock++;
            FeaturePanel_mc.List_mc.InvalidateData();
            var lastSelectedExtra = LastSelectedExtraGroup;
            CurrentSelectedExtra = uint.MAX_VALUE;
            FeaturePanel_mc.List_mc.InvalidateData();
            FeatureListChangeLock--;
            FeaturePanel_mc.List_mc.selectedIndex = lastSelectedExtra;
            Shared.GlobalFunc.SetText(FeaturePanel_mc.Brackets_mc.Label_tf, "$EXTRAS", false, true);
            FeaturePanel_mc.Brackets_mc.UpperHorizontalLine_mc.x = FeaturePanel_mc.Brackets_mc.Label_tf.x + FeaturePanel_mc.Brackets_mc.Label_tf.textWidth + 5;
            FeaturePanel_mc.Brackets_mc.UpperHorizontalLine_mc.width = FeaturePanel_mc.Brackets_mc.UpperRightCorner_mc.x - FeaturePanel_mc.Brackets_mc.UpperHorizontalLine_mc.x;
            PreviousStageFocus = stage.focus;
            stage.focus = FeaturePanel_mc.List_mc;
        }

        internal function FeaturesClear():*
        {
            this.BGSCodeObj.ClearDetails();
            this.UpdateButtons();
        }

        internal function FeaturesApply():*
        {
            var hasIntensity:*=undefined;
            var intensity:*=NaN;
            if (eFeature == AST_EXTRAS && CurrentSelectedExtra < uint.MAX_VALUE) 
            {
                hasIntensity = BGSCodeObj.GetDetailIntensity(CurrentExtraGroup, CurrentSelectedExtra) > 0;
                intensity = hasIntensity ? 0 : CurrentFeatureIntensity;
                BGSCodeObj.SetDetailIntensity(CurrentExtraGroup, CurrentSelectedExtra, intensity);
                if (!hasIntensity && CurrentExtraNumColors > 1) 
                {
                    BGSCodeObj.SetDetailColor(CurrentExtraGroup, CurrentSelectedExtra, CurrentExtraColor);
                }
                FeaturePanel_mc.List_mc.selectedEntry.applied = !hasIntensity;
                FeaturePanel_mc.List_mc.UpdateSelectedEntry();
                UpdateButtons();
                buttonHint_FeatureMode_Apply.ButtonText = hasIntensity ? "$APPLY" : "$REMOVE";
            }
        }

        internal function onFeatureSelectionChange():*
        {
            var currentIndex:*=0;
            if (FeatureListChangeLock == 0) 
            {
                currentIndex = FeaturePanel_mc.List_mc.selectedIndex;
                if (eMode != FEATURE_CATEGORY_MODE) 
                {
                    if (eMode == FEATURE_MODE) 
                    {
                        CurrentFeatureIntensity = 0;
                        CurrentExtraNumColors = 0;
						trace("onFeatureSelectionChange: " + currentIndex + " Mode: " + eMode + " Feature: " + eFeature);
                        switch (eFeature) 
                        {
                            case AST_HAIR:
                            {
                                BGSCodeObj.ChangeHairStyle(currentIndex);
                                break;
                            }
                            case AST_HAIR_COLOR:
                            {
                                BGSCodeObj.ChangeHairColor(currentIndex);
                                break;
                            }
                            case AST_BEARD:
                            {
                                BGSCodeObj.ChangeBeard(currentIndex);
                                break;
                            }
                            case AST_EYES:
                            case AST_COLOR:
                            {
								trace("AST_COLOR: group: " + CurrentExtraGroup + " selected: " + currentIndex);
                                BGSCodeObj.ChangeColor(currentIndex);
                                break;
                            }
                            case AST_EXTRAS:
                            {
                                CurrentSelectedExtra = currentIndex;
                                CurrentFeatureIntensity = BGSCodeObj.GetDetailIntensity(CurrentExtraGroup, currentIndex);
                                buttonHint_FeatureMode_Apply.ButtonText = CurrentFeatureIntensity > 0 ? "$REMOVE" : "$APPLY";
                                if (CurrentFeatureIntensity != 0) 
                                {
                                    BGSCodeObj.ClearTemporaryDetail(CurrentExtraGroup);
                                }
                                else 
                                {
                                    BGSCodeObj.SetDetailIntensity(CurrentExtraGroup, currentIndex, Number(1), true);
                                    CurrentFeatureIntensity = 1;
                                }
                                CurrentExtraNumColors = BGSCodeObj.GetDetailColorCount(CurrentExtraGroup, CurrentSelectedExtra);
                                CurrentExtraColor = BGSCodeObj.GetDetailColor(CurrentExtraGroup, CurrentSelectedExtra);
								trace("AST_EXTRAS: group: " + CurrentExtraGroup + " selected: " + CurrentSelectedExtra + " intensity: " + CurrentFeatureIntensity + " numColors: " + CurrentExtraNumColors + " color: " + CurrentExtraColor);
                                UpdateFeatureModifierButtonHint();
                                break;
                            }
                            case AST_MORPHS:
                            {
                                var boneIndex:uint = GetBoneRegionIndexFromCurrentID();
                                var presetCount = FacialBoneRegions[CurrentActor][boneIndex].presetCount;
                                if (FacialBoneRegions[CurrentActor][boneIndex].presetIndex != currentIndex) 
                                {
                                    BGSCodeObj.ChangePreset(CurrentBoneID, uint(currentIndex));
                                    FacialBoneRegions[CurrentActor][boneIndex].presetIndex = currentIndex;
                                    var morphIntensity: Number = currentIndex != AppliedMorphIndex ? FacialBoneRegions[CurrentActor][boneIndex].presetsSupportIntensity ? currentIndex ? 1 : -1 : -1 : AppliedMorphIntensity;
                                    FacialBoneRegions[CurrentActor][boneIndex].presetIntensity = intensity;
                                    BGSCodeObj.NotifyForWittyBanter(GetBanterFlavor(AST_COUNT));
                                    dirty = true;
                                    for(var i = 0; i < FacialBoneRegions[CurrentActor].length; i++)
                                    {
                                        if (i != boneIndex && FacialBoneRegions[CurrentActor][i].associatedPresetGroup == FacialBoneRegions[CurrentActor][boneIndex].associatedPresetGroup) 
                                        {
                                            FacialBoneRegions[CurrentActor][i].presetIndex = currentIndex;
                                            FacialBoneRegions[CurrentActor][i].presetIntensity = intensity;
                                        }
                                    }
                                    CurrentFeatureIntensity = morphIntensity;
                                    UpdateFeatureModifierButtonHint();
                                }
                                break;
                            }
                        }
                    }
                }
                else 
                {
                    LastSelectedExtraGroup = currentIndex;
                }
            }
        }

        internal function onFeatureSelected():*
        {
            if (BlockNextAccept) 
            {
                BlockNextAccept = false;
                return;
            }
            if (eMode != FEATURE_CATEGORY_MODE) 
            {
                if (eMode == FEATURE_MODE && eFeature == AST_EXTRAS) 
                {
                    AcceptChanges();
                }
                else if (eMode == FEATURE_MODE) 
                {
					for(var i = 0; i < FeaturePanel_mc.List_mc.entryList.length; i++)
                    {
                        FeaturePanel_mc.List_mc.entryList[i].applied = false;
                        FeaturePanel_mc.List_mc.UpdateEntry(FeaturePanel_mc.List_mc.entryList[i]);
                    }
                    FeaturePanel_mc.List_mc.selectedEntry.applied = true;
                    FeaturePanel_mc.List_mc.UpdateSelectedEntry();
                    switch (eFeature) 
                    {
                        case AST_HAIR:
                        {
                            BGSCodeObj.CreateSavePoint(UNDO_HAIRSTYLE);
                            break;
                        }
                        case AST_HAIR_COLOR:
                        {
                            BGSCodeObj.CreateSavePoint(UNDO_HAIRCOLOR);
                            break;
                        }
                        case AST_BEARD:
                        {
                            BGSCodeObj.CreateSavePoint(UNDO_BEARD);
                            break;
                        }
                        case AST_COLOR:
                        {
                            BGSCodeObj.CreateSavePoint(UNDO_COLOR, CurrentBoneID);
                            break;
                        }
                        case AST_EYES:
                        {
                            BGSCodeObj.CreateSavePoint(UNDO_COLOR, CurrentBoneID);
                            break;
                        }
                        case AST_EXTRAS:
                        {
                            BGSCodeObj.CreateSavePoint(UNDO_EXTRAS);
                            break;
                        }
                        case AST_MORPHS:
                        {
                            BGSCodeObj.CreateSavePoint(UNDO_MORPHS);
                            break;
                        }
                    }
                    AcceptChanges();
                }
            }
            else 
            {
                SelectCategory();
            }
        }

        internal function FeatureModeBumper(arg1:Boolean):*
        {
            var loc2:*=undefined;
            var loc3:*=undefined;
            var loc4:*=undefined;
            var loc5:*=0;
            var loc6:*=undefined;
            var loc7:*=undefined;
            var loc8:*=undefined;
            var loc1:*=this.CurrentFeatureIntensity;
            if (this.CurrentFeatureIntensity > -1) 
            {
                loc2 = this.FeatureIntensityStep;
                loc4 = (loc3 = Math.min(this.FeatureIntensityRampDurationCeiling, this._BumperDurationHeld)) / this.FeatureIntensityRampDurationCeiling;
                loc2 = loc2 + loc4 * loc4 * loc4 * this.FeatureIntensityRampEffect;
                if (arg1) 
                {
                    loc1 = loc1 - loc2;
                }
                else 
                {
                    loc1 = loc1 + loc2;
                }
                if (loc1 < 0.01) 
                {
                    loc1 = 0.01;
                }
                if (loc1 > 1) 
                {
                    loc1 = 1;
                }
            }
            var loc9:*=this.eFeature;
            switch (loc9) 
            {
                case this.AST_MORPHS:
                {
                    if (loc1 > -1) 
                    {
                        loc5 = this.GetBoneRegionIndexFromCurrentID();
                        this.FacialBoneRegions[this.CurrentActor][loc5].presetIntensity = loc1;
                        this.BGSCodeObj.ChangePresetIntensity(loc1);
                        this.CurrentFeatureIntensity = loc1;
                        this.UpdateFeatureModifierButtonHint();
                    }
                    break;
                }
                case this.AST_EXTRAS:
                {
                    if (this.CurrentExtraNumColors > 1) 
                    {
                        loc6 = false;
                        loc7 = this._BumperDurationHeld > this.ColorChangeRateIncreaseAt ? this.ColorChangeRateFast : this.ColorChangeRateSlow;
                        if (this._BumperJustPressed || this._BumperDurationHeld - this.LastColorChangeAt > loc7) 
                        {
                            if (arg1 && this.CurrentExtraColor > 0 || !arg1 && this.CurrentExtraColor < (this.CurrentExtraNumColors - 1)) 
                            {
                                if (arg1) 
                                {
                                    var loc10:*=((loc9 = this).CurrentExtraColor - 1);
                                    loc9.CurrentExtraColor = loc10;
                                }
                                else 
                                {
                                    loc10 = ((loc9 = this).CurrentExtraColor + 1);
                                    loc9.CurrentExtraColor = loc10;
                                }
                                this.BGSCodeObj.SetDetailColor(this.CurrentExtraGroup, this.CurrentSelectedExtra, this.CurrentExtraColor);
                                this.UpdateFeatureModifierButtonHint();
                            }
                            this.LastColorChangeAt = this._BumperDurationHeld;
                            this._BumperJustPressed = false;
                        }
                    }
                    else if (this.CurrentExtraNumColors == 0 && loc1 > -1) 
                    {
                        loc8 = this.BGSCodeObj.GetDetailIntensity(this.CurrentExtraGroup, this.CurrentSelectedExtra) == 0;
                        this.BGSCodeObj.SetDetailIntensity(this.CurrentExtraGroup, this.CurrentSelectedExtra, loc1, loc8);
                        this.CurrentFeatureIntensity = loc1;
                        this.UpdateFeatureModifierButtonHint();
                    }
                    break;
                }
            }
            return;
        }

        public function set BumperJustPressed(arg1:Boolean):*
        {
            this._BumperJustPressed = arg1;
        }

        internal function __setProp_ButtonHintBar_mc_LooksMenuBase_Shared_0():*
        {
            try 
            {
                this.ButtonHintBar_mc["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            };
            this.ButtonHintBar_mc.BackgroundAlpha = 1;
            this.ButtonHintBar_mc.BackgroundColor = 0;
            this.ButtonHintBar_mc.bracketCornerLength = 6;
            this.ButtonHintBar_mc.bracketLineWidth = 1.5;
            this.ButtonHintBar_mc.BracketStyle = "horizontal";
            this.ButtonHintBar_mc.bRedirectToButtonBarMenu = false;
            this.ButtonHintBar_mc.bShowBrackets = true;
            this.ButtonHintBar_mc.bUseShadedBackground = true;
            this.ButtonHintBar_mc.ShadedBackgroundMethod = "Shader";
            this.ButtonHintBar_mc.ShadedBackgroundType = "normal";
            try 
            {
                this.ButtonHintBar_mc["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            };
        }

        public function set BumperDurationHeld(arg1:Number):*
        {
            _BumperDurationHeld = arg1;
        }

        internal function FeatureModeRBumper():*
        {
            FeatureModeBumper(false);
        }

        internal function FeatureModeLBumper():*
        {
            FeatureModeBumper(true);
        }

        internal function SculptModeIn():*
        {
            FindAndSetAxisValue(this.Z_AXIS, false);
        }

        public function set characterPresetCount(arg1:uint):*
        {
            uiCharacterPresetCount = arg1;
        }

        internal function SculptModeOut():*
        {
            FindAndSetAxisValue(this.Z_AXIS, true);
        }

        internal function SculptModeRotateRight():*
        {
            FindAndSetAxisValue(this.X_ROT_AXIS, false);
        }

        internal function SculptModeRotateLeft():*
        {
            FindAndSetAxisValue(this.X_ROT_AXIS, true);
        }

        internal function SculptModeEnlarge():*
        {
            FindAndSetAxisValue(this.X_SCALE_AXIS, true);
        }

        internal function SculptModeShrink():*
        {
            FindAndSetAxisValue(this.X_SCALE_AXIS, false);
        }

        public function GetBoneRegionIndexFromCurrentID():uint
        {
            var loc2:*=0;
            var loc1:*=uint.MAX_VALUE;
            if (FacialBoneRegions.length > 0) 
            {
                loc2 = 0;
                while (loc2 < FacialBoneRegions[CurrentActor].length) 
                {
                    if (FacialBoneRegions[CurrentActor][loc2].regionID == CurrentBoneID) 
                    {
                        loc1 = loc2;
                    }
                    ++loc2;
                }
            }
            return loc1;
        }

        public function SculptModeMouseWheel(arg1:Number):*
        {
            if (arg1 > 0) 
            {
                SculptModeIn();
            }
            else if (arg1 < 0) 
            {
                SculptModeOut();
            }
        }

        public function GetMorphSliderFromCurrentID():uint
        {
            var loc1:*=uint.MAX_VALUE;
            var loc2:*=this.GetBoneRegionIndexFromCurrentID();
            if (!(loc2 == uint.MAX_VALUE) && this.FacialBoneRegions[this.CurrentActor][loc2].isSlider == true) 
            {
                loc1 = loc2;
            }
            return loc1;
        }

        public function FindAndSetAxisValue(arg1:uint, arg2:Boolean, arg3:Number=1):*
        {
            var loc3:*=0;
            var loc1:*=arg3 * this.SLIDER_STEP_SIZE;
            var loc2:*=this.GetBoneRegionIndexFromCurrentID();
            if (!(this.CurrentBoneID == uint.MAX_VALUE) && !(loc2 == uint.MAX_VALUE)) 
            {
                loc3 = 0;
                while (loc3 < this.FacialBoneRegions[this.CurrentActor][loc2].axisArray.length) 
                {
                    if (this.FacialBoneRegions[this.CurrentActor][loc2].axisArray[loc3].buttonMapping == arg1) 
                    {
                        if (this.FacialBoneRegions[this.CurrentActor][loc2].axisArray[loc3].isScalingAxis != true) 
                        {
                            if (this.FacialBoneRegions[this.CurrentActor][loc2].axisArray[loc3].isSlider == true) 
                            {
                                if (arg2) 
                                {
                                    this.FacialBoneRegions[this.CurrentActor][loc2].axisArray[loc3].axisSliderValue = this.FacialBoneRegions[this.CurrentActor][loc2].axisArray[loc3].axisSliderValue + loc1;
                                    if (this.FacialBoneRegions[this.CurrentActor][loc2].axisArray[loc3].axisSliderValue > this.SLIDER_MAX) 
                                    {
                                        this.FacialBoneRegions[this.CurrentActor][loc2].axisArray[loc3].axisSliderValue = this.SLIDER_MAX;
                                    }
                                }
                                else 
                                {
                                    this.FacialBoneRegions[this.CurrentActor][loc2].axisArray[loc3].axisSliderValue = this.FacialBoneRegions[this.CurrentActor][loc2].axisArray[loc3].axisSliderValue - loc1;
                                    if (this.FacialBoneRegions[this.CurrentActor][loc2].axisArray[loc3].axisSliderValue < this.SLIDER_MIN) 
                                    {
                                        this.FacialBoneRegions[this.CurrentActor][loc2].axisArray[loc3].axisSliderValue = this.SLIDER_MIN;
                                    }
                                }
                                this.BGSCodeObj.ChangeBoneRegionMorphSlider(this.CurrentBoneID, this.FacialBoneRegions[this.CurrentActor][loc2].axisArray[loc3].axisIndex, this.FacialBoneRegions[this.CurrentActor][loc2].axisArray[loc3].axisSliderValue as Number);
                            }
                        }
                        else 
                        {
                            if (arg2) 
                            {
                                this.FacialBoneRegions[this.CurrentActor][loc2].axisArray[loc3].axisScalingValue = this.FacialBoneRegions[this.CurrentActor][loc2].axisArray[loc3].axisScalingValue + loc1;
                                if (this.FacialBoneRegions[this.CurrentActor][loc2].axisArray[loc3].axisScalingValue > this.SLIDER_MAX) 
                                {
                                    this.FacialBoneRegions[this.CurrentActor][loc2].axisArray[loc3].axisScalingValue = this.SLIDER_MAX;
                                }
                            }
                            else 
                            {
                                this.FacialBoneRegions[this.CurrentActor][loc2].axisArray[loc3].axisScalingValue = this.FacialBoneRegions[this.CurrentActor][loc2].axisArray[loc3].axisScalingValue - loc1;
                                if (this.FacialBoneRegions[this.CurrentActor][loc2].axisArray[loc3].axisScalingValue < this.SLIDER_MIN) 
                                {
                                    this.FacialBoneRegions[this.CurrentActor][loc2].axisArray[loc3].axisScalingValue = this.SLIDER_MIN;
                                }
                            }
                            this.BGSCodeObj.ChangeBoneRegionAxis(this.CurrentBoneID, this.FacialBoneRegions[this.CurrentActor][loc2].axisArray[loc3].axisIndex, this.FacialBoneRegions[this.CurrentActor][loc2].axisArray[loc3].axisScalingValue as Number);
                        }
                    }
                    ++loc3;
                }
            }
        }

        public function GetValidAxis(arg1:uint):Boolean
        {
            var loc1:*=0;
            var loc2:*=0;
            if (this.CurrentBoneID != uint.MAX_VALUE) 
            {
                loc1 = 0;
                while (loc1 < this.FacialBoneRegions[this.CurrentActor].length) 
                {
                    if (this.CurrentBoneID == this.FacialBoneRegions[this.CurrentActor][loc1].regionID) 
                    {
                        loc2 = 0;
                        while (loc2 < this.FacialBoneRegions[this.CurrentActor][loc1].axisArray.length) 
                        {
                            if (this.FacialBoneRegions[this.CurrentActor][loc1].axisArray[loc2].buttonMapping == arg1) 
                            {
                                return true;
                            }
                            ++loc2;
                        }
                    }
                    ++loc1;
                }
            }
            return false;
        }

        public function ShouldEnableButton():*
        {
            return GetValidAxis(X_AXIS) || GetValidAxis(Y_AXIS) || GetValidAxis(Z_AXIS) || GetValidAxis(X_ROT_AXIS) || GetValidAxis(X_SCALE_AXIS);
        }

        internal function CancelChanges():*
        {
            switch (eMode) 
            {
                case SCULPT_MODE:
                {
                    var boneIndex = GetBoneRegionIndexFromCurrentID();
					for(var i = 0; i < FacialBoneRegions[CurrentActor][boneIndex].axisArray.length; i++)
                    {
                        if (FacialBoneRegions[CurrentActor][boneIndex].axisArray[i].isScalingAxis) 
                        {
                            FacialBoneRegions[CurrentActor][boneIndex].axisArray[i].axisScalingValue = UndoDataSculptingTransform[i];
                        }
                        else if (FacialBoneRegions[CurrentActor][boneIndex].axisArray[i].isSlider) 
                        {
                            FacialBoneRegions[CurrentActor][boneIndex].axisArray[i].axisSliderValue = UndoDataSculptingTransform[i];
                        }
                    }
                    break;
                }
            }
            BGSCodeObj.UndoLastAction();
            PreviousMode(false);
        }

        public function SculptModeLStickMouse(x_axis:Number, y_axis:Number):*
        {
            if (x_axis != 0) 
            {
                FindAndSetAxisValue(ControlAxes[LEFT_RIGHT], x_axis < 0, Math.abs(x_axis));
            }
            if (y_axis != 0) 
            {
                FindAndSetAxisValue(ControlAxes[UP_DOWN], y_axis < 0, Math.abs(y_axis));
            }
        }

        internal function StyleMode():*
        {
            if (buttonHint_HairMode_Style.ButtonEnabled && eMode == HAIR_MODE) 
            {
                FeatureMode(AST_HAIR);
            }
        }

        internal function TypeMode():*
        {
            var loc1:*=0;
            if (this.buttonHint_FaceMode_Type.ButtonEnabled) 
            {
                if (this.eMode != this.HAIR_MODE) 
                {
                    loc1 = this.GetBoneRegionIndexFromCurrentID();
                    if (this.FacialBoneRegions[this.CurrentActor][loc1].headPart != this.HeadPartFacialHair) 
                    {
                        if (this.eMode == this.FACE_MODE && (this.EditMode == this.EDIT_CHARGEN || this.EditMode == this.EDIT_BODYMOD)) 
                        {
                            if (this.CurrentBoneID < uint.MAX_VALUE) 
                            {
                                this.FeatureMode(this.AST_MORPHS);
                            }
                        }
                        else if (this.eMode == this.HAIR_MODE && (this.EditMode == this.EDIT_CHARGEN || this.EditMode == this.EDIT_HAIRCUT)) 
                        {
                            this.FeatureMode(this.AST_HAIR);
                        }
                    }
                    else 
                    {
                        this.FeatureMode(this.AST_BEARD);
                    }
                }
                else if (this.EditMode == this.EDIT_HAIRCUT && !this._bisFemale) 
                {
                    this.FeatureMode(this.AST_BEARD);
                }
            }
        }

        internal function ColorMode():*
        {
            var loc1:*=0;
            var loc2:*=undefined;
            if (this.buttonHint_FaceMode_Color.ButtonEnabled) 
            {
                if (this.eMode == this.FACE_MODE && (this.EditMode == this.EDIT_CHARGEN || this.EditMode == this.EDIT_BODYMOD)) 
                {
                    loc1 = this.GetBoneRegionIndexFromCurrentID();
                    loc2 = this.FacialBoneRegions[this.CurrentActor][loc1].headPart;
                    this.FeatureMode(loc2 != this.HeadPartEyes ? this.AST_COLOR : this.AST_EYES);
                }
                else if (this.eMode == this.HAIR_MODE && (this.EditMode == this.EDIT_CHARGEN || this.EditMode == this.EDIT_HAIRCUT)) 
                {
                    this.FeatureMode(this.AST_HAIR_COLOR);
                }
            }
        }

        public function SculptMode():*
        {
            var loc1:*=0;
            var loc2:*=null;
            var loc3:*=0;
            if (this.buttonHint_FaceMode_Sculpt.ButtonEnabled && (this.EditMode == this.EDIT_CHARGEN || this.EditMode == this.EDIT_BODYMOD)) 
            {
                this.eMode = this.SCULPT_MODE;
                this.UpdateButtons();
                this.BGSCodeObj.ClearBoneRegionTint();
                loc1 = this.GetBoneRegionIndexFromCurrentID();
                loc2 = this.FacialBoneRegions[this.CurrentActor][loc1].axisArray;
                this.UndoDataSculptingTransform = new Array(loc2.length);
                loc3 = 0;
                while (loc3 < loc2.length) 
                {
                    if (loc2[loc3].isScalingAxis) 
                    {
                        this.UndoDataSculptingTransform[loc3] = loc2[loc3].axisScalingValue;
                    }
                    else if (loc2[loc3].isSlider) 
                    {
                        this.UndoDataSculptingTransform[loc3] = loc2[loc3].axisSliderValue;
                    }
                    ++loc3;
                }
                this.BGSCodeObj.CreateUndoPoint(this.UNDO_SCULPT, this.CurrentBoneID);
            }
        }

        internal function StartMode():*
        {
            if (this.EditMode == this.EDIT_CHARGEN || this.EditMode == this.EDIT_BODYMOD) 
            {
                this.eMode = this.START_MODE;
                this.BGSCodeObj.ClearBoneRegionTint();
                this.ShowHairHighlight(false);
                this.UpdateButtons();
            }
        }

        internal function ExtrasMode():*
        {
            var boneIndex = GetBoneRegionIndexFromCurrentID();
            if (EditMode == EDIT_CHARGEN || EditMode == EDIT_BODYMOD) 
            {
                CurrentExtraGroup = uint.MAX_VALUE;
                FeatureCategoryMode();
            }
        }

        internal function BodyMode():*
        {			
            if (this.eMode == this.START_MODE && (this.EditMode == this.EDIT_CHARGEN || this.EditMode == this.EDIT_BODYMOD) && this.BGSCodeObj.StartBodyEdit()) 
            {
                this.BGSCodeObj.CreateUndoPoint(this.UNDO_WEIGHT);
                this.eMode = this.BODY_MODE;
                this.UpdateButtons();
            }
        }

		internal function PresetMode():*
        {
            /*if (eMode == START_MODE) 
            {
                eMode = PRESET_MODE;
                UpdateButtons();
            }*/
			root.f4se.plugins.F4EE.SavePreset("Data/F4SE/Plugins/F4EE/Face.json");
        }

        internal function FaceMode():*
        {
            if (this.eMode == this.START_MODE) 
            {
                this.eMode = this.FACE_MODE;
                this.UpdateButtons();
                this.BGSCodeObj.ClearPickData();
            }
        }

        public function onCommitCharacterPresetChange(arg1:uint):*
        {
            this.dirty = false;
        }

        internal function CharacterPresetRight():*
        {
            if (!this.confirmClose) 
            {
                this.BGSCodeObj.ChangeCharacterPreset(false);
                this.UpdateButtons();
            }
        }

        internal function CharacterPresetLeft():*
        {
            if (!this.confirmClose) 
            {
                this.BGSCodeObj.ChangeCharacterPreset(true);
                this.UpdateButtons();
            }
        }

        internal function ChangeSex():*
        {
            if (!this.confirmClose) 
            {
                this.BGSCodeObj.ChangeSex();
                this.UpdateButtons();
            }
        }

        internal function ConfirmCloseMenu():*
        {
            if (eMode == START_MODE || eMode == HAIR_MODE && EditMode == EDIT_HAIRCUT) 
            {
                if (BGSCodeObj.ConfirmAndCloseMenu()) 
                {
                    confirmClose = true;
                }
            }
        }

        internal function AcceptChanges():*
        {
            dirty = true;
            PreviousMode(true);
        }

        internal function PreviousMode(notify:Boolean):*
        {
            switch (eMode) 
            {
                case this.SCULPT_MODE:
                {
                    if (notify) 
                    {
                        this.BGSCodeObj.NotifyForWittyBanter(this.GetBanterFlavor(this.AST_COUNT));
                    }
                    this.BGSCodeObj.HighlightBoneRegion(this.CurrentBoneID);
                    this.menuMode = this.FACE_MODE;
                    break;
                }
                case this.FEATURE_MODE:
                {
                    if (notify) 
                    {
                        this.BGSCodeObj.NotifyForWittyBanter(this.GetBanterFlavor(this.eFeature));
                    }
                    currentMode = this.eFeature;
                    switch (eFeature) 
                    {
                        case this.AST_HAIR_COLOR:
                        case this.AST_HAIR:
                        {
                            this.menuMode = this.HAIR_MODE;
                            if (this.EditMode != this.EDIT_HAIRCUT) 
                            {
                                this.ShowHairHighlight(true);
                            }
                            this.BlockNextAccept = false;
                            break;
                        }
                        case this.AST_EXTRAS:
                        {
                            this.BGSCodeObj.ClearTemporaryDetail(this.CurrentExtraGroup);
                            this.FeatureCategoryMode();
                            break;
                        }
                        case this.AST_BEARD:
                        {
                            this.menuMode = this.EditMode != this.EDIT_HAIRCUT ? this.FACE_MODE : this.HAIR_MODE;
                            this.BlockNextAccept = false;
                            break;
                        }
                        default:
                        {
                            this.menuMode = this.FACE_MODE;
                            this.BlockNextAccept = false;
                            break;
                        }
                    }
                    if (this.eFeature != this.AST_EXTRAS) 
                    {
                        this.BGSCodeObj.HighlightBoneRegion(this.CurrentBoneID);
                        this.eFeature = this.AST_COUNT;
                        stage.focus = this.PreviousStageFocus;
                    }
                    break;
                }
                case FEATURE_CATEGORY_MODE:
                {
                    this.menuMode = this.START_MODE;
                    this.eFeature = this.AST_COUNT;
                    stage.focus = this.PreviousStageFocus;
                    break;
                }
				case PRESET_MODE:
                case FACE_MODE:
                case HAIR_MODE:
                {
                    this.ShowHairHighlight(false);
                    this.BGSCodeObj.ClearBoneRegionTint();
                }
                case BODY_MODE:
                {
                    if (this.BGSCodeObj.EndBodyEdit()) 
                    {
                        this.BGSCodeObj.NotifyForWittyBanter(this.BANTER_GENERAL);
                        this.menuMode = this.START_MODE;
                    }
                    break;
                }
            }
            return;
        }

        public function ShouldMoveCursor():Boolean
        {
            return (this.eMode == this.FACE_MODE || this.eMode == this.HAIR_MODE) && !(this.EditMode == this.EDIT_HAIRCUT);
        }

        internal function FeatureModeBack():*
        {
            this.BGSCodeObj.ClearTemporaryDetail(this.CurrentExtraGroup);
            this.CurrentExtraGroup = uint.MAX_VALUE;
            this.FeatureMode(this.AST_EXTRAS);
        }

        internal function GetBanterFlavor(arg1:uint):*
        {
            var loc1:*=this.GetBoneRegionIndexFromCurrentID();
            var loc2:*=loc1 < uint.MAX_VALUE ? this.FacialBoneRegions[this.CurrentActor][loc1].headPart : this.HeadPartNone;
            var loc3:*=this.BANTER_GENERAL;
            var loc4:*=arg1;
            switch (loc4) 
            {
                case this.AST_HAIR:
                case this.AST_HAIR_COLOR:
                {
                    loc3 = this.BANTER_HAIR;
                    break;
                }
                case this.AST_EYES:
                {
                    loc3 = this.BANTER_EYES;
                    break;
                }
                case this.AST_COLOR:
                {
                    if (loc2 == this.HeadPartEyes) 
                    {
                        loc3 = this.BANTER_EYES;
                    }
                    break;
                }
                case this.AST_BEARD:
                {
                    loc3 = this.BANTER_BEARD;
                    break;
                }
                case this.AST_COUNT:
                {
                    loc4 = loc2;
                    switch (loc4) 
                    {
                        case this.HeadPartEyes:
                        {
                            loc3 = this.BANTER_EYES;
                            break;
                        }
                        case this.HeadPartHair:
                        {
                            loc3 = this.BANTER_HAIR;
                            break;
                        }
                        case this.HeadPartFacialHair:
                        {
                            loc3 = this.BANTER_GENERAL;
                            break;
                        }
                        case this.HeadPartTeeth:
                        {
                            loc3 = this.BANTER_MOUTH;
                            break;
                        }
                        default:
                        {
                            if (loc1 < uint.MAX_VALUE) 
                            {
                                loc3 = this.FacialBoneRegions[this.CurrentActor][loc1].banterFlavor;
                            }
                            break;
                        }
                    }
                    break;
                }
            }
            return loc3;
        }

        public function set editMode(a_mode:uint):*
        {
            AllowChangeSex = a_mode == EDIT_CHARGEN;
            if (a_mode == EDIT_REMAKE_UNUSED) 
            {
                a_mode = EDIT_CHARGEN;
            }
            EditMode = a_mode;
            if (a_mode == EDIT_HAIRCUT) 
            {
                eMode = HAIR_MODE;
            }
            UpdateButtons();
        }

        internal function ShowHairHighlight(a_show:Boolean):*
        {
            BGSCodeObj.SetHairHighlight(a_show);
        }

        public function set confirmClose(a_close:Boolean):*
        {
            _bconfirmClose = a_close;
        }

        public function get confirmClose():*
        {
            return _bconfirmClose;
        }

        public function get sculpting():*
        {
            return eMode == SCULPT_MODE;
        }

        public function get dirty():*
        {
            return _dirty;
        }

        public function set dirty(d:Boolean):*
        {
            _dirty = d;
        }

        public function get cursorRadius():*
        {
            return Cursor_mc.width * 0.5;
        }

        public function set currentActor(actor:uint):*
        {
            CurrentActor = actor;
            UpdateButtons();
        }
    }
}
