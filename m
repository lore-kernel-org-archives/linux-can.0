From: =?iso-8859-1?Q?=22Bernd_Krumb=F6ck=22?= <krumboeck@universalnet.at>
Subject: Re: [PATCH] usb2can: Add support for USB2CAN interface from 8
 devices
Date: Thu, 13 Dec 2012 08:44:59 +0100
Message-ID: <2d326343baa98de754c90e51e7a07a3e.squirrel@webmail.universalnet.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp.xy24.at ([85.126.109.136]:47407 "EHLO renate.xy24.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752852Ab2LMHpK (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 13 Dec 2012 02:45:10 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: "krumboeck@universalnet.at" <krumboeck@universalnet.at>, linux-can@vger.kernel.org, info@gerhard-bertelsmann.de, gediminas@8devices.com

Hi!

> On 12/03/2012 01:43 AM, krumboeck@universalnet.at wrote:
>> Am 2012-12-02 14:35, schrieb Wolfgang Grandegger:
...
>>>
>>> Could you please show the output of "candump -e any,0:0,#FFFFFFFF" when
>>> the device goes 1) error passive and 2) bus-off. You could provoke
>>> these states by 1) sending without connection to the bus or 2)
>>> short-circuiting CAN high and low.
...
>>
>>   can0  500  [4] 00 01 02 03
>>   can0  500  [4] 00 01 02 03
>>   can0  500  [4] 00 01 02 03
>>   can0  500  [4] 00 01 02 03
>>   can0  500  [4] 00 01 02 03
>>   can0  500  [4] 00 01 02 03
>>   can0  500  [4] 00 01 02 03
>
> These messages should up after reconnecting the cable?
>
>> In my tests I was not able to provoke "bus-off".
>
>
> Even by short-circuiting CAN high and low while sending messages out to
> the bus? This should always work.
>

This was my fault, because I forgot to connect a power supply and the
controller circuit use galvanic isolation.


regards,
Bernd

