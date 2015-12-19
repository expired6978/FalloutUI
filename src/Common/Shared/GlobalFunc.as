package Shared 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import scaleform.gfx.*;
    
    public class GlobalFunc extends Object
    {
        public function GlobalFunc()
        {
            super();
        }

        public static function Lerp(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:Number, arg6:Boolean):Number
        {
            var loc1:*=arg1 + (arg5 - arg3) / (arg4 - arg3) * (arg2 - arg1);
            if (arg6) 
            {
                if (arg1 < arg2) 
                {
                    loc1 = Math.min(Math.max(loc1, arg1), arg2);
                }
                else 
                {
                    loc1 = Math.min(Math.max(loc1, arg2), arg1);
                }
            }
            return loc1;
        }

        public static function RoundDecimal(arg1:Number, arg2:Number):Number
        {
            var loc1:*=Math.pow(10, arg2);
            return Math.round(loc1 * arg1) / loc1;
        }

        public static function CloseToNumber(arg1:Number, arg2:Number):Boolean
        {
            return Math.abs(arg1 - arg2) < CLOSE_ENOUGH_EPSILON;
        }

        public static function MaintainTextFormat():*
        {
            var loc1:*;
            flash.text.TextField.prototype.SetText = function (arg1:String, arg2:Boolean, arg3:Boolean=false):*
            {
                var loc2:*=NaN;
                var loc3:*=false;
                if (!arg1 || arg1 == "") 
                {
                    arg1 = " ";
                }
                if (arg3 && !(arg1.charAt(0) == "$")) 
                {
                    arg1 = arg1.toUpperCase();
                }
                var loc1:*=this.getTextFormat();
                if (arg2) 
                {
                    loc2 = Number(loc1.letterSpacing);
                    loc3 = loc1.kerning;
                    this.htmlText = arg1;
                    (loc1 = this.getTextFormat()).letterSpacing = loc2;
                    loc1.kerning = loc3;
                    this.setTextFormat(loc1);
                    this.htmlText = arg1;
                }
                else 
                {
                    this.text = arg1;
                    this.setTextFormat(loc1);
                    this.text = arg1;
                }
            }
        }

        public static function SetText(arg1:flash.text.TextField, arg2:String, arg3:Boolean, arg4:Boolean=false, arg5:*=false):*
        {
            var loc1:*=null;
            var loc2:*=NaN;
            var loc3:*=false;
            if (!arg2 || arg2 == "") 
            {
                arg2 = " ";
            }
            if (arg4 && !(arg2.charAt(0) == "$")) 
            {
                arg2 = arg2.toUpperCase();
            }
            if (arg3) 
            {
                loc1 = arg1.getTextFormat();
                loc2 = Number(loc1.letterSpacing);
                loc3 = loc1.kerning;
                arg1.htmlText = arg2;
                (loc1 = arg1.getTextFormat()).letterSpacing = loc2;
                loc1.kerning = loc3;
                arg1.setTextFormat(loc1);
            }
            else 
            {
                arg1.text = arg2;
            }
            if (arg5 && arg1.text.length > MAX_TRUNCATED_TEXT_LENGTH) 
            {
                arg1.text = arg1.text.slice(0, MAX_TRUNCATED_TEXT_LENGTH - 3) + "...";
            }
        }

        public static function LockToSafeRect(arg1:flash.display.DisplayObject, arg2:String, arg3:Number=0, arg4:Number=0):*
        {
            var loc1:*=scaleform.gfx.Extensions.visibleRect;
            var loc2:*=new flash.geom.Point(loc1.x + arg3, loc1.y + arg4);
            var loc3:*=new flash.geom.Point(loc1.x + loc1.width - arg3, loc1.y + loc1.height - arg4);
            var loc4:*=arg1.parent.globalToLocal(loc2);
            var loc5:*=arg1.parent.globalToLocal(loc3);
            var loc6:*=flash.geom.Point.interpolate(loc4, loc5, 0.5);
            if (arg2 == "T" || arg2 == "TL" || arg2 == "TR" || arg2 == "TC") 
            {
                arg1.y = loc4.y;
            }
            if (arg2 == "CR" || arg2 == "CC" || arg2 == "CL") 
            {
                arg1.y = loc6.y;
            }
            if (arg2 == "B" || arg2 == "BL" || arg2 == "BR" || arg2 == "BC") 
            {
                arg1.y = loc5.y;
            }
            if (arg2 == "L" || arg2 == "TL" || arg2 == "BL" || arg2 == "CL") 
            {
                arg1.x = loc4.x;
            }
            if (arg2 == "TC" || arg2 == "CC" || arg2 == "BC") 
            {
                arg1.x = loc6.x;
            }
            if (arg2 == "R" || arg2 == "TR" || arg2 == "BR" || arg2 == "CR") 
            {
                arg1.x = loc5.x;
            }
        }

        public static function AddMovieExploreFunctions():*
        {
            var loc1:*;
            flash.display.MovieClip.prototype.getMovieClips = function ():Array
            {
                var loc2:*=undefined;
                var loc1:*=new Array();
                var loc3:*=0;
                var loc4:*=this;
                for (loc2 in loc4) 
                {
                    if (!(this[loc2] is flash.display.MovieClip && !(this[loc2] == this))) 
                    {
                        continue;
                    }
                    loc1.push(this[loc2]);
                }
                return loc1;
            }
            flash.display.MovieClip.prototype.showMovieClips = function ():*
            {
                var loc1:*=undefined;
                var loc2:*=0;
                var loc3:*=this;
                for (loc1 in loc3) 
                {
                    if (!(this[loc1] is flash.display.MovieClip && !(this[loc1] == this))) 
                    {
                        continue;
                    }
                    trace(this[loc1]);
                    this[loc1].showMovieClips();
                }
            }
        }

        public static function AddReverseFunctions():*
        {
            var loc1:*;
            flash.display.MovieClip.prototype.PlayReverseCallback = function (arg1:flash.events.Event):*
            {
                if (arg1.currentTarget.currentFrame > 1) 
                {
                    arg1.currentTarget.gotoAndStop((arg1.currentTarget.currentFrame - 1));
                }
                else 
                {
                    arg1.currentTarget.removeEventListener(flash.events.Event.ENTER_FRAME, arg1.currentTarget.PlayReverseCallback);
                }
            }
            flash.display.MovieClip.prototype.PlayReverse = function ():*
            {
                if (this.currentFrame > 1) 
                {
                    this.gotoAndStop((this.currentFrame - 1));
                    this.addEventListener(flash.events.Event.ENTER_FRAME, this.PlayReverseCallback);
                }
                else 
                {
                    this.gotoAndStop(1);
                }
            }
            flash.display.MovieClip.prototype.PlayForward = function (arg1:String):*
            {
                delete this.onEnterFrame;
                this.gotoAndPlay(arg1);
            }
            flash.display.MovieClip.prototype.PlayForward = function (arg1:Number):*
            {
                delete this.onEnterFrame;
                this.gotoAndPlay(arg1);
            }
        }

        public static function StringTrim(arg1:String):String
        {
            var loc4:*=null;
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=arg1.length;
            while (arg1.charAt(loc1) == " " || arg1.charAt(loc1) == "\n" || arg1.charAt(loc1) == "\r" || arg1.charAt(loc1) == "\t") 
            {
                ++loc1;
            }
            loc2 = ((loc4 = arg1.substring(loc1)).length - 1);
            while (loc4.charAt(loc2) == " " || loc4.charAt(loc2) == "\n" || loc4.charAt(loc2) == "\r" || loc4.charAt(loc2) == "\t") 
            {
                --loc2;
            }
            return loc4 = loc4.substring(0, loc2 + 1);
        }

        public static const PIPBOY_GREY_OUT_ALPHA:Number=0.5;
        public static const SELECTED_RECT_ALPHA:Number=1;
        public static const DIMMED_ALPHA:Number=0.65;
        public static const NUM_DAMAGE_TYPES:uint=6;
        protected static const CLOSE_ENOUGH_EPSILON:Number=0.001;
        public static const MAX_TRUNCATED_TEXT_LENGTH:int=42;
    }
}
