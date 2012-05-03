From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC] CAN FD support
Date: Thu, 03 May 2012 16:41:49 +0200
Message-ID: <4FA2992D.6000807@hartkopp.net>
References: <4FA2689D.5030905@hartkopp.net> <4FA26D28.80307@grandegger.com> <4FA26F65.5020804@hartkopp.net> <4FA275C1.4080905@grandegger.com> <20120503121833.GC416@vandijck-laurijssen.be> <4FA27C3C.8010806@hartkopp.net> <4FA28BAA.3000109@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:58486 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754693Ab2ECOlw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 May 2012 10:41:52 -0400
In-Reply-To: <4FA28BAA.3000109@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 03.05.2012 15:44, Marc Kleine-Budde wrote:

> On 05/03/2012 02:38 PM, Oliver Hartkopp wrote:
> [...]
> 
>>> I share this.
>>> I'd even prefer u16 over u8 even.
>>> No legacy issues exist when changing the meaning of can_dlc, since current
>>> CAN frames have equal values for DLC & length!
>>>
>>>> the struct is also used by the app.
>>
>>
>> Yes - that's the main problem IMO.
>>
>> What about this binary compatible introduction of cf->len ...
> 
> ...but it's not 100% source compatible, due to a compiler bug in gcc.
> You cannot use C99 initializers on anonymous unions in certain gcc versions.


ugh!

> 
> [..]
> 
>> --- a/include/linux/can.h
>> +++ b/include/linux/can.h
>> @@ -57,7 +57,10 @@ typedef __u32 can_err_mask_t;
>>   */
>>  struct can_frame {
>>  	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
>> -	__u8    can_dlc; /* data length code: 0 .. 8 */
>> +	union {
>> +		__u8    can_dlc; /* data length code: 0 .. 8 */
>> +		__u8    len; /* data length: 0 .. 8 */
>> +	};
>>  	__u8    data[8] __attribute__((aligned(8)));
>>  };
> 


Thanks for the hint.

Indeed i left the struct can_frame as is now!

There's now can_frame.can_dlc and canfd_frame.len which both contains the real
length - even if can_frame.can_dlc is literally a data length *code* .

Btw. by having canfd_frame.len we indicate for CAN FD that we have a real
length here.

Regards,
Oliver
