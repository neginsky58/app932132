$(document).ready(function() {
    if($('.block-watchlist').length>0){
        setInterval(function() {
            $.ajax({
                url: '/watchlist',
                type: "POST",
                dataType: 'json',
                data: {
                    'message': 'message'
                },
                success: function(msg){
                    console.log(msg.success);
                    for(i = 0; i<msg.items.length; i++){
                        console.log(msg.items[i].name);    
                    }
                    
                },
                error: function(xhr, status){

                }
            });
        }, 5000); // 1500 ms loop
    }    
});