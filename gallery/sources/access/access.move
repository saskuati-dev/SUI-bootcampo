module gallery::access;

use gallery::admin::GalleryData;
use sui::coin::{Self, Coin};
use sui::sui::SUI;

public fun payAcess(gallery: &mut GalleryData, mut payment: Coin<SUI>, ctx: &mut TxContext){
    assert!(coin::value(&payment) >= gallery.getFee(), 1);

    let amount = coin::split<SUI>(&mut payment, gallery.getFee(), ctx);

    gallery.handle_payment(amount,ctx);

    if(coin::value(&payment)>0){
        transfer::public_transfer(payment, tx_context::sender(ctx));
    }else{
        coin::destroy_zero<SUI>(payment);
    }
}