package LooksMenu_fla 
{
    import adobe.utils.*;
    import flash.accessibility.*;
    import flash.desktop.*;
    import flash.display.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.external.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.globalization.*;
    import flash.media.*;
    import flash.net.*;
    import flash.net.drm.*;
    import flash.printing.*;
    import flash.profiler.*;
    import flash.sampler.*;
    import flash.sensors.*;
    import flash.system.*;
    import flash.text.*;
    import flash.text.engine.*;
    import flash.text.ime.*;
    import flash.ui.*;
    import flash.utils.*;
    import flash.xml.*;
    
    public dynamic class FeatureListBrackets_5 extends flash.display.MovieClip
    {
        public function FeatureListBrackets_5()
        {
            super();
            this.__setProp_BracketExtents_mc_FeatureListBrackets_Layer1_0();
            return;
        }

        function __setProp_BracketExtents_mc_FeatureListBrackets_Layer1_0():*
        {
            try 
            {
                this.BracketExtents_mc["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            };
            this.BracketExtents_mc.bracketCornerLength = 6;
            this.BracketExtents_mc.bracketLineWidth = 1.5;
            this.BracketExtents_mc.bracketPaddingX = 0;
            this.BracketExtents_mc.bracketPaddingY = 0;
            this.BracketExtents_mc.BracketStyle = "horizontal";
            this.BracketExtents_mc.bShowBrackets = false;
            this.BracketExtents_mc.bUseShadedBackground = true;
            this.BracketExtents_mc.ShadedBackgroundMethod = "Shader";
            this.BracketExtents_mc.ShadedBackgroundType = "normal";
            try 
            {
                this.BracketExtents_mc["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            };
            return;
        }

        public var UpperHorizontalLine_mc:flash.display.MovieClip;

        public var BracketExtents_mc:flash.display.MovieClip;

        public var LowerBracket_mc:flash.display.MovieClip;

        public var Label_tf:flash.text.TextField;

        public var UpperRightCorner_mc:flash.display.MovieClip;

        public var UpperLeftCorner_mc:flash.display.MovieClip;
    }
}
