package utils;

/**
 * The `ConsoleColors` class provides static methods to format strings with ANSI escape codes for console colors and styles.
 * Writen by: @galleniz
 * @author GalleNiz
 */
class ConsoleColors
{
	/**
	 * Formats the given string with red color.
	 * @param string The input string.
	 * @return The formatted string with red color.
	 */
	public static function red(string:String):String
	{
		return "\u001B[31m" + string + "\u001B[0m";
	}

	/**
	 * Formats the given string with green color.
	 * @param string The input string.
	 * @return The formatted string with green color.
	 */
	public static function green(string:String):String
	{
		return "\u001B[32m" + string + "\u001B[0m";
	}

	/**
	 * Formats the given string with yellow color.
	 * @param string The input string.
	 * @return The formatted string with yellow color.
	 */
	public static function yellow(string:String):String
	{
		return "\u001B[33m" + string + "\u001B[0m";
	}

	/**
	 * Formats the given string with blue color.
	 * @param string The input string.
	 * @return The formatted string with blue color.
	 */
	public static function blue(string:String):String
	{
		return "\u001B[34m" + string + "\u001B[0m";
	}

	/**
	 * Formats the given string with purple color.
	 * @param string The input string.
	 * @return The formatted string with purple color.
	 */
	public static function purple(string:String):String
	{
		return "\u001B[35m" + string + "\u001B[0m";
	}

	/**
	 * Formats the given string with cyan color.
	 * @param string The input string.
	 * @return The formatted string with cyan color.
	 */
	public static function cyan(string:String):String
	{
		return "\u001B[36m" + string + "\u001B[0m";
	}

	/**
	 * Formats the given string with white color.
	 * @param string The input string.
	 * @return The formatted string with white color.
	 */
	public static function white(string:String):String
	{
		return "\u001B[37m" + string + "\u001B[0m";
	}

	/**
	 * Formats the given string with black color.
	 * @param string The input string.
	 * @return The formatted string with black color.
	 */
	public static function black(string:String):String
	{
		return "\u001B[30m" + string + "\u001B[0m";
	}

	/**
	 * Formats the given string with bold style.
	 * @param string The input string.
	 * @return The formatted string with bold style.
	 */
	public static function bold(string:String):String
	{
		return "\u001B[1m" + string + "\u001B[0m";
	}

	/**
	 * Formats the given string with underline style.
	 * @param string The input string.
	 * @return The formatted string with underline style.
	 */
	public static function underline(string:String):String
	{
		return "\u001B[4m" + string + "\u001B[0m";
	}

	/**
	 * Formats the given string with red background color.
	 * @param string The input string.
	 * @return The formatted string with red background color.
	 */
	public static function backgroundRed(string:String):String
	{
		return "\u001B[41m" + string + "\u001B[0m";
	}

	/**
	 * Formats the given string with green background color.
	 * @param string The input string.
	 * @return The formatted string with green background color.
	 */
	public static function backgroundGreen(string:String):String
	{
		return "\u001B[42m" + string + "\u001B[0m";
	}

	/**
	 * Formats the given string with yellow background color.
	 * @param string The input string.
	 * @return The formatted string with yellow background color.
	 */
	public static function backgroundYellow(string:String):String
	{
		return "\u001B[43m" + string + "\u001B[0m";
	}

	/**
	 * Formats the given string with blue background color.
	 * @param string The input string.
	 * @return The formatted string with blue background color.
	 */
	public static function backgroundBlue(string:String):String
	{
		return "\u001B[44m" + string + "\u001B[0m";
	}

	/**
	 * Formats the given string with purple background color.
	 * @param string The input string.
	 * @return The formatted string with purple background color.
	 */
	public static function backgroundPurple(string:String):String
	{
		return "\u001B[45m" + string + "\u001B[0m";
	}

	/**
	 * Formats the given string with cyan background color.
	 * @param string The input string.
	 * @return The formatted string with cyan background color.
	 */
	public static function backgroundCyan(string:String):String
	{
		return "\u001B[46m" + string + "\u001B[0m";
	}

	/**
	 * Formats the given string with white background color.
	 * @param string The input string.
	 * @return The formatted string with white background color.
	 */
	public static function backgroundWhite(string:String):String
	{
		return "\u001B[47m" + string + "\u001B[0m";
	}

	/**
	 * Formats the given string with black background color.
	 * @param string The input string.
	 * @return The formatted string with black background color.
	 */
	public static function backgroundBlack(string:String):String
	{
		return "\u001B[40m" + string + "\u001B[0m";
	}

	/**
	 * Formats the given string with bold style and default color.
	 * @param string The input string.
	 * @return The formatted string with bold style and default color.
	 */
	public static function backgroundBold(string:String):String
	{
		return "\u001B[1m" + string + "\u001B[0m";
	}

	/**
	 * Formats the given string with underline style and default color.
	 * @param string The input string.
	 * @return The formatted string with underline style and default color.
	 */
	public static function backgroundUnderline(string:String):String
	{
		return "\u001B[4m" + string + "\u001B[0m";
	}

	/**
	 * Resets the formatting of the given string to default.
	 * @param string The input string.
	 * @return The formatted string with default formatting.
	 */
	public static function reset(string:String):String
	{
		return "\u001B[0m" + string + "\u001B[0m";
	}
}
