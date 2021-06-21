window.addEventListener('message', function (event) {
	var item = event.data;
	if (item.showmenu){
		var config = item.dados.config;
		if(item.update != true){
			$(".container-content").css("display", "");
			$(".container-page-main").css("display", "");
			$(".container-page-ressuply").css("display", "none");
			$(".container-page-stock").css("display", "none");
			$(".container-page-staff").css("display", "none");
			$(".container-page-upgrades").css("display", "none");
		}

		$('.container-header').empty();
		$('.container-header').append('<img class="title-img" src="' + config.logo + '" alt="img">');
		$('.container-header').append('<div class="container-title"><span class="title">LOCAL:</span><span class="subtitle">' + config.nome + '</span></div>');

		$('.page-main').empty();
		$('.page-main').append('<div class="main-itens"><span class="itens-title">Total earnings</span><span class="itens-value">' + new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(item.dados.ganhos) + '</span></div><div class="main-itens"><span class="itens-title">Total Sales</span><span class="itens-value">' + new Intl.NumberFormat('en-US').format(item.dados.vendas) + '</span></div>');

		$('.list-staff').empty();
		if(item.dados.funcionarios == 0){
			$('.list-staff').append('<label class="container-checkbox">Allocate employees for manufacturing<input type="radio" checked="checked" name="radio" onclick="alocar(0)"><span class="checkmark"></span></label>');
			$('.list-staff').append('<label class="container-checkbox">Allocate employees for research<input type="radio" name="radio" onclick="alocar(1)"><span class="checkmark"></span></label>');
			$('.list-staff').append('<label class="container-checkbox">Allocate employees to both<input type="radio" name="radio" onclick="alocar(2)"><span class="checkmark"></span></label>');
		}else if(item.dados.funcionarios == 1){
			$('.list-staff').append('<label class="container-checkbox">Allocate employees for manufacturing<input type="radio" name="radio" onclick="alocar(0)"><span class="checkmark"></span></label>');
			$('.list-staff').append('<label class="container-checkbox">Allocate employees for research<input type="radio" checked="checked" name="radio" onclick="alocar(1)"><span class="checkmark"></span></label>');
			$('.list-staff').append('<label class="container-checkbox">Allocate employees to both<input type="radio" name="radio" onclick="alocar(2)"><span class="checkmark"></span></label>');
		}else if(item.dados.funcionarios == 2){
			$('.list-staff').append('<label class="container-checkbox">Allocate employees for manufacturing<input type="radio" name="radio" onclick="alocar(0)"><span class="checkmark"></span></label>');
			$('.list-staff').append('<label class="container-checkbox">Allocate employees for research<input type="radio" name="radio" onclick="alocar(1)"><span class="checkmark"></span></label>');
			$('.list-staff').append('<label class="container-checkbox">Allocate employees to both<input type="radio" checked="checked" name="radio" onclick="alocar(2)"><span class="checkmark"></span></label>');
		}

		$('#upgrade-data1').empty();
		if(item.dados.upgrade1 == 0){
			$('#upgrade-data1').append('<span>Upgrade equipment</span><span style="font-size: 12px">More supplies space</span><button onclick="upgrades(1)">' + new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(config.valor_evoluir_equipamentos) + '</button>');
		}else{
			$('#upgrade-data1').append('<span>Upgrade equipment</span><span class="comprado">PURCHASED</span>');
		}
		$('#upgrade-data2').empty();
		if(item.dados.upgrade2 == 0){
			$('#upgrade-data2').append('<span>Upgrade employees</span><span style="font-size: 12px">Improves production</span><button onclick="upgrades(2)">' + new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(config.valor_evoluir_funcionarios) + '</button>');
		}else{
			$('#upgrade-data2').append('<span>Upgrade employees</span><span class="comprado">PURCHASED</span>');
		}
		$('#upgrade-data3').empty();
		if(item.dados.upgrade3 == 0){
			$('#upgrade-data3').append('<span>Upgrade security</span><span style="font-size: 11px">Reduces the chance of being plundered</span><button onclick="upgrades(3)">' + new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(config.valor_evoluir_seguranca) + '</button>');
		}else{
			$('#upgrade-data3').append('<span>Upgrade security</span><span class="comprado">PURCHASED</span>');
		}

		$('#comprar-suprimento-button').empty();
		$('#comprar-suprimento-button').append('Purchase ' + config.quantidade_compra_suprimentos + ' supplies ' + new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(config.valor_comprar_suprimentos));

		$('#vender-suprimento-button1').empty();
		$('#vender-suprimento-button1').append('Sell ' + item.dados.qtd_blaine + ' to Blaine Country ' + new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(item.dados.blaine));

		$('#vender-suprimento-button2').empty();
		$('#vender-suprimento-button2').append('Sell ' + item.dados.qtd_lossantos + ' to Los Santos ' + new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(item.dados.lossantos));


		$('.status').empty();
		$('.status').append('Company status: <span style="color: #ff0000">ACTIVE</span>');
		$('.container-bars').empty();
		$('.container-bars').append('<div class="bars"><label class="bar-label" for="file">Products (' + item.dados.produtos + '/' + config.max_estoque_produtos + '):</label><progress class="bar-blue" id="file" value="' + item.dados.produtos + '" max="' + config.max_estoque_produtos + '"></progress></div>');
		$('.container-bars').append('<div class="bars"><label class="bar-label" for="file2">Research (' + item.dados.pesquisa + '/' + config.max_estoque_pesquisa + '):</label><progress class="bar-green" id="file2" value="' + item.dados.pesquisa + '" max="' + config.max_estoque_pesquisa + '"></progress></div>');
		$('.container-bars').append('<div class="bars"><label class="bar-label" for="file3">Supplies (' + item.dados.suprimentos + '/' + config.max_estoque_suprimentos + '):</label><progress class="bar-orange" id="file3" value="' + item.dados.suprimentos + '" max="' + config.max_estoque_suprimentos + '"></progress></div>');
	}
	if (item.hidemenu){
		$(".container-content").css("display", "none");
	}
});

