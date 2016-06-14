From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Receive CAN messages - New User
Date: Tue, 14 Jun 2016 19:53:25 +0200
Message-ID: <57604495.1030407@hartkopp.net>
References: <OFE7E3B09A.79E21B1D-ON86257FD2.005C50C9-86257FD2.005C6DDE@notes.cat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:11915 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727AbcFNRz1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 14 Jun 2016 13:55:27 -0400
In-Reply-To: <OFE7E3B09A.79E21B1D-ON86257FD2.005C50C9-86257FD2.005C6DDE@notes.cat.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Tim Felty <Felty_Tim@cat.com>, linux-can@vger.kernel.org



On 06/14/2016 06:49 PM, Tim Felty wrote:
> Everyone,
>
> I'm a new user of socketcan and have some questions on using it to receive
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
>      {
>          int s;
>
>          struct sockaddr_can addr;
>          struct ifreq ifr;
>
>          if((s = socket(PF_CAN, SOCK_RAW, CAN_RAW)) < 0)
>          {
>              return -1;
>          }
>
>          strcpy(ifr.ifr_name, device.c_str());
>          ioctl(s, SIOCGIFINDEX, &ifr);
>
>          addr.can_family  = AF_CAN;
>          addr.can_ifindex = ifr.ifr_ifindex;
>
>          if(bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0)
>          {
>              return -2;
>          }
>
>          return s;
>      }
>
> int addReceiver(unsigned int id, int is29bit, int isPGN)
> {
>          //I have no idea if this is even close
>          unsigned int filterMask;
>          if(is29bit != 0)
>          {
>              filterMask = CAN_EFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG;
>          }
>          else if(isPGN != 0)  //basically just the PGN mask, receive no
> matter the source or priority
>          {
>              filterMask = CAN_EFF_MASK | CAN_RTR_FLAG | 0x00FFFF00U;

CAN_EFF_FLAG ??

Please check whether setting the flags and masks in rfilter.can_id or 
rfilter.can_mask enables the filter you really want.

You might want to play with

	candump can0,<can_id>:<can_mask>

to check the filters in their functionality.

In

	cat /proc/net/can/rcvlist_*

you can see the enabled filters.

Btw. as you seem to use PGNs the j1939 implementation from Kurt van 
Dijck might be worth looking at.

Regards,
Oliver

>          }
>          else //11bit
>          {
>              filterMask = CAN_EFF_FLAG | CAN_RTR_FLAG | CAN_SFF_MASK;
>          }
>
>          int s = getNewSocket();
>          if(s < 0)
>          {
>              return false;
>          }
>
>          struct can_filter rfilter;
>          rfilter.can_id = id;
>          rfilter.can_mask = thisReceiver.filterMask;
>          setsockopt(s, SOL_CAN_RAW, CAN_RAW_FILTER, &rfilter,
> sizeof(rfilter));
>
>          return s;
>      }
>
>
> int main()
> {
>          int s =  addReceiver(0x0A,0, 0); //this is 11bit ID request for
> testing
>
>         struct can_frame frame;
>         int is29Bit = 0;
>         int isPGN = 0;
>
>         unsigned in canID = 0x0A;   //example ID
>         if(is29Bit != 0)  //if its 29bit then get he correct ID
>         {
>          canID |= canID | CAN_EFF_FLAG;
>         }
>         if(isPGN != 0) //get PGN from CAN ID
>         {
>          canID |= canID | 0x00FFFF00 ;
>         }
>
>         int nbytes;
>         while(1 > 0)
>         {
>                nbytes = read(canRecvObjects[objectID].socketID, &frame,
> sizeof(struct can_frame));
>                  // do something with the dlc
>                  // do something with the dat
>                 sleep(someTime);
>          }
> }
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
