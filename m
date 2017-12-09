From: Martin Sperl <kernel@martin.sperl.org>
Subject: Re: Can: FD: configure transmitter delay
Date: Sat, 9 Dec 2017 19:48:17 +0100
Message-ID: <651BC098-5F9A-4B1A-961F-13240ACFE666@martin.sperl.org>
References: <B4DF4571-1790-4F09-8DEC-C0812D0F34B1@martin.sperl.org> <eb6253a6-706b-db3b-9701-3eef2e408d9c@hartkopp.net>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]:43718
        "EHLO cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbdLISsU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 9 Dec 2017 13:48:20 -0500
In-Reply-To: <eb6253a6-706b-db3b-9701-3eef2e408d9c@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org


As far as I can tell dsample-point is the definition of the first
sample point of a data bit (in % of the bit length). It would not 
define the 2nd sample point that would be defined by 
transmitter delay.

Also how would one parametrize: off, fixed or auto with this
parameter(where with auto part of the parameter would be
Automatic, but parts would be fixed?

I understand we need to come to a common denominator.

So maybe it would help summarize the parameters for each
Device to figure out what is common.

Here the info for the mcp2517fd:

bit 17-16 TDCMOD<1:0>: Transmitter Delay Compensation Mode bits; Secondary Sample Point (SSP) 10-11 = Auto; measure delay and add TDCO. 01 = Manual; Don't measure, use TDCV + TDCO from register 00 = TDC Disabled 
bit 14-8 TDCO<6:0>: Transmitter Delay Compensation Offset bits; Secondary Sample Point (SSP) Two's complement; offset can be positive, zero, or negative. 011 1111 =  63 x TSYSCLK ... 000 0000 =  0 x TSYSCLK ... 111 1111 =  –64 x TSYSCLK 
bit 5-0 TDCV<5:0>: Transmitter Delay Compensation Value bits; Secondary Sample Point (SSP) 11 1111 =  63 x TSYSCLK ... 00 0000 =  0 x TSYSCLK

What the microchip reference implementation does is define auto
 and setting vdco while keeping vdcv=0

My initial implementation did set tdc to disabled, but then the 
communication with (for example) PCAN-usb is failing -  have 
this information from someone who has access to this (which 
makes it hard for me to reproduce...)

Martin

> On 09.12.2017, at 19:01, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> 
> Hello Martin,
> 
> we had a discussion on this topic recently which ended here:
> 
> https://marc.info/?l=linux-can&m=150850171310828&w=2
> 
> There was no further discussion since then.
> 
> What is you opinion about using the 'data sample-point' aka dsample-point for transmitter delay configuration?
> 
>   $ ip link set can0 type can help
>    Usage: ip link set DEVICE type can
>        [ bitrate BITRATE [ sample-point SAMPLE-POINT] ] |
>        [ tq TQ prop-seg PROP_SEG phase-seg1 PHASE-SEG1
>          phase-seg2 PHASE-SEG2 [ sjw SJW ] ]
> 
>        [ dbitrate BITRATE [ dsample-point SAMPLE-POINT] ] | <<---
>        [ dtq TQ dprop-seg PROP_SEG dphase-seg1 PHASE-SEG1
>          dphase-seg2 PHASE-SEG2 [ dsjw SJW ] ]
> 
> Best regards,
> Oliver
> 
>> On 12/09/2017 06:01 PM, Martin Sperl wrote:
>> Hi!
>> The mcp2517fd that I am finishing the driver for has some specific
>> settings to configure the transmitter delay which is used with can fd
>> frames (essentially it configures 2nd sample point that takes the
>> delay /latency of the transceiver into account -  can be off, fixed, or
>> automatic).
>> Compatibility tests have already shown that some can fd communication
>> is quite sensitive to these settings - especially between different types
>> of devices - which may result in BUS off situations...
>> So I am wondering how to best allow for configuration of these
>> parameters - module parameters is ugly similarly debugfs or sysfs.
>> I guess there must be other fd devices with similar requirements,
>> so I wonder how it is handled there...
>> Thanks,
>>              Martin
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-can" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

