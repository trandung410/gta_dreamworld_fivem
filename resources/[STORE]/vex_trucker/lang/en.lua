if not Lang then Lang = {} end
Lang['en'] = {
	['open'] = "<FONT FACE='Montserrat'>Nhấn ~y~E~w~ để mở",
	['store_truck'] = "<FONT FACE='Montserrat'>Cất giữ xe tải của bạn trước khi sửa chữa",
	['store_truck_2'] = "<FONT FACE='Montserrat'>Cất giữ xe tải của bạn trước khi bán",
	['already_has_truck'] = "<FONT FACE='Montserrat'>Bạn đã có một chiếc xe tải",
	['occupied_places'] = "<FONT FACE='Montserrat'>Tất cả các khe xe tải bị chiếm dụng",
	['truck_blip'] = "<FONT FACE='Montserrat'>Xe tải của bạn",
	['rented_truck_blip'] = "<FONT FACE='Montserrat'>Xe tải cho thuê",
	['cargo_blip'] = "<FONT FACE='Montserrat'>Hàng hóa",
	['destination_blip'] = "<FONT FACE='Montserrat'>Điểm Đến",
	['already_is_in_garage'] = "<FONT FACE='Montserrat'>Xe của bạn đang ở trong nhà để xe của bạn",
	['press_e_to_store_truck'] = '<FONT FACE="Montserrat">~w~Nhấn ~g~[E]~w~ để cất giữ ~b~xe tải~w~.',
	['press_e_to_park'] = '<FONT FACE="Montserrat">~w~Nhấn ~g~[E]~w~ để  ~b~trả hàng~w~.',
	['park_your_truck'] = '<FONT FACE="Montserrat">~w~Đỗ ~b~xe~w~ vào đúng điểm ~y~đỗ~w~.',
	['bring_back'] = '<FONT FACE="Montserrat">~w~Đi ~b~xe tải~w~ trở về ~y~garage~w~.',
	['already_has_cargo'] = "<FONT FACE='Montserrat'>Bạn đã có một giao hàng đang được tiến hành",
	['must_store_truck'] = "<FONT FACE='Montserrat'>Bạn cần cất xe tải của mình trước khi bắt đầu tải trọng này",
	['started_job'] = "<FONT FACE='Montserrat'>Đã bắt đầu giao hàng",
	['success'] = "<FONT FACE='Montserrat'>~g~Thành công",
	['failed'] = "<FONT FACE='Montserrat'>Xe kéo của bạn đã bị phá hủy, bạn không thể vận chuyển hàng hóa",
	['finished_job'] = "<FONT FACE='Montserrat'>Hàng hóa được giao",
	['truck_plate'] = "Trucker",
	
	['driver_failed'] = "<FONT FACE='Montserrat'>Công ty xe tải của bạn không có tiền trả cho tài xế %s, anh ta đã từ chức",
	['own_truck'] = "<FONT FACE='Montserrat'>Bạn cần xe tải của riêng bạn cho công việc này",
	['no_skill_1'] = "<FONT FACE='Montserrat'>Bạn không có khả năng đi quãng đường này",
	['no_skill_2'] = "<FONT FACE='Montserrat'>Bạn không có khả năng vận chuyển hàng nhanh",
	['no_skill_3'] = "<FONT FACE='Montserrat'>Bạn không có khả năng vận chuyển hàng hóa có giá trị cao",
	['no_skill_4'] = "<FONT FACE='Montserrat'>Bạn không có khả năng vận chuyển hàng hóa dễ vỡ",
	['no_skill_5'] = "<FONT FACE='Montserrat'>Bạn không có chứng chỉ ADR cho loại hàng hóa này",
	['job_already_started'] = "<FONT FACE='Montserrat'>Ai đó đã nhận công việc này",
	['upgraded_skill'] = "<FONT FACE='Montserrat'>Kỹ năng được nâng cấp",
	['insufficient_skill_points'] = "<FONT FACE='Montserrat'>Bạn không có điểm kỹ năng",
	['repaired'] = "<FONT FACE='Montserrat'>Phần đã sửa chữa",
	['not_repaired'] = "<FONT FACE='Montserrat'>Phần này không cần sửa chữa",
	['have_no_truck'] = "<FONT FACE='Montserrat'>Bạn không có xe tải nào được chọn",
	['insufficiente_funds'] = "<FONT FACE='Montserrat'>Không đủ tiền trong công ty, gửi thêm tiền",
	['bought'] = "<FONT FACE='Montserrat'>Xe tải đã mua",
	['sold'] = "<FONT FACE='Montserrat'>Xe tải đã bán",
	['hired'] = "<FONT FACE='Montserrat'>Lái xe được thuê",
	['max_drivers'] = "<FONT FACE='Montserrat'>Đã đạt đến giới hạn trình điều khiển tối đa",
	['fired'] = "<FONT FACE='Montserrat'>Lái xe bị sa thải",
	['money_withdrawn'] = "<FONT FACE='Montserrat'>Đã rút tiền",
	['money_deposited'] = "<FONT FACE='Montserrat'>Đã gửi tiền",
	['insufficiente_money'] = "<FONT FACE='Montserrat'>Không đủ tiền",
	['pay_loans'] = "<FONT FACE='Montserrat'>Bạn phải thanh toán các khoản vay của mình trước khi rút tiền",
	['invalid_value'] = "<FONT FACE='Montserrat'>Giá trị không hợp lệ",
	['loan'] = "<FONT FACE='Montserrat'>Khoản vay thực hiện",
	['no_loan'] = "<FONT FACE='Montserrat'>Bạn không thể vay khoản này",
	['loan_paid'] = "<FONT FACE='Montserrat'>Khoản vay đã trả",
	['no_loan_money'] = "<FONT FACE='Montserrat'>Bạn không có tiền để trả khoản vay của mình. Công ty của bạn đã bị đóng cửa",
	['reward'] = "<FONT FACE='Montserrat'>Nhận: $%s<BR>Điều kiện tải: %s%% <BR>EXP: %s",
	['locked'] = "<FONT FACE='Montserrat'>Phương tiện <b>bị khóa</b>.",
	['unlocked'] = "<FONT FACE='Montserrat'>Phương tiện <b>đã được mở khóa</b>.",
	['loading_trailer'] = "<FONT FACE='Montserrat'>Đang tải hàng hóa của bạn, vui lòng đợi",
	['loading_truck'] = "<FONT FACE='Montserrat'>Đang tải xe tải của bạn, vui lòng đợi",
	['loading_fail'] = "<FONT FACE='Montserrat'>Hàng hóa của bạn mất nhiều thời gian hơn bình thường để tải. Thử lại",
	
	['logs_date'] = "Date",
	['logs_hour'] = "Hour",
	['logs_finish'] = "```prolog\n[FINISHED JOB]\n[MONEY] %s\n[EXP] %s \n[ID] %s \r```",
	['logs_skill'] = "```prolog\n[EARNED SKILL POINT]\n[AMOUNT] %s \n[ID] %s \r```",
	['logs_buytruck'] = "```prolog\n[BOUGHT TRUCK]\n[TRUCK NAME] %s \n[PRICE] %s \n[ID] %s \r```",
	['logs_selltruck'] = "```prolog\n[TRUCK SOLD]: %s\n[RECEIVED]: %s\n[ID] %s \r```",
}