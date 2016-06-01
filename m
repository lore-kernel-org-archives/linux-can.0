From: Marek Vasut <marex@denx.de>
Subject: Re: [RFC] K-Line protocol via SocketCAN
Date: Wed, 01 Jun 2016 04:26:16 +0200
Message-ID: <574E47C8.4000709@denx.de>
References: <573E491E.1000906@denx.de> <CAJ=nTsu_bJgj1A5JNJNAd9HAao5493CnofbQpJ_qftYOiCgaYw@mail.gmail.com> <573EAE9D.20006@hartkopp.net> <573EFC23.2040906@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:56511 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbcFAC0V (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 31 May 2016 22:26:21 -0400
In-Reply-To: <573EFC23.2040906@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Mirza Krak <mirza.krak@hostmobility.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

On 05/20/2016 01:59 PM, Marek Vasut wrote:
> On 05/20/2016 08:28 AM, Oliver Hartkopp wrote:
>> Hi,
> 
> Hi!

Hi again,

>> I removed Dave Miller from the discussion not to be tagged as SPAM :-)
>> That's not Daves focus as networking maintainer ...
> 
> Heh, all right.
> 
>> Here's an update about the LIN Status from Pavel Pisa:
>>
>> http://marc.info/?l=linux-can&m=146163127517268&w=2
> 
> I am aware of the sllin. There is also freediag , which implements kline
> protocol.
> 
>> I remember a K-Line implementation for Linux where we had a MPC5200 UART
>> which we programmed with bit-banging of some control line to do the
>> 5bit/s opening pattern.
>> After that we went to 10400 bit/s and did some K-Line communication.
>> All this was done by a user space application on /dev/ttyS0.
> 
> Yes, and this does make perfect sense until you start dealing with
> faster modes and need more precise timing. The K-Line is limited by
> 250kBaud/s bus speed.
> 
>> What would be the advantages to put this into kernel space (or into the
>> CAN networking infrastructure)?
> 
> I see two for putting this into the kernel:
> - At faster bus speeds, you can achieve more precise timing if this is
>   in the kernel, both of the inter-byte delay and also for the
>   timestamps. Having this in the kernel even allows usage of the
>   realtime extensions if needed.
> - Dedicated hardware driver can plug into such K-Line infrastructure.
>   Such hardware might be needed to support the faster modes to further
>   increase the timing precision.
> 
> And two for using socketcan/network interface:
> - The addressing support of the network stack can be mapped to K-Line
>   bus addresses.
> - The rtnl can be used as an extensible interface for configuring the
>   K-Line parameters.

What do you think about putting the KLine support into socketcan stack ?

-- 
Best regards,
Marek Vasut
