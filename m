From: Marek Vasut <marex@denx.de>
Subject: Re: [RFC] K-Line protocol via SocketCAN
Date: Sat, 11 Jun 2016 21:42:18 +0200
Message-ID: <575C699A.8080000@denx.de>
References: <573E491E.1000906@denx.de> <CAJ=nTsu_bJgj1A5JNJNAd9HAao5493CnofbQpJ_qftYOiCgaYw@mail.gmail.com> <573EAE9D.20006@hartkopp.net> <573EFC23.2040906@denx.de> <574E47C8.4000709@denx.de> <575415F5.3070306@hartkopp.net> <57598472.3070207@denx.de> <5759B597.3060009@hartkopp.net> <5759C1D1.1000001@denx.de> <5759CDC9.2010204@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:33762 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbcFKTs0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 11 Jun 2016 15:48:26 -0400
In-Reply-To: <5759CDC9.2010204@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Mirza Krak <mirza.krak@hostmobility.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

On 06/09/2016 10:12 PM, Oliver Hartkopp wrote:
> On 06/09/2016 09:21 PM, Marek Vasut wrote:
>> On 06/09/2016 08:29 PM, Oliver Hartkopp wrote:
> 
>>>> I am more interested in the RTNL configuration interface, since the
>>>> kline has way too many parameters and the RTNL scales well in that
>>>> aspect.
>>>
>>> If like rtnl so much why don't you create a K-Line netdevice driver for
>>> it and use the PF_PACKET socket to exchange data with the netdevice?
>>
>> Because last time I did that with the arinc, I was told to integrate
>> that into the socketcan instead.
>>
>>>> When using the socket interface, I can also add various flags to the
>>>> packet and control the properties of the data that are to be
>>>> transmitted
>>>> via the KLine interface. That's real convenient.
>>>
>>> But that has nothing to do with PF_CAN.
>>
>> So I should add another orthogonal infrastructure ? That's what I did
>> with the arinc and I was told the exact opposite, so I am really
>> confused here .
> 
> ARINC 825 *is* CAN. When people tell you to use the existing
> infrastructure that was a good hint, but K-Line is definitely not CAN.

Well, I was talking about arinc 429 .

> Your patch set shows that you are adding things to the CAN
> infrastructure that have nothing to do with CAN.
> 
> E.g. the K-Line timing you add in patch 4/5 has nothing to do with CAN
> specific configurations.
> 
> Additionally I don't know whether the struct kline_frame is the optimal
> solution because it sticks to struct can_frame and does not reflect the
> (optional) K-Line address scheme.
> 
> So you could either use the sl_kline.c with PF_PACKET and create a
> separate rtnl configuration for it OR you could create a character
> device which handles K-Line frames and has some ioctls to configure the
> specialized timings.

Is adding a specialized chardev really such a great idea ?

> As K-Line never was multi-user capable by design the chardev approach is
> the most 'natural' concept IMHO.

I could technically just implement this as a ldisc with some additional
ioctls, but is that really such a good idea ?

> Regards,
> Oliver
> 


-- 
Best regards,
Marek Vasut