function log(d){
	console.log(JSON.stringify(d));
}

function openPage(pageN){
	if(pageN == 1){
		$(".container-page-main").css("display", "none");
		$(".container-page-ressuply").css("display", "");
		$(".container-page-stock").css("display", "none");
		$(".container-page-staff").css("display", "none");
		$(".container-page-upgrades").css("display", "none");
	}
	if(pageN == 2){
		$(".container-page-main").css("display", "none");
		$(".container-page-ressuply").css("display", "none");
		$(".container-page-stock").css("display", "");
		$(".container-page-staff").css("display", "none");
		$(".container-page-upgrades").css("display", "none");
	}
	if(pageN == 3){
		$(".container-page-main").css("display", "none");
		$(".container-page-ressuply").css("display", "none");
		$(".container-page-stock").css("display", "none");
		$(".container-page-staff").css("display", "");
		$(".container-page-upgrades").css("display", "none");
	}
	if(pageN == 4){
		$(".container-page-main").css("display", "none");
		$(".container-page-ressuply").css("display", "none");
		$(".container-page-stock").css("display", "none");
		$(".container-page-staff").css("display", "none");
		$(".container-page-upgrades").css("display", "");
	}
}

function suprimentos(tipo){
	post("suprimentos",tipo)
}

function estoque(tipo){
	post("estoque",tipo)
}

function alocar(tipo){
	post("alocar",tipo)
}

function upgrades(tipo){
	post("upgrades",tipo)
}

function fecharEmpresa(){
	location.href='#fechar';
	post("fecharEmpresa","")
}

document.onkeyup = function(data){
	if (data.which == 27){
		if ($(".container-content").is(":visible")){
			location.href='#fechar';
			post("fechar","")
		}
	}
};

function post(name,data){
	$.post("http://esx_empresas/"+name,JSON.stringify(data),function(datab){
		if (datab != "ok"){
			console.log(datab);
		}
	});
}