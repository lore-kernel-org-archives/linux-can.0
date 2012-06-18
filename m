From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 1/6] canfd: add new data structures and constants
Date: Mon, 18 Jun 2012 21:19:01 +0200
Message-ID: <4FDF7F25.8040605@hartkopp.net>
References: <4FDF67C3.6020201@hartkopp.net> <4FDF7DE1.6000803@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:39070 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388Ab2FRTTA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Jun 2012 15:19:00 -0400
In-Reply-To: <4FDF7DE1.6000803@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 18.06.2012 21:13, Marc Kleine-Budde wrote:

> On 06/18/2012 07:39 PM, Oliver Hartkopp wrote:
>> - add new struct canfd_frame


>>  struct can_frame {
>>  	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
>> -	__u8    can_dlc; /* data length code: 0 .. 8 */
>> +	__u8    can_dlc; /* frame payload length in byte (0 .. 8) */
>>  	__u8    data[8] __attribute__((aligned(8)));
> 
> checkpatch complains:
> 
> WARNING: __aligned(size) is preferred over __attribute__((aligned(size)))
> #84: FILE: include/linux/can.h:102:
> +       __u8    data[64] __attribute__((aligned(8)));
> 
> total: 0 errors, 1 warnings, 97 lines checked
> 


Hm, yes. I wanted to have it the same way as in struct can_frame.

I wonder if "__aligened(size)" is also compatible for backports - or
alternative if we should also modify the original can_frame:

>> - 	__u8    data[8] __attribute__((aligned(8)));
>> + 	__u8    data[8] __aligned(8);

???

Regards,
Oliver
