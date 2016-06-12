From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 4/5][RFC] can: kline: Add KLine rtnl configuration options
Date: Sun, 12 Jun 2016 19:34:04 +0200
Message-ID: <575D9D0C.8080903@denx.de>
References: <1465500064-5402-1-git-send-email-marex@denx.de> <1465500064-5402-4-git-send-email-marex@denx.de> <5759CFCD.1050305@posteo.de> <575C6928.80302@denx.de> <575D8160.4060702@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:49735 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479AbcFLReW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 12 Jun 2016 13:34:22 -0400
In-Reply-To: <575D8160.4060702@posteo.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Patrick Menschel <menschel.p@posteo.de>, linux-can <linux-can@vger.kernel.org>

On 06/12/2016 05:36 PM, Patrick Menschel wrote:
> Am 11.06.2016 um 21:40 schrieb Marek Vasut:
>> On 06/09/2016 10:21 PM, Menschel.P wrote:
>>> Hello Marek,
>>
>> Hi,
>>
>>> these look like the timing parameters for KWP2000 protocol.
>>>> +struct kline_timing {
>>>> +    __u32 w0;
>>>> +    __u32 w1;
>>>> +    __u32 w2;
>>>> +    __u32 w3;
>>>> +    __u32 w4;
>>>> +    __u32 w5;
>>>> +    __u32 p1;
>>>> +    __u32 p2_94;
>>>> +    __u32 p2_08;
>>>> +    __u32 p3;
>>>> +    __u32 p4;
>>>> +};
>>> The wX parameters are the wake up timings and the pX are the response
>>> timings in between tester and ecu.
>>> Imho the protocol needs to be separated from the device driver since
>>> there are other protocols like kwp500 and kwp1281 that use k-line.
>>
>> Do you have some idea how to design the framework ?
>>
> 
> Hi,
> 
> As I wrote before, I favor the serial port since K-Line is pure serial
> communication.
> Let the serial driver do the wakeup pattern in kernel space by using
> pinctl to pull up/ down the line for the necessary time.

Not the serial driver, this can be all moved into a line discipline
to avoid adding cruft into the serial driver itself. But how do you
propose to configure the necessary timings, by IOCTLs ? That feels
like bloating the interface. Sysfs might also work, though I am not
sure about that.

> If no pinctl available use regular RTS/CTS pins with external
> transistors. There is already an extension for RS485 support, e.g. RX/TX
> switching of the transceiver PHY.

The RS485 bit can only ever work if the UART supports it. I have seen
some parts using GPIO for the switching and that cannot work reliably
on higher-speed links.

> The protocol handler would hand the wakeup parameters to the serial
> driver when Open() is called.

How ?

> Regards,
> Patrick
> 


-- 
Best regards,
Marek Vasut
