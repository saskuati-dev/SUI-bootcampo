"use client";

import { useSuiClient, useCurrentAccount } from "@mysten/dapp-kit";
import { useEffect } from "react";
export const useGallaryData = () =>{
    const currentAccount = useCurrentAccount();
    const client = useSuiClient();


    const gallaryData = async () =>{
        const gallery: any= await client.getObject({
        id: '0xb5fff48084b4aa6ee0822f02babbbca725514d96dfac460b99e636375cd3ed68',
        options: {
            showContent: true,
            showOwner:true,
        }
    });
    
        return {
            ...gallery.data.content.fields
        };
    };
    return{
        gallaryData,
    }
};