module gallery::admin;

use sui::sui::SUI;
use std::vector::{empty};
use sui::balance::{Self, Balance, zero};
use sui::coin::{Self, Coin};
use std::string::{Self, String};


public struct GalleryData has key{
    id: UID,
    fee: u64,
    addresses: vector<address>,
    balance: Balance<SUI>,
    blobs: vector<String>,
}

public struct AdminCap has key{
    id: UID
}



fun init(ctx: &mut TxContext){
    let admin_cap = AdminCap{
        id: object::new(ctx)
    };

    transfer::transfer(admin_cap, tx_context::sender(ctx));

    let gallery = GalleryData{
        id: object::new(ctx),
        fee: 1_000_000_00,
        addresses: empty(),
        balance: zero<SUI>(),
        blobs: empty()
    };

    transfer::share_object(gallery);


}

fun add_address(gallery: &mut GalleryData, address: address){
    gallery.addresses.push_back(address);
}

public(package) fun handle_payment(gallery: &mut GalleryData, mut payment: Coin<SUI>, ctx: &mut TxContext){
    coin::put<SUI>(&mut gallery.balance, payment);
    add_address(gallery, tx_context::sender(ctx));
}


public fun withdraw_balance(gallery: &mut GalleryData,_cap: &AdminCap, amount: u64, ctx: &mut TxContext){
    let profit = coin::take<SUI>(&mut gallery.balance, amount, ctx);
    transfer::public_transfer(profit, tx_context::sender(ctx));

}

public(package) fun getFee(gallery: &mut GalleryData):u64{
    return gallery.fee
}

public fun add_blob(gallery: &mut GalleryData, _cap: &AdminCap, blob: String){
    gallery.blobs.push_back(blob)
}