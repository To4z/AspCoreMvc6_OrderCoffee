using System.Runtime.CompilerServices;
using System.Text.RegularExpressions;
using Humanizer;

namespace OrderCoffee.Extension
{
	public static class Extension
	{
		public static string ToVnd(this double donGia)
		{
			return donGia.ToString("#,##0") + " đ";
		}

		public static string ToTileCase(string str)
		{
			string result = str;
			if (string.IsNullOrEmpty(result))
			{
				var ws = str.Split(' ');
				for(int i =0; i < ws.Length; i++) {
					var w = ws[i];
					if(w.Length > 0)
					{
						ws[i] = w[0].ToString().ToUpper()+ w.Substring(1);
					}
				}
				result = string.Join(" ", ws);
			}
			return result;
		}

		public static string ToUrlFriendly(this string str)
		{
			var r = str.ToLower().Trim();
			r = Regex.Replace(r, "àảãáạăằẳẵắặâầẩẫấậ", "a");
			r = Regex.Replace(r, "èẻẽéẹêềểễếệ", "e");
			r = Regex.Replace(r, "òỏõóọôồổỗốộơờởỡớợ", "o");
			r = Regex.Replace(r, "ùủũúụưừửữứự", "u");
			r = Regex.Replace(r, "ìỉĩíị", "i");
			r = Regex.Replace(r, "ỳỷỹýỵ", "y");
			r = Regex.Replace(r, "đ", "d");
			r = Regex.Replace(r, "[^a-z0-9-]", "");
			r = Regex.Replace(r, "(-)+", "-");

			return r;

		}


	}
}
