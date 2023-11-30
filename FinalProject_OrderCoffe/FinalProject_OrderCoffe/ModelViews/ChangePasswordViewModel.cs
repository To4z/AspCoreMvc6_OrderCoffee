using System.ComponentModel.DataAnnotations;

namespace FinalProject_OrderCoffe.ModelViews
{
    public class ChangePasswordViewModel
    {
        [Key]
        public int CustomerId { get; set; }
        [Display(Name = "Mật khẩu hiện tại")]
        public string PasswordNow { get; set; }
        [Display(Name = "Mật khẩu mới")]
        [Required(ErrorMessage = "Vui lòng nhập mật khẩu")]
        [MinLength(6, ErrorMessage = "Bạn cần đặt mật khẩu tối thiểu 6 ký tự")]
        public string Password { get; set; }
        [Display(Name = "Nhập lại mật khẩu mới")]
        [MinLength(6, ErrorMessage = "Bạn cần đặt mật khẩu tối thiểu 6 ký tự")]
        [Compare("Password", ErrorMessage = "Mật khẩu không giống")]
        public string ConfirmPassword { get; set; }

    }
}
