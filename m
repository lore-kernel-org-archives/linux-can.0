From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: Re: [PATCH] can-utils: Add exact CAN frame length calculation (including bitstuffing)
Date: Thu, 30 Jan 2014 11:01:51 +0100
Message-ID: <87ob2tkcts.fsf@steelpick.2x.cz>
References: <1390571983-16040-1-git-send-email-sojkam1@fel.cvut.cz> <52E3D619.4070702@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from max.feld.cvut.cz ([147.32.192.36]:47734 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156AbaA3KB5 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 30 Jan 2014 05:01:57 -0500
In-Reply-To: <52E3D619.4070702@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Hello all,

On Sat, Jan 25 2014, Oliver Hartkopp wrote:
> Hello Michal,
>
> On 24.01.2014 14:59, Michal Sojka wrote:
>> This adds an algorithm for calculating the exact number of bits a CAN
>> frame occupies on the bus and uses this algorithm in canbusload.
>
>
>> +++ b/canframelen.h
>> @@ -0,0 +1,8 @@
>> +#ifndef CANFRAMELEN_H
>> +#define CANFRAMELEN_H
>> +
>> +#include <linux/can.h>
>> +
>> +unsigned can_frame_length(struct can_frame *frame);
>> +
>> +#endif
>> 
>
> I would suggest two things:
>
> 1. Add some comment about the function (e.g. that it returns the length in
> bits with/without inter frame gap).
>
> 2. I would prefer to add some calculation mode identifier here and provide all
> calculation modes in canframelen.c
>
> Including this stuff and it's comments:
>
> https://gitorious.org/linux-can/can-utils/source/canbusload.c#L375
>
> E.g. some
>
> enum {
> 	NO_BITSTUFFING, /* plain bit calculation without bitstuffing */
> 	BITSTUFFING, /* with bitstuffing following Tindle estimation */
> 	PRECISE, /* precise calculation including bitstuffing in CRC */
> }
>
> To be future proof with CAN I would suggest to add some CAN / CAN FD switch.
>
> E.g.
>
> unsigned can_frame_length(struct canfd_frame *cfd, int mode, int mtu);
>
> Where mtu is CAN_MTU or CANFD_MTU to distinguish the frame types.
> In the first step supporting CAN_MTU would be sufficient.
> As a return value of zero always shows a problem this can be used to indicated
> unsupported calculation modes/frame types.

The updated patch will follow this email.

Best regards,
-Michal
