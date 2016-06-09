From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC] K-Line protocol via SocketCAN
Date: Thu, 9 Jun 2016 20:29:43 +0200
Message-ID: <5759B597.3060009@hartkopp.net>
References: <573E491E.1000906@denx.de>
 <CAJ=nTsu_bJgj1A5JNJNAd9HAao5493CnofbQpJ_qftYOiCgaYw@mail.gmail.com>
 <573EAE9D.20006@hartkopp.net> <573EFC23.2040906@denx.de>
 <574E47C8.4000709@denx.de> <575415F5.3070306@hartkopp.net>
 <57598472.3070207@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:40650 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbcFISsy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Jun 2016 14:48:54 -0400
In-Reply-To: <57598472.3070207@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marek Vasut <marex@denx.de>, Mirza Krak <mirza.krak@hostmobility.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

On 06/09/2016 05:00 PM, Marek Vasut wrote:
> On 06/05/2016 02:07 PM, Oliver Hartkopp wrote:
>> On 06/01/2016 04:26 AM, Marek Vasut wrote:
>>
>>>>> What would be the advantages to put this into kernel space (or into the
>>>>> CAN networking infrastructure)?
>>>>
>>>> I see two for putting this into the kernel:
>>>> - At faster bus speeds, you can achieve more precise timing if this is
>>>>     in the kernel, both of the inter-byte delay and also for the
>>>>     timestamps. Having this in the kernel even allows usage of the
>>>>     realtime extensions if needed.
>>
>> A topic for the serial driver infrastructure?
>
> Can you elaborate a bit please ?

No. If you have requirements for in-time transmission that could no be 
solved in user space, you might add some handler or functionality that 
adds this feature. So where would you add that for a K-Line driver? In 
the video driver infrastructure?

>
>>>> - Dedicated hardware driver can plug into such K-Line infrastructure.
>>>>     Such hardware might be needed to support the faster modes to further
>>>>     increase the timing precision.
>>
>> Which K-Line infrastructure?
>
> The one which would be added to socketcan. The patches don't seem too
> disruptive in fact.
>

Why don't you just post them? I'm pretty tired of these pointless 
discussions exchanging our arguments again and again.

>>>> And two for using socketcan/network interface:
>>>> - The addressing support of the network stack can be mapped to K-Line
>>>>     bus addresses.
>>
>> The K-Line addressing is totally different from CAN addressing. Why do
>> you think the stuff in linux/net/can has any conjunction to K-Line
>> addressing?
>
> Let me just ask what you mean by "totally different" first ?
>

CAN Frame: 11/29 bit ID and max 8 or 64 (CAN FD) byte frame length
KWP2000 Message: (optional!) 8 bit target address 8 bit receiver address 
and 1 .. 255 data bytes

=> totally different!

>>>> - The rtnl can be used as an extensible interface for configuring the
>>>>     K-Line parameters.
>>
>> The idea of SocketCAN using the Linux networking infrastructure and
>> network interfaces is the multi-user capability which is enabled through
>> this layering.
>>
>> IIRC K-Line is ONE point-to-point connection which is not multi-user
>> capable - so what would be the benefit to implement a K-Line serial
>> driver as network device and then configure it via rtnl?
>
> I am more interested in the RTNL configuration interface, since the
> kline has way too many parameters and the RTNL scales well in that
> aspect.

If like rtnl so much why don't you create a K-Line netdevice driver for 
it and use the PF_PACKET socket to exchange data with the netdevice?

> When using the socket interface, I can also add various flags to the
> packet and control the properties of the data that are to be transmitted
> via the KLine interface. That's real convenient.

But that has nothing to do with PF_CAN.

Oliver

