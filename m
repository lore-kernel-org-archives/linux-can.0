From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Hardware Loopback on RT-Socket-CAN Needed
Date: Thu, 17 Dec 2015 16:34:26 +0100
Message-ID: <5672D602.8070609@grandegger.com>
References: <54DCF20AC6227B4FABAC7D71A5A1208F78E9068B@BLRKECMBX13.ad.infosys.com>
 <5672CA09.2050503@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy02.manitu.net ([217.11.48.150]:43094 "EHLO
	mailproxy02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755726AbbLQPnB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 17 Dec 2015 10:43:01 -0500
In-Reply-To: <5672CA09.2050503@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephen Marshall <Stephen_Marshall@infosys.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

Hello,

for RT-CAN related questions the Xenomai ML is maybe more appropriate.

Am 17.12.2015 um 15:43 schrieb Marc Kleine-Budde:
> On 12/17/2015 03:13 PM, Stephen Marshall wrote:
>> I am looking for some information on Loopback functionality for the
>> RT-Socket-CAN.
>
> You mean RT-Socket-CAN as in Xenomai? This is, as far as i know dead.

It's not dead! Just little contributions.

>> In Socket-CAN, we used to test the loopback functionality on own socket
>> using the flag *CAN_RAW_RECV_OWN_MSGS *using *MSG.CONFIRM* flag. However
>> in RT-Socket CAN we see that this option has been disabled purposefully.

Can't remember why it was not implemented. I think there was just no 
use-case,

[snip]

>> We use the SJA1000 CAN Controller and Xenomai 2.6. We tried setting the
>> SRR (Self Reception Request) bit at driver using *CAN_CTRLMODE_LOOPBACK*
>> <http://www.xenomai.org/documentation/xenomai-2.4/html/api/group__rtcan.html#ga19ec0cc4379e80c32cbd333cf7c145e9>*,

Are you still using Xenommai 2.4?

>> *however it was doing a software loopback where the looped back message
>> would not have actually gone in the bus. We needed the
>> CAN_RAW_RECV_OWN_MSGS fix at RT-Socket-CAN, could someone help?

IIRC, on the SJA1000 the hw loopback is redirecting tx messages to the 
rx unit (in hardware) without sending something out to the bus,

Have a look to:

 
https://git.xenomai.org/xenomai-2.6.git/tree/ksrc/drivers/can/rtcan_raw.c#n196

If you remove the "if" statement I think it already does what you want. 
But maybe I have missed something... it's a long time that I looked to 
that code.

Wolfgang.
