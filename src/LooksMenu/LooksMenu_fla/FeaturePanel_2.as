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
    
    public dynamic class FeaturePanel_2 extends flash.display.MovieClip
    {
        public function FeaturePanel_2()
        {
            super();
            this.__setProp_List_mc_FeaturePanel_List_mc_0();
            return;
        }

        function __setProp_List_mc_FeaturePanel_List_mc_0():*
        {
            try 
            {
                this.List_mc["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            };
            this.List_mc.listEntryClass = "FeatureListEntry";
            this.List_mc.numListItems = 8;
            this.List_mc.restoreListIndex = false;
            this.List_mc.textOption = "Shrink To Fit";
            this.List_mc.verticalSpacing = -2;
            try 
            {
                this.List_mc["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            };
            return;
        }

        public var Brackets_mc:flash.display.MovieClip;

        public var PlayerBracketBackground_mc:flash.display.MovieClip;

        public var List_mc:FeatureList;
    }
}
