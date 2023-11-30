using System.ComponentModel.DataAnnotations;

namespace FinalProject_OrderCoffe.ModelViews
{
    public class MuaHangViewModel
    {
        public int CustomerId { get; set; }
        [Required(ErrorMessage = "Vui lòng nhập họ và tên")]
        public string FullName { get; set; }
        public string Email { get; set; }
        [Required(ErrorMessage = "Vui lòng nhập số điện thoại")]
        public string Phone { get; set; }
        [Required(ErrorMessage = "Vui lòng nhập địa chỉ")]
        public string Address { get; set; }
        [Required(ErrorMessage = "Vui lòng nhập Tỉnh/Thành")]
        public string TinhThanh { get; set; }
        [Required(ErrorMessage = "Vui lòng nhập Quận/Huyện")]
        public string QuanHuyen { get; set; }
        [Required(ErrorMessage = "Vui lòng nhập Phường/Xã")]
        public string PhuongXa { get; set; }
        public int PaymentID { get; set; }
        public string Note { get; set; }


    }
}
