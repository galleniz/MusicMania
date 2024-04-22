package utils;

import haxe.Log;
import haxe.PosInfos;

class Console
{
	public static function get()
	{
		return new Console();
	}

	private function new() {}

	public var allowDebug = #if debug true #else false #end;

	private function resolveInfos(infos:PosInfos):Null<String>
	{
		if (infos == null)
			return "Unknown:0 Unknown.Unknown";
		var file = infos.fileName;
		var line = infos.lineNumber;
		var className = infos.className;
		var methodName = infos.methodName;
		var customParams = infos.customParams;
		return file + ":" + line + " " + className + "." + methodName;
	}

	private function resolveValue(v:Dynamic):String
	{
		if (v == null)
			return "undefined";
		if (v is String)
			return v;
		// if v is an array or object, transform it to a string
		if (v is Dynamic)
		{
			var str = "";
			if (!(v is Array))
			{
				for (field in Reflect.fields(v))
				{
					str += field + ": " + resolveValue(Reflect.field(v, field)) + ", ";
				}
			}
			else
			{
				for (i in 0...v.length)
				{
					str += resolveValue(v[i]) + ", ";
				}
			}
			return "{" + str + "}";
		}
		return "[object]";
	}

	public function log(v:Dynamic, ?infos:PosInfos):Void
	{
		Client.pushLog('[LOG] [${resolveInfos(infos)}] ${resolveValue(v)}');

		Sys.println(ConsoleColors.cyan("[LOG]") + ('[${ConsoleColors.green(resolveInfos(infos))}]') + " " + resolveValue(v));
	}

	public function info(v:Dynamic, ?infos:PosInfos):Void
	{
		Client.pushLog('[INFO] [${resolveInfos(infos)}] ${resolveValue(v)}');

		Sys.println(ConsoleColors.blue("[INFO]") + ('[${ConsoleColors.green(resolveInfos(infos))}]') + " " + resolveValue(v));
	}

	public function warn(v:Dynamic, ?infos:PosInfos):Void
	{
		Client.pushLog('[WARN] [${resolveInfos(infos)}] ${resolveValue(v)}');

		Sys.println(ConsoleColors.yellow("[WARN]") + ('[${ConsoleColors.green(resolveInfos(infos))}]') + " " + resolveValue(v));
	}

	public function error(v:Dynamic, ?infos:PosInfos):Void
	{
		Client.pushLog('[ERROR] [${resolveInfos(infos)}] ${resolveValue(v)}');
		Sys.println(ConsoleColors.red("[ERROR]") + ('[${ConsoleColors.green(resolveInfos(infos))}]') + " " + resolveValue(v));
	}

	public function debug(v:Dynamic, ?infos:PosInfos):Void
	{
		Client.pushLog('[DEBUG] [${resolveInfos(infos)}] ${resolveValue(v)}');

		if (allowDebug)
			Sys.println(ConsoleColors.purple("[DEBUG]") + ('[${ConsoleColors.green(resolveInfos(infos))}]') + " " + resolveValue(v));
	}
}
