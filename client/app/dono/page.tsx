"use client";

import { Button } from "@/components/ui/button";
import {useCurrentAccount, ConnectButton} from "@mysten/dapp-kit";
import { useGallaryData } from "@/hooks/useGalleryData";
import { useEffect } from "react";


export default function Home(){
    const currentAccount = useCurrentAccount();

    return (
        <div className="flex flex-col items-center ">
            <div className="w-full flex justify-end items-center p-4 h-full">
                <ConnectButton/>
            </div>
            <Button>Coletar dinheiro</Button>
            <Button>Publicar imagem</Button>
        </div>
    )
}