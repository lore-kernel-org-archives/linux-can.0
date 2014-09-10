From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Inconsistent error state transition error frames
Date: Wed, 10 Sep 2014 13:53:43 +0200
Message-ID: <25bf289f701148cd1800c8e79da342aa@grandegger.com>
References: <7EAA3DE6DC6BA14D830C95541CC66EBC9F72FED6@GRBSR0004.marel.net>
 <540DDB16.8010304@pengutronix.de>
 <a62de8d447dda55b1aa30711f0dc4605@grandegger.com>
 <540EEBA0.9080209@marel.com>
 <56f33e0559ffda649925492dca2720fd@grandegger.com>
 <540F1396.2030702@marel.com>
 <1a51435a44c2ebd32cca3feee3799af3@grandegger.com>
 <540F4225.4090907@hartkopp.net> <541025B5.9070901@marel.com>
 <54102803.4070404@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pluto.manitu.net ([217.11.48.9]:43475 "EHLO pluto.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082AbaIJLxr (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 10 Sep 2014 07:53:47 -0400
In-Reply-To: <54102803.4070404@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Andri Yngvason <andri.yngvason@marel.com>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

On Wed, 10 Sep 2014 12:29:23 +0200, Marc Kleine-Budde <mkl@pengutronix.de>
wrote:
> On 09/10/2014 12:19 PM, Andri Yngvason wrote:
>>> diff --git a/include/uapi/linux/can/error.h
>>> b/include/uapi/linux/can/error.h
>>> index c247446..c290f30 100644
>>> --- a/include/uapi/linux/can/error.h
>>> +++ b/include/uapi/linux/can/error.h
>>> @@ -58,10 +58,12 @@
>>>   #define CAN_ERR_RESTARTED    0x00000100U /* controller restarted */
>>>     /* arbitration lost in bit ... / data[0] */
>>> +#define CAN_ERR_LOSTARB_BYTE 0
>>>   #define CAN_ERR_LOSTARB_UNSPEC   0x00 /* unspecified */
>>>                         /* else bit number in bitstream */
>>>     /* error status of CAN-controller / data[1] */
>>> +#define CAN_ERR_CRTL_BYTE 1
>>>   #define CAN_ERR_CRTL_UNSPEC      0x00 /* unspecified */
>>>   #define CAN_ERR_CRTL_RX_OVERFLOW 0x01 /* RX buffer overflow */
>>>   #define CAN_ERR_CRTL_TX_OVERFLOW 0x02 /* TX buffer overflow */
>>> @@ -73,6 +75,7 @@
>>>                         /* the protocol-defined level of 127)  */
>>>     /* error in CAN protocol (type) / data[2] */
>>> +#define CAN_ERR_PROT_BYTE 2
>>>   #define CAN_ERR_PROT_UNSPEC      0x00 /* unspecified */
>>>   #define CAN_ERR_PROT_BIT         0x01 /* single bit error */
>>>   #define CAN_ERR_PROT_FORM        0x02 /* frame format error */
>>> @@ -84,6 +87,7 @@
>>>   #define CAN_ERR_PROT_TX          0x80 /* error occurred on
>>> transmission */
>>>     /* error in CAN protocol (location) / data[3] */
>>> +#define CAN_ERR_PROT_LOC_BYTE 3
>>>   #define CAN_ERR_PROT_LOC_UNSPEC  0x00 /* unspecified */
>>>   #define CAN_ERR_PROT_LOC_SOF     0x03 /* start of frame */
>>>   #define CAN_ERR_PROT_LOC_ID28_21 0x02 /* ID bits 28 - 21 (SFF: 10 -
>>> 3) */
>>> @@ -106,6 +110,7 @@
>>>   #define CAN_ERR_PROT_LOC_INTERM  0x12 /* intermission */
>>>     /* error status of CAN-transceiver / data[4] */
>>> +#define CAN_ERR_TRX_BYTE 4
>>>   /*                                             CANH CANL */
>>>   #define CAN_ERR_TRX_UNSPEC             0x00 /* 0000 0000 */
>>>   #define CAN_ERR_TRX_CANH_NO_WIRE       0x04 /* 0000 0100 */
>>> @@ -118,6 +123,10 @@
>>>   #define CAN_ERR_TRX_CANL_SHORT_TO_GND  0x70 /* 0111 0000 */
>>>   #define CAN_ERR_TRX_CANL_SHORT_TO_CANH 0x80 /* 1000 0000 */
>>>   -/* controller specific additional information / data[5..7] */
>>> +/* controller specific additional information / data[5] */
>>> +
>>> +/* controller error counter values / data[6..7] */
>>> +#define CAN_ERR_TXERR_BYTE 6
>>> +#define CAN_ERR_RXERR_BYTE 7
>>>     #endif /* _UAPI_CAN_ERROR_H */
>>>
>> I'm not sure what's considered good practice in kernel code but
wouldn't
>> it be better to use a macro like this instead?
>>     #define CAN_ERR_CRTL_DATA(frame) ((frame)->data[1])
>> which would be used like this:
>>     if(CAN_ERR_CRTL_DATA(frame) & CAN_ERR_CRTL_whatever) ...
> 
> I'm not sure....but...
> 
> Make it a static inline function and give it a proper name, something
> like can_err_frame_get_ctrl(). Maybe without err_....

I'm not sure... we also need to set the value. Therefore I would
vote for:

 frame->data[CAN_ERR_TXERR_BYTE];

It does make the code more readable.

Wolfgang.

