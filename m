From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Inconsistent error state transition error frames
Date: Wed, 10 Sep 2014 21:08:21 +0200
Message-ID: <5410A1A5.1090802@hartkopp.net>
References: <7EAA3DE6DC6BA14D830C95541CC66EBC9F72FED6@GRBSR0004.marel.net> <540DDB16.8010304@pengutronix.de> <a62de8d447dda55b1aa30711f0dc4605@grandegger.com> <540EEBA0.9080209@marel.com> <56f33e0559ffda649925492dca2720fd@grandegger.com> <540F1396.2030702@marel.com> <1a51435a44c2ebd32cca3feee3799af3@grandegger.com> <540F4225.4090907@hartkopp.net> <541025B5.9070901@marel.com> <54102803.4070404@pengutronix.de> <25bf289f701148cd1800c8e79da342aa@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:26088 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223AbaIJTI3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 10 Sep 2014 15:08:29 -0400
In-Reply-To: <25bf289f701148cd1800c8e79da342aa@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Andri Yngvason <andri.yngvason@marel.com>, linux-can@vger.kernel.org

On 10.09.2014 13:53, Wolfgang Grandegger wrote:

>>>> +/* controller error counter values / data[6..7] */
>>>> +#define CAN_ERR_TXERR_BYTE 6
>>>> +#define CAN_ERR_RXERR_BYTE 7
>>>>     #endif /* _UAPI_CAN_ERROR_H */
>>>>
>>> I'm not sure what's considered good practice in kernel code but
> wouldn't
>>> it be better to use a macro like this instead?
>>>     #define CAN_ERR_CRTL_DATA(frame) ((frame)->data[1])
>>> which would be used like this:
>>>     if(CAN_ERR_CRTL_DATA(frame) & CAN_ERR_CRTL_whatever) ...
>>
>> I'm not sure....but...
>>
>> Make it a static inline function and give it a proper name, something
>> like can_err_frame_get_ctrl(). Maybe without err_....

Maybe without _frame ? :-)

Think of 

	frame->data[CAN_ERR_CTRL_BYTE] |= CAN_ERR_CRTL_RX_OVERFLOW;

How would this look like?

	can_err_frame_set_ctrl(frame) = can_err_frame_get_ctrl(frame) | CAN_ERR_CRTL_RX_OVERFLOW;

Hm. Not nice.

	CAN_ERR_CRTL_DATA(frame) |= CAN_ERR_CRTL_RX_OVERFLOW;

Is hard to understand at first sight.

> 
> I'm not sure... we also need to set the value. Therefore I would
> vote for:
> 
>  frame->data[CAN_ERR_TXERR_BYTE];
> 
> It does make the code more readable.

Unfortunately CAN_ERR_TXERR_BYTE is pretty long and I have no good idea
how to make it shorter. CAN_ERR_TXERR_IDX is probably more handy.

E.g.

	frame->data[CAN_ERR_CTRL_IDX] |= CAN_ERR_CRTL_RX_OVERFLOW;

I would vote for something like this too.

Should I send a patch for this approach?

Regards,
Oliver

