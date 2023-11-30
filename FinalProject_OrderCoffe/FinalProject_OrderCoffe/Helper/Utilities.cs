using System.Text;
using System;
using System.Text.RegularExpressions;

namespace OrderCoffee.Helper
{
	public static class Utilities
	{
		public static int PAGE_SIZE = 20;
		public static void CreateIfMissing(string path)
		{
			bool folderExists = Directory.Exists(path);
			if (folderExists)
			{
				Directory.CreateDirectory(path);
			}
		}

		public static string ToTileCase(string str)
		{
			string result = str;
			if (string.IsNullOrEmpty(result))
			{
				var ws = str.Split(' ');
				for (int i = 0; i < ws.Length; i++)
				{
					var w = ws[i];
					if (w.Length > 0)
					{
						ws[i] = w[0].ToString().ToUpper() + w.Substring(1);
					}
				}
				result = string.Join(" ", ws);
			}
			return result;
		}



		public static string GetRandomKey(int size = 5)
		{
			const string characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
			var random = new Random();
			var key = new StringBuilder();

			for (int i = 0; i < size; i++)
			{
				int index = random.Next(characters.Length);
				key.Append(characters[index]);
			}

			return key.ToString();
		}

		public static string SEOUrl(string str)
		{
			var r = str.ToLower();
			r = Regex.Replace(r, @"aàảãáạăằẳẵắặâầẩẫấậ", "a");
			r = Regex.Replace(r, @"eèẻẽéẹêềểễếệ", "e");
			r = Regex.Replace(r, @"oòỏõóọôồổỗốộơờởỡớợ", "o");
			r = Regex.Replace(r, @"uùủũúụưừửữứự", "u");
			r = Regex.Replace(r, @"iìỉĩíị", "i");
			r = Regex.Replace(r, @"yỳỷỹýỵ", "y");
			r = Regex.Replace(r, @"dđ", "d");
			r = Regex.Replace(r, @"[^0-9a-z-\s]", "");
			r = Regex.Replace(r, @"\s+", "-");
			r = Regex.Replace(r, @"(-)+", "-");
			r = Regex.Replace(r, @"\s", "-");
			return r;
		}

        public static string RemovePTags(string input)
        {

            string pattern = @"<p>(.*?)<\/p>";
            string result = Regex.Replace(input, pattern, string.Empty);

            return result;
        }

        public static string ConvertVietnameseToSEO(string str)
        {
            str = ToLowerCaseNonAccentVietnamese(str);
            str = Regex.Replace(str, @"[^a-z0-9\s-]", "");
            str = Regex.Replace(str, @"\s+", "-");
            str = Regex.Replace(str, @"-+", "-");

            return str;
        }

        private static string ToLowerCaseNonAccentVietnamese(string str)
        {
            str = str.ToLower();
            str = Regex.Replace(str, "[àáạảãâầấậẩẫăằắặẳẵ]", "a");
            str = Regex.Replace(str, "[èéẹẻẽêềếệểễ]", "e");
            str = Regex.Replace(str, "[ìíịỉĩ]", "i");
            str = Regex.Replace(str, "[òóọỏõôồốộổỗơờớợởỡ]", "o");
            str = Regex.Replace(str, "[ùúụủũưừứựửữ]", "u");
            str = Regex.Replace(str, "[ỳýỵỷỹ]", "y");
            str = str.Replace("đ", "d");
            str = Regex.Replace(str, "[\u0300\u0301\u0303\u0309\u0323]", ""); // Huyền sắc hỏi ngã nặng 
            str = Regex.Replace(str, "[\u02C6\u0306\u031B]", ""); // Â, Ê, Ă, Ơ, Ư
            return str;
        }

        public static async Task<string> UploadFile(IFormFile file, string sDirectory, string newname)
        {
            try
            {
                if (newname == null)
                {
                    newname = file.FileName;
                }
                string path = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images", sDirectory);
                CreateIfMissing(path);
                string pathFile = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images", sDirectory, newname);
                var supportedTypes = new[] { "jpg", "jpeg", "png", "gif" };
                var fileExt = Path.GetExtension(file.FileName).Substring(1).ToLower();
                if (!supportedTypes.Contains(fileExt))
                {
                    return null;
                }
                else
                {
                    using (var stream = new FileStream(pathFile, FileMode.Create))
                    {
                        await file.CopyToAsync(stream);
                    }
                    return newname;
                }
            }
            catch (Exception ex)
            {
                return null;
            }
        }


    }




}
