

using System.Security.Claims;
using System.Security.Principal;

namespace OrderCoffee.Extension
{
	public static class IdentityExtensions
	{
		public static string GettAccountID(this IIdentity identity)
		{
			var claim = ((ClaimsIdentity) identity).FindFirst("Id");
			return (claim != null) ? claim.Value : string.Empty;
		}

		public static string GettRoleID(this IIdentity identity)
		{
			var claim = ((ClaimsIdentity)identity).FindFirst("RoleId");
			return (claim != null) ? claim.Value : string.Empty;
		}

		public static string GetUserName(this IIdentity identity)
		{
			var claim = ((ClaimsIdentity)identity).FindFirst("UserName");
			return (claim != null) ? claim.Value : string.Empty;
		}

		public static string GetAvatar(this IIdentity identity)
		{
			var claim = ((ClaimsIdentity)identity).FindFirst("Avartar");
			return (claim != null) ? claim.Value : string.Empty;
		}

		public static string GetSpecificClaim(this ClaimsPrincipal claimsPrincipal, string claimType)
		{
			var claim = claimsPrincipal.Claims.FirstOrDefault(c => c.Type == claimType);
			return (claim != null) ? claim.Value : string.Empty;
		}

	}
}
