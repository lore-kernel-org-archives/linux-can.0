From: Tim Felty <Felty_Tim@cat.com>
Subject: Re: Receive CAN messages - New User
Date: Tue, 14 Jun 2016 12:22:02 -0500
Message-ID: <OF21BD3638.7C6C2C41-ON86257FD2.005F59DD-86257FD2.005F66E7@notes.cat.com>
References: <OFE7E3B09A.79E21B1D-ON86257FD2.005C50C9-86257FD2.005C6DDE@notes.cat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from imail01.cis.cat.com ([12.2.142.8]:59421 "EHLO
	imail01.cis.cat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbcFNRWF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 14 Jun 2016 13:22:05 -0400
Received: from pps.filterd (armmailp21.cis.cat.com [127.0.0.1])
	by armmailp21.cis.cat.com (8.15.0.59/8.15.0.59) with SMTP id u5EHGxFn029189
	for <linux-can@vger.kernel.org>; Tue, 14 Jun 2016 12:22:03 -0500
Received: from arlmailp04.cis.cat.com (arwissvmailp06.mw.na.cat.com [137.230.206.88])
	by armmailp21.cis.cat.com with ESMTP id 23hxc6tnrs-1
	for <linux-can@vger.kernel.org>; Tue, 14 Jun 2016 12:22:03 -0500
Received: from Cat-clavin-cis.cat.com (notessmtp02.cis.cat.com [192.168.106.64])
	by arlmailp04.cis.cat.com (8.14.3/8.14.3) with ESMTP id u5EHM2hN000747
	for <linux-can@vger.kernel.org>; Tue, 14 Jun 2016 12:22:02 -0500
In-Reply-To: <OFE7E3B09A.79E21B1D-ON86257FD2.005C50C9-86257FD2.005C6DDE@notes.cat.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
Cc: linux-can@vger.kernel.org

Sorry, 

I was converting to C from C++ and made some transcription errors. 

In main: 
It should be nbytes = read(s, &frame, sizeof(struct can_frame));
and sleep(someTime) is just an example for waiting.
In addReceiver: return false should be return 0;


linux-can-owner@vger.kernel.org wrote on 06/14/2016 11:49:34 AM:

> ______________________________________________________________________
> Everyone, 
> 
> I'm a new user of socketcan and have some questions on using it to 
receive 
> messages. 
> 
> I'm trying to write some helper functions for other users to more easily 

> send and receive messages on an embedded device. 
> 
> The basic flow is to call a function with the requested CAN ID, and ID 
> type, and they are returned a socket with the appropriate filters set. 
> That socket is then passed to another function with the CAN Frame that 
> gets populated.  I'm new to sockets as well so I'm not sure how the 
> filters work, or whether it is even possible to do this at all. The code 

> is below.  Any comments or suggestions would be great. 
> 
> int getNewSocket(void) 
>     { 
>         int s; 
> 
>         struct sockaddr_can addr; 
>         struct ifreq ifr; 
> 
>         if((s = socket(PF_CAN, SOCK_RAW, CAN_RAW)) < 0) 
>         { 
>             return -1; 
>         } 
> 
>         strcpy(ifr.ifr_name, device.c_str()); 
>         ioctl(s, SIOCGIFINDEX, &ifr); 
> 
>         addr.can_family  = AF_CAN; 
>         addr.can_ifindex = ifr.ifr_ifindex; 
> 
>         if(bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) 
>         { 
>             return -2; 
>         } 
> 
>         return s; 
>     } 
> 
> int addReceiver(unsigned int id, int is29bit, int isPGN) 
> { 
>         //I have no idea if this is even close 
>         unsigned int filterMask; 
>         if(is29bit != 0) 
>         { 
>             filterMask = CAN_EFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG; 
>         } 
>         else if(isPGN != 0)  //basically just the PGN mask, receive no 
> matter the source or priority 
>         { 
>             filterMask = CAN_EFF_MASK | CAN_RTR_FLAG | 0x00FFFF00U; 
>         } 
>         else //11bit 
>         { 
>             filterMask = CAN_EFF_FLAG | CAN_RTR_FLAG | CAN_SFF_MASK; 
>         } 
> 
>         int s = getNewSocket(); 
>         if(s < 0) 
>         { 
>             return false; 
>         } 
> 
>         struct can_filter rfilter; 
>         rfilter.can_id = id; 
>         rfilter.can_mask = thisReceiver.filterMask; 
>         setsockopt(s, SOL_CAN_RAW, CAN_RAW_FILTER, &rfilter, 
> sizeof(rfilter)); 
> 
>         return s; 
>     } 
> 
> 
> int main() 
> { 
>         int s =  addReceiver(0x0A,0, 0); //this is 11bit ID request for 
> testing 
> 
>        struct can_frame frame; 
>        int is29Bit = 0; 
>        int isPGN = 0; 
> 
>        unsigned in canID = 0x0A;   //example ID 
>        if(is29Bit != 0)  //if its 29bit then get he correct ID 
>        { 
>         canID |= canID | CAN_EFF_FLAG; 
>        } 
>        if(isPGN != 0) //get PGN from CAN ID 
>        { 
>         canID |= canID | 0x00FFFF00 ; 
>        } 
> 
>        int nbytes; 
>        while(1 > 0) 
>        { 
>               nbytes = read(canRecvObjects[objectID].socketID, &frame, 
> sizeof(struct can_frame)); 
>                 // do something with the dlc 
>                 // do something with the dat 
>                sleep(someTime); 
>         } 
> }
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  https://urldefense.proofpoint.com/v2/url?
> 
u=http-3A__vger.kernel.org_majordomo-2Dinfo.html&d=CwIBAg&c=p0oa49nxxGtbbM2qgM-
> GB4r4m9OlGg-
> 
sEp8sXylY2aQ&r=VuANltNjLNwJQmGUza63viDz3uCLJcIq5CxaNaRbWn0&m=dgDHT6InvAmo7oAJLN0Drk_Z5o16wYmhMD9bHRBuKJA&s=l0dWQXRf-
> hoFgMRFBlC1b-6EQbabDYC_aUyAnH5UcLo&e= 

