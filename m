From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: How to send a CAN message while in a kernel module?
Date: Sat, 21 Mar 2020 21:51:31 +0100
Message-ID: <ead77f42-f0f9-9b5a-ce5a-5e7f641d8a14@hartkopp.net>
References: <CAOHJ0jSS=g4rQtXGkEFocafEqQAtxEOvq5eSXBC2FY_Esb23OA@mail.gmail.com>
 <2cb68f43-a551-c69d-b43f-3b044b948142@hartkopp.net>
 <CAOHJ0jRQx2U1APx92DTGFGzGLY9+tds3R4Sz8Tz8+LToWx_44g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23]:24093 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgCUUvd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 21 Mar 2020 16:51:33 -0400
In-Reply-To: <CAOHJ0jRQx2U1APx92DTGFGzGLY9+tds3R4Sz8Tz8+LToWx_44g@mail.gmail.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Robert Barrows <robb.barrows@gmail.com>
Cc: linux-can@vger.kernel.org

On 21/03/2020 20.15, Robert Barrows wrote:
>> You don't use sockets from INSIDE the kernel.
>> If you want to send CAN frames from inside the kernel you should use the
>> can_send() function from af_can.c
> Great to know! I Will look at that right away, any example(s) you could point
> me towards?
> 

You mainly need to look at raw_sendmsg() from linux/net/can/raw.c

Create a skb and set can_skb_reserve() and the other stuff and finally 
put your CAN frame content into the skb->data and invoke can_send().

You will at least need

#include <linux/netdevice.h>
#include <linux/skbuff.h>
#include <linux/can.h>
#include <linux/can/core.h>
#include <linux/can/skb.h>

Of course you don't have a sk reference as you don't have a socket in place.

So you maybe should check the content of alloc_can_skb() from 
linux/drivers/net/can/dev.c and use netdev_alloc_skb() or alloc_skb() 
instead of sock_alloc_send_skb() which needs sk to take care of socket 
specific memory quotas.

If you are unsure just post the code for a review.

Best,
Oliver
