window.addEventListener("message", function (event) {
    count_item = 0;
    if (event.data.action == "display") {
        $(".ui").fadeIn('fast');
    }else if (event.data.action == "setItems") {
        LoadShop(event.data.itemList);
    }else{
        $(".ui").fadeOut('fast');
    }
});

var Config = new Object();
Config.closeKeys = [113, 27, 90];

function LoadShop(items){
    $("#ShopResult").html("");
    $.each(items, function (index, item) {
        var html_items = '<div id="item-' + index + '" class="col slot-1" style="padding: 0px;width:20%;" data-index="'+ index +'">' + 
                                    '<div class="card slot z-depth-0">' +
                                        '<div class="card-image" align="center" style="padding: 15px 0 15px 0;">' +
                                            '<img src="nui://esx_inventoryhud/html/img/items/' + item.item + '.png" style="width: 100px;height: 100px;">' + 
                                        '</div>' + 
                                        '<div class="card-content" align="center" style="padding: 0;">'+ item.label + '</div>' + 


                                        '<div class="card-content" align="center" style="padding: 5px 0 5px 0;">' + 
                                            '<a data-action="remove" data-index="'+ index +'" class="btn-floating btn-flat waves-effect waves-red" data-price="'+item.price+'" style="opacity: 0.8;margin-right: 20px;"><i class="material-icons">remove</i></a>' + 
                                            '<span id="item-count-' + index +'">1</span>' + 
                                            '<input id="text-item-count-' + index +'" type="hidden" value="1" />' + 
                                            '<a data-action="add" data-index="'+ index +'" data-limit="'+item.limit+'" data-price="'+item.price+'" class="btn-floating btn-flat waves-effect waves-green" style="opacity: 0.8;margin-left: 20px;"><i class="material-icons">add</i></a>' + 
                                        '</div>' + 
                                        '<div class="card-content" align="center" style="padding: 5px 0 15px 0;">' + 
                                        'Giá : <span id="item-price-' + index +'">' + item.price + '</span>$' + 
                                        '</div>' + 
                                        '<div class="card-content" align="center" style="padding: 0px 0 10px 0;">' + 
                                            '<button type="button" data-action="buy" data-index="'+ index +'" data-item="'+ item.item +'" class="btn-floating btn-large btn-flat waves-effect waves-light" style="opacity: 0.9"><i class="material-icons">shopping_cart</i></button>' + 
                                        '</div>' + 
                                    '</div>' + 
                                 '</div>';
        $("#ShopResult").append(html_items);
        $('#item-' + index).data('item', item);
        $('#item-' + index).data('inventory', "main");
    });
}


$(document).ready(function () {

    //ออกจากร้าน
    $("body").on("keyup", function (key) {
        if (Config.closeKeys.includes(key.which)) {
            closeHUD();
        }
    });

    //ลด
    $('body').on('click','[data-action="remove"]', function(){
        var index = $(this).attr('data-index');
        var price = $(this).attr('data-price');
        var object = $("#text-item-count-" + index);
        var count_item = parseInt(object.val());
        if(count_item <= 1){
            object.val(1);
            $("#item-count-" + index).text("1");
        }else{
            object.val(count_item-1);
            $("#item-count-" + index).text(count_item-1);
        }
        $("#item-price-" + index).text(price*parseInt(object.val()));

    });

    //เพิ่ม
    $('body').on('click','[data-action="add"]', function(){
        var index = $(this).attr('data-index');
        var limit = $(this).attr('data-limit');

        var price = $(this).attr('data-price');
        var object = $("#text-item-count-" + index);
        var count_item = parseInt(object.val());
        
        if(count_item >= limit){
            object.val(limit);
            $("#item-count").text(limit);
        }else{
            object.val(count_item+1);
            $("#item-count-" + index).text(count_item+1);
        }

        $("#item-price-" + index).text(price*parseInt(object.val()));
    });

    //ซื้อ
    $('body').on('click','[data-action="buy"]', function(){
        var $btn = $(this);
        var index = $(this).attr('data-index');
        var item = $(this).attr('data-item');
        var object = $("#text-item-count-" + index);
        var count_item = parseInt(object.val());

        $btn.attr("disabled", true);

        $.post("http://meeta_shops/CBuyItem", JSON.stringify({
            itemName: item,
            amount: count_item,
            index: parseInt(index)
        }));

        setTimeout(function(){
            $btn.attr("disabled", false);
        },2000);

    });

});

function closeHUD() {
    $.post("http://meeta_shops/NUIFocusOff", JSON.stringify({}));
}