package global
{
    import mx.utils.StringUtil;

    public class Util
    {
        private static var months:Array = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

        public static function secondsSince(d:Date):Number
        {
            return Number(((new Date().time - d.time) / 1000).toFixed(4));
        }

        public static function minutesSince(d:Date):Number
        {
            return secondsSince(d) / 60;
        }

        public static function hoursSince(d:Date):Number
        {
            return minutesSince(d) / 60;
        }

        public static function daysSince(d:Date):Number
        {
            return hoursSince(d) / 24;
        }

        public static function log(v:*):void
        {
            trace(v);
        }

        public static function toRelativeDate(n:Number):String
        {
            var d:Date = new Date();
            d.time = n;

            var days:int = daysSince(d);
            var hours:int = hoursSince(d);
            var minutes:int = minutesSince(d);

            if (days < 5)
            {
                if (hours < 24)
                {
                    if (minutes < 60)
                    {
                        // Minutes ago
                        return minutes + " minutes ago";
                    } else
                    {
                        // Hours ago
                        return hours + " hours ago";
                    }
                } else
                {
                    // Days ago
                    return days + " days ago";
                }
            }

            // Don't use relative time
            if (days < 360)
                return months[d.month] + " " + d.date;

            // Include the year if it's that long ago
            return months[d.month] + " " + d.date + ", " + d.fullYear;
        }

        public static function toArray(iterable:*):Array
        {
            var arr:Array = [];
            for each (var elem:* in iterable)
                arr.push(elem);
            return arr;
        }

        public static function fixed(n:Number, places:int = 2):Number
        {
            return Number(n.toFixed(places));
        }

        public static function capitalizeFirstLetter(str:String):String
        {
            if (str.length == 0)
                return str;

            if (str.length == 1)
                return str.charAt(0).toUpperCase();
            else
                return str.charAt(0).toUpperCase() + str.substr(1);
        }

        public static function colorBetweenColors(color1:uint = 0xFFFFFF, color2:uint = 0x000000, percent:Number = 0.5):uint
        {
            if (percent < 0)
                percent = 0;
            if (percent > 1)
                percent = 1;

            var r:uint = color1 >> 16;
            var g:uint = color1 >> 8 & 0xFF;
            var b:uint = color1 & 0xFF;

            r += ((color2 >> 16) - r) * percent;
            g += ((color2 >> 8 & 0xFF) - g) * percent;
            b += ((color2 & 0xFF) - b) * percent;

            return (r << 16 | g << 8 | b);
        }

        public static function roundToNearest(n:Number, m:Number):Number
        {
            return int(n / m) * m;
        }

        public static function addZeroToSingleDigitString(str:String):String
        {
            while (str.length < 2)
                str = "0" + str;
            return str;
        }

        public static function readableByteCount(n:Number):String
        {
            for each (var str:String in ["B", "KB", "MB"])
            {
                if (n < 1000)
                    return n + " " + str;
                n = fixed(n / 1000, 1);
            }

            return n + " GB";
        }
    }
}