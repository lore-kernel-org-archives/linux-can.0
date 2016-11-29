From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: wrong CAN frame order in network layer due to SMP?
Date: Tue, 29 Nov 2016 20:48:09 +0100
Message-ID: <45353231-7efa-7feb-b52d-569a88317cdf@hartkopp.net>
References: <1864402.pXgGBBp51L@ws-stein> <3312577.WzoMqUrz0A@ws-stein>
 <c9a4e53c-42f8-c982-e701-0259fb1ac67b@hartkopp.net>
 <5633679.WId9jP25Qd@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:34596 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751726AbcK2TsY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 29 Nov 2016 14:48:24 -0500
In-Reply-To: <5633679.WId9jP25Qd@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org, =?UTF-8?Q?Daniel_Kr=c3=bcger?= <daniel.krueger@systec-electronic.com>

Hello Alexander,

On 11/29/2016 11:30 AM, Alexander Stein wrote:
> On Monday 28 November 2016 21:36:09, Oliver Hartkopp wrote:
>> IIRC Wireshark puts the PF_PACKET socket into some special 'tpacket'
>> mode and I don't know whether this has any impact on frame ordering.
>>
>> At least you may check for:
>> https://github.com/linux-can/can-tests/blob/master/tst-packet.c
>>
>> ... if there's a difference between PF_PACKET and PF_CAN with your OOO
>> setup.
>
> Nope, apparently there is no difference. Got similar results.
>
> On a side note: I captured an 30 seconds iperf3 run with wireshark 2.2.2 using
> the "ASIX Electronics Corp. AX88179 Gigabit Ethernet" adapter (driver:
> ax88179_178a).
> AFAICS this driver (well usbnet in the end) doesn't use NAPI either and
> therefore unsurprisingly I got OOO of TCP frames.
> IMHO this is not acceptable at all.

Did you have a TCP socket on the receiving host as endpoint for your 
communication?

Maybe this could be named a 'general regression' then. And when this is 
fixed our problem hopefully gets fixed too ;-)

Regards,
Oliver
