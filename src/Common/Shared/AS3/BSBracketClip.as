package Shared.AS3 
{
    import flash.display.*;
    import flash.geom.*;
    
    public dynamic class BSBracketClip extends flash.display.MovieClip
    {
        public function BSBracketClip()
        {
            super();
        }

        public function BracketPair():*
        {
            
        }

        public function ClearBrackets():*
        {
            graphics.clear();
        }

        public function redrawUIComponent(arg1:Shared.AS3.BSUIComponent, arg2:Number, arg3:Number, arg4:flash.geom.Point, arg5:String):*
        {
            this._clipRect = arg1.getBounds(arg1);
            this._lineThickness = arg2;
            this._cornerLength = arg3;
            this._padding = arg4;
            this._clipRect.inflatePoint(this._padding);
            this._style = arg5;
            this.ClearBrackets();
            graphics.lineStyle(this._lineThickness, 16777215, 1, false, "normal", flash.display.CapsStyle.SQUARE, flash.display.JointStyle.MITER, 3);
            var loc1:*=this._style;
            switch (loc1) 
            {
                case BR_HORIZONTAL:
                {
                    this.doHorizontal();
                    break;
                }
                case BR_VERTICAL:
                {
                    this.doVertical();
                    break;
                }
                case BR_CORNERS:
                {
                    this.doCorners();
                    break;
                }
                case BR_FULL:
                {
                    this.doFull();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }

        internal function doHorizontal():*
        {
            this._drawPos = new flash.geom.Point(this._clipRect.left + this._cornerLength, this._clipRect.top);
            this.moveTo();
            this.LineX(this._clipRect.left);
            this.LineY(this._clipRect.bottom);
            this.LineX(this._clipRect.left + this._cornerLength);
            this.MoveX(this._clipRect.right - this._cornerLength);
            this.LineX(this._clipRect.right);
            this.LineY(this._clipRect.top);
            this.LineX(this._clipRect.right - this._cornerLength);
        }

        internal function doVertical():*
        {
            this._drawPos = new flash.geom.Point(this._clipRect.left, this._clipRect.top + this._cornerLength);
            this.moveTo();
            this.LineY(this._clipRect.top);
            this.LineX(this._clipRect.right);
            this.LineY(this._clipRect.top + this._cornerLength);
            this.MoveY(this._clipRect.bottom - this._cornerLength);
            this.LineY(this._clipRect.bottom);
            this.LineX(this._clipRect.left);
            this.LineY(this._clipRect.bottom - this._cornerLength);
        }

        internal function doCorners():*
        {
            this._drawPos = new flash.geom.Point(this._clipRect.left + this._cornerLength, this._clipRect.top);
            this.moveTo();
            this.LineX(this._clipRect.left);
            this.LineY(this._clipRect.top + this._cornerLength);
            this.MoveY(this._clipRect.bottom - this._cornerLength);
            this.LineY(this._clipRect.bottom);
            this.LineX(this._clipRect.left + this._cornerLength);
            this.MoveX(this._clipRect.right - this._cornerLength);
            this.LineX(this._clipRect.right);
            this.LineY(this._clipRect.bottom - this._cornerLength);
            this.MoveY(this._clipRect.top + this._cornerLength);
            this.LineY(this._clipRect.top);
            this.LineX(this._clipRect.right - this._cornerLength);
        }

        internal function doFull():*
        {
            this._drawPos = new flash.geom.Point(this._clipRect.left, this._clipRect.top);
            this.moveTo();
            this.LineY(this._clipRect.bottom);
            this.LineX(this._clipRect.right);
            this.LineY(this._clipRect.top);
            this.LineX(this._clipRect.left);
        }

        internal function LineX(arg1:Number):*
        {
            this._drawPos.x = arg1;
            this.lineTo();
        }

        internal function LineY(arg1:Number):*
        {
            this._drawPos.y = arg1;
            this.lineTo();
        }

        internal function MoveX(arg1:Number):*
        {
            this._drawPos.x = arg1;
            this.moveTo();
        }

        internal function MoveY(arg1:Number):*
        {
            this._drawPos.y = arg1;
            this.moveTo();
        }

        internal function lineTo():*
        {
            graphics.lineTo(this._drawPos.x, this._drawPos.y);
        }

        internal function moveTo():*
        {
            graphics.moveTo(this._drawPos.x, this._drawPos.y);
        }

        static const BR_HORIZONTAL:String="horizontal";
        static const BR_VERTICAL:String="vertical";
        static const BR_CORNERS:String="corners";
        static const BR_FULL:String="full";
        internal var _drawPos:flash.geom.Point;
        internal var _clipRect:flash.geom.Rectangle;
        internal var _lineThickness:Number;
        internal var _cornerLength:Number;
        internal var _padding:flash.geom.Point;
        internal var _style:String;
    }
}
