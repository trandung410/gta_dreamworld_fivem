$(function() {
    const timer = ms => new Promise(res => setTimeout(res, ms))
    window.addEventListener('message', async function(event) {
        if (event.data.type == 'shop') {
            $('.container').fadeIn();
            $(".header").fadeIn();

            var i1;
            var id = 750;

            if (event.data.result.length > 10) {
                for (i1 = 0; i1 < (event.data.result.length - 10) / 5; i1++) {

                    /* $('#wrapper').append(
                    	`<div class="line" style = "top: ${id}px; position: relative;"></div>`
                    ); */

                    id = id + 375
                }
            }

            var i;
            for (i = 0; i < event.data.result.length; i++) {
                await timer(100);
                var dongco = Math.floor(event.data.result[i].vehicle.engineHealth / 1000 * 100) || 100
                var thanxe = Math.floor(event.data.result[i].vehicle.bodyHealth / 1000 * 100) || 100

                /* var dongco = 100;
                var thanxe = 100; */
                console.log(event.data.result[i].imgSrc)
                var src = "https://i.imgur.com/XPsSqqr.png";
                var src2 = "https://i.imgur.com/V4EPFoP.png";
                console.log(event.data.result[i].impound)
                if (event.data.result[i].impound == "0"){
                    if (event.data.result[i].stored == '1') {
                        if (event.data.result[i].vehicleType == '8') {
                            $('#wrapper').append(
                                `<div class = "item in-garage animate__animated animate__fadeInRight" id = ${i} >
                                    <div class = "row">
                                        <div class = "col-6 text-center">
                                            <img src="${event.data.result[i].imgSrc}" class="rounded"/>
                                        </div>
                                        <div class = "col-6 text-white">
                                            <div class = "row">
                                                <h3 class = "h5">🚘 ${event.data.result[i].name} <button type="button" id="changename" number=${i} class="btn btn-warning px-3 justify-content-end"><i class="fas fa-pen-alt" aria-hidden="true"></i></button></h3>
                                            </div>
                                            <div class = "row">
                                            <h6 class = "h6">💳 Biển Số: <span style="color: #03adfc">${event.data.result[i].plate}</span></h5>
                                            
                                            </div>
                                            <div class = "row">
                                                <h6 class = "h6">Động cơ: ${dongco}%	 Thân xe: ${thanxe}%</h5>
                                            </div>
                                            <div class = "row">
                                                <button type="button" class="btn btn-success" id = "buybutton" number = ${i}><i class="fas fa-check" aria-hidden="true"></i> Lấy</button>
                                                <button type="button" class="btn btn-danger" id = "delete" number = ${i} ><i class="fas fa-trash-alt" aria-hidden="true"></i> Xóa</button>
                                                </div>
                                        </div>
                                    </div>
                                </div>`
                            );
                        } else {
                            $('#wrapper').append(
                                `<div class = "item in-garage animate__animated animate__fadeInRight" id = ${i} >
                                    <div class = "row">
                                        <div class = "col-6 text-center">
                                            <img src="${event.data.result[i].imgSrc}" class="rounded"/>
                                        </div>
                                        <div class = "col-6 text-white">
                                            <div class = "row">
                                                <h3 class = "h5">🚘 ${event.data.result[i].name} <button type="button" id="changename" number=${i} class="btn btn-warning px-3 justify-content-end"><i class="fas fa-pen-alt" aria-hidden="true"></i></button></h3>
                                            </div>
                                            <div class = "row">
                                            <h6 class = "h6">💳 Biển Số: <span style="color: #03adfc">${event.data.result[i].plate}</span></h5>
                                            
                                            </div>
                                            <div class = "row">
                                                <h6 class = "h6">Động cơ: ${dongco}%	 Thân xe: ${thanxe}%</h5>
                                            </div>
                                            <div class = "row">
                                                <button type="button" class="btn btn-success" id = "buybutton" number = ${i}><i class="fas fa-check" aria-hidden="true"></i> Lấy</button>
                                                <button type="button" class="btn btn-danger" id = "delete" number = ${i} ><i class="fas fa-trash-alt" aria-hidden="true"></i> Xóa</button>
                                                </div>
                                        </div>
                                    </div>
                                </div>`
                            );
                        } /* <i class="fas fa-check"></i> */
                    } else {
                        if (event.data.result[i].vehicleType == '8') {
                            $('#wrapper').append(
                                `<div class = "item out-garage animate__animated animate__fadeInRight" id = ${i} >
                                    <div class = "row">
                                        <div class = "col-6 text-center">
                                            <img src="${event.data.result[i].imgSrc}" class="rounded"/>
                                        </div>
                                        <div class = "col-6 text-white">
                                            <div class = "row">    
    
                                                <h3 class = "h5">🚘 ${event.data.result[i].name} <button type="button" id="changename" number=${i} class="btn btn-warning px-3"><i class="fas fa-pen-alt" aria-hidden="true"></i></button></h3>
                                            </div>
                                            <div class = "row">
                                            <h6 class = "h6">💳 Biển Số: <span style="color: #03adfc">${event.data.result[i].plate}</span></h5>
                                            
                                            </div>
                                            <div class = "row">
                                                <h6 class = "h6">Động cơ: ${dongco}%	 Thân xe: ${thanxe}%</h5>
                                            </div>
                                            <div class = "row">
                                                <button type="button" class="btn btn-danger" id = "buybutton" number = ${i} ><i class="fas fa-undo" aria-hidden="true"></i> Chuộc</button>
                                                <button type="button" class="btn btn-danger" id = "delete" number = ${i} ><i class="fas fa-trash-alt" aria-hidden="true"></i> Xóa</button>
                                                </div>
                                        </div>
                                    </div>
                                </div>`
                            );
                        } else {
                            $('#wrapper').append(
                                `<div class = "item out-garage animate__animated animate__fadeInRight " id = ${i} >
                                    <div class = "row">
                                        <div class = "col-6 text-center">
                                            <img src="${event.data.result[i].imgSrc}" class="rounded"/>
                                        </div>
                                        <div class = "col-6 text-white">
                                            <div class = "row">    
    
                                                <h3 class = "h5">🚘 ${event.data.result[i].name} <button type="button" id="changename" number=${i} class="btn btn-warning px-3 justify-content-end"><i class="fas fa-pen-alt" aria-hidden="true"></i></button></h3>
                                            </div>
                                            <div class = "row">
                                            <h6 class = "h6">💳 Biển Số: <span style="color: #03adfc">${event.data.result[i].plate}</span></h5>
                                            
                                            </div>
                                            <div class = "row">
                                                <h6 class = "h6">Động cơ: ${dongco}%	 Thân xe: ${thanxe}%</h5>
                                            </div>
                                            <div class = "row">
                                                <button type="button" class="btn btn-danger" id = "buybutton" number = ${i} ><i class="fas fa-undo" aria-hidden="true"></i> Chuộc</button>
                                                <button type="button" class="btn btn-danger" id = "delete" number = ${i} ><i class="fas fa-trash-alt" aria-hidden="true"></i> Xóa</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>`
                            );
                        }
                    }
                }else{
                    $('#wrapper').append(
                        `<div class = "item impound animate__animated animate__fadeInRight " id = ${i} >
                            <div class = "row">
                                <div class = "col-6 text-center">
                                    <img src="${event.data.result[i].imgSrc}" class="rounded"/>
                                </div>
                                <div class = "col-6 text-white">
                                    <div class = "row">    

                                        <h3 class = "h5">🚘 ${event.data.result[i].name} <button type="button" id="changename" number=${i} class="btn btn-warning px-3 justify-content-end"><i class="fas fa-pen-alt" aria-hidden="true"></i></button></h3>
                                    </div>
                                    <div class = "row">
                                    <h6 class = "h6">💳 Biển Số: <span style="color: #03adfc">${event.data.result[i].plate}</span></h5>
                                    <h6 class = "h6"><span class="text-danger">BỊ GIAM BỞI CẢNH SÁT</span></h5>
                                    </div>
                                    <div class = "row">
                                        <h6 class = "h6">Động cơ: ${dongco}%	 Thân xe: ${thanxe}%</h5>
                                    </div>
                                    <div class = "row">
                                        <button type="button" class="btn btn-danger" id = "unimpound" number = ${i} ><i class="fas fa-undo" aria-hidden="true"></i> Chuộc</button>
                                    </div>
                                </div>
                            </div>
                        </div>`
                    );
                }
                
            }

            $('#wrapper').append(
                ` <h6 class = "h4" style = "right: 47.125%; position: absolute;" bottom = ${id - 5}></h6>`
            )

            $("body").on("click", "#changename", function() {
                var number = $(this).attr('number');
                $("#wrapper").fadeOut();
                $("#confirm").fadeOut();
                $(".header").fadeOut();
                $("#change-name").empty();
                $("#change-name").append(
                    `	<div class="d-flex justify-content-center ">
							<div class="col-2 changename">
								<div class="row justify-content-center">
									<h3 class = "h4">🚘 ${event.data.result[number].name} 
								</div>
								<div class="row justify-content-center">
									<h6 class = "h6">💳 Biển Số: <span style="color: #03adfc">${event.data.result[number].plate}</span></h5>
                                    
								</div>
								<div class="row justify-content-center form__group">
									<input type="text" id = 'new-name' class = "form__input" placeholder = "Nhập Tên Mới"></textarea>
								</div>
								<div class="row justify-content-center">
									<button class = "button btn btn-success" id = "accept" number = ${number} style = "style= width: 70px">Xác nhận</button>
									<button class = "button btn btn-danger" id = "back" style = "style= width: 70px">Trở về</button>
								</div>
							</div>
						</div>
						
					`
                );
                $("#change-name").fadeIn();
            });

            $("body").on("click", "#unimpound", function() {
                var number = $(this).attr('number');
                $("#wrapper").fadeOut();
                $(".header").fadeOut();
                $("#change-name").fadeOut();
                $("#confirm").empty();
                $.post("https://lr_garage/Unimpound", JSON.stringify({
                    plate : event.data.result[number].plate
                }), function(result){
                    $("#confirm").append(
                        `	<div class="d-flex justify-content-center ">
                                <div class="col-2 changename">
                                    <div class="row justify-content-center">
                                        <h3 class = "h4">🚘 ${event.data.result[number].name} 
                                    </div>
                                    <div class="row justify-content-center">
                                        <h6 class = "h6">💳 Biển Số: <span style="color: #03adfc">${event.data.result[number].plate}</span></h5>
                                    </div>
                                    <div class="row justify-content-center">
                                        <h6 class = "h6">Bị giam bởi: <span style="color: #03adfc">${result.officer}</span></h5>
                                    </div>
                                    <div class="row justify-content-center">
                                        <h6 class = "h6">Lý Do: <span style="color: #323232">${result.reason}</span></h5>
                                    </div>
                                    <div class="row justify-content-center form__group">
                                        <h5 class="text-danger text-center text-bold">Chuộc phương tiện với giá ${result.fine}?</h5>
                                    </div>
                                    <div class="row justify-content-center">
                                        <button class = "button btn btn-success" id = "accept-unimpound" number = ${number} style = "style= width: 70px">Đồng ý</button>
                                        <button class = "button btn btn-danger" id = "back" style = "style= width: 70px">Trở về</button>
                                    </div>
                                </div>
                            </div>
                            
                        `
                    );
                    $("#confirm").fadeIn();
                })
                
            });
            $("body").on("click", "#delete", function() {
                var number = $(this).attr('number');
                $("#wrapper").fadeOut();
                $(".header").fadeOut();
                $("#change-name").fadeOut();
                $("#confirm").empty();
                $("#confirm").append(
                    `	<div class="d-flex justify-content-center ">
							<div class="col-2 changename">
								<div class="row justify-content-center">
									<h3 class = "h4">🚘 ${event.data.result[number].name} 
								</div>
								<div class="row justify-content-center">
									<h6 class = "h6">💳 Biển Số: <span style="color: #03adfc">${event.data.result[number].plate}</span></h5>
								</div>
								<div class="row justify-content-center form__group">
									<h5 class="text-danger text-center text-bold">Bạn Có Chắc Chắn Muốn Xóa Phương Tiện Này?</h5>
								</div>
								<div class="row justify-content-center">
									<button class = "button btn btn-success" id = "accept-delete" number = ${number} style = "style= width: 70px">Đồng ý</button>
									<button class = "button btn btn-danger" id = "back" style = "style= width: 70px">Trở về</button>
								</div>
							</div>
						</div>
						
					`
                );
                $("#confirm").fadeIn();
            });
            $("body").on("click", "#accept", function() {
                var number = $(this).attr('number');
                var newName = $("#new-name").val();
                console.log(newName);
                var plate = event.data.result[number].plate;
                $.post('https://lr_garage/escape', JSON.stringify({}));
                location.reload(true);
                $('#wrapper').hide("fast");
                $.post('https://lr_garage/changeName', JSON.stringify({ plate: plate, newName: newName }))

                /*  console.log(plate) */
            })
            $("body").on("click", "#accept-delete", function() {
                var number = $(this).attr('number');
                var plate = event.data.result[number].plate;
                $.post('https://lr_garage/escape', JSON.stringify({}));
                location.reload(true);
                $('#wrapper').hide("fast");
                $.post('https://lr_garage/deleteVehicle', JSON.stringify({ plate: plate }))

                /*  console.log(plate) */
            })
            $("body").on("click", "#accept-unimpound", function() {
                var number = $(this).attr('number');
                var plate = event.data.result[number].plate;
                var vehicle = event.data.result[number].value.vehicle;
                $.post('https://lr_garage/escape', JSON.stringify({}));
                location.reload(true);
                $('#wrapper').hide("fast");
                $.post('https://lr_garage/unimpoundVehice', JSON.stringify({ vehicle: vehicle, plate: plate }))

                /*  console.log(plate) */
            })
            $("body").on("click", "#back", function() {
                $("#change-name").fadeOut();
                $("#confirm").fadeOut();
                $(".header").fadeIn();
                $("#wrapper").fadeIn();
            })
            $("body").on("click", "#buybutton", function() {
                console.log("asdasd");
                var number = $(this).attr('number');
                var vehicle = event.data.result[number].value.vehicle;
                var plate = event.data.result[number].plate;
                var stored = event.data.result[number].stored;
                if (stored == '1') {
                    $.post('https://lr_garage/spawnVehicle', JSON.stringify({ vehicle: vehicle, plate: plate }));
                    $.post('https://lr_garage/escape', JSON.stringify({}));
                    location.reload(true);
                    $('#wrapper').hide("fast");
                } else {
                    $.post('https://lr_garage/returnVehicle', JSON.stringify({ vehicle: vehicle, plate: plate }));
                    $.post('https://lr_garage/escape', JSON.stringify({}));
                    location.reload(true);
                    $('#wrapper').hide("fast");
                }
                /* for (i = 0; i < value.length; i++) {

                	var isNumber = isNaN(value[i].value) === false;

                	var count = $('#' + value[i].id).attr('count');

                	if (parseInt(count) >= parseInt(value[i].value) && parseInt(value[i].value) != 0 && isNumber) {

                		$.post('https://lr_garage/escape', JSON.stringify({}));
                	
                		location.reload(true);

                		$('#wrapper').hide("fast");
                		$('#payment').hide("fast");
                		$('#cart').hide("fast");
                		$.post('https://lr_garage/buy', JSON.stringify({Count : value[i].value, Item : value[i].id}));
                	} 
                	else {
                		$.post('https://lr_garage/notify', JSON.stringify({msg : "~r~One of the item does not have enough stock or the amount is invalid."}));
                	}`
                } */
            });


            $("body").on("click", "#bossactions", function() {
                $.post('https://lr_garage/bossactions', JSON.stringify({}));
                $.post('https://lr_garage/escape', JSON.stringify({}));
                location.reload(true);
                $.post('https://lr_garage/emptycart', JSON.stringify({}));
                $('#wrapper').hide("fast");
                $('#payment').hide("fast");
                $('#cart').hide("fast");
            });
        }
    });




    document.onkeyup = function(data) {
        if (data.which == 27) { // Escape key
            $.post('https://lr_garage/escape', JSON.stringify({}));
            location.reload(true);
            $('#wrapper').hide("fast");
            $('#payment').hide("fast");
            $('#cart').hide("fast");
        }
    }
});