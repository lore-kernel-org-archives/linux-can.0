From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 2/3] can: m_can: Enable M_CAN IP version dependent
 initialization
Date: Sun, 19 Mar 2017 21:16:32 +0100
Message-ID: <e4e32b30-8175-ae44-2afe-0f6099fcf963@hartkopp.net>
References: <1489154417-19669-1-git-send-email-mario.huettel@de.bosch.com>
 <1489154417-19669-4-git-send-email-mario.huettel@de.bosch.com>
 <4f1f7a6f-457f-b1f8-036e-745b5b2c48d5@hartkopp.net>
 <c3d26079-554b-104d-4836-825a8496b66f@de.bosch.com>
 <ffca3229-39f1-cc10-8086-72d7d94bdaef@hartkopp.net>
 <fe3184ee-6f56-33be-db57-4ecb5a9b1cad@hartkopp.net>
 <e04f267c-3f2d-50e6-0e94-982202c994e4@grandegger.com>
 <4e92ae71-e310-ff42-36fc-f734d9fe22c2@hartkopp.net>
 <167b6fb9-870c-60ca-2ae1-605bd8a0cd91@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:18032 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752249AbdCSUQs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 19 Mar 2017 16:16:48 -0400
In-Reply-To: <167b6fb9-870c-60ca-2ae1-605bd8a0cd91@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "Mario.Huettel" <Mario.Huettel@de.bosch.com>, linux-can@vger.kernel.org



On 03/19/2017 08:12 PM, Wolfgang Grandegger wrote:
> Am 19.03.2017 um 18:43 schrieb Oliver Hartkopp:

>>>>> If I understood the frame flow correctly the 'non originating' socket
>>>>> receives two frames:
>>>>>
>>>>> 1. the frame from the completed TX operation (echo_skb / IFF_ECHO)
>>>>> 2. the frame received from the RX path from the hw loopback shortcut
>>>
>>> Yep.
>>>
>>>>> I would suggest to drop the frame coming from the RX path (case 2)
>>>>> when
>>>>> the CAN_CTRLMODE_LOOPBACK gets enabled.
>>>
>>> Why? Mario, what is you motivation/use case?
>>
>> This was just my (Olivers) suggestion.
>>
>> The effect with CAN_CTRLMODE_LOOPBACK enabled would then be similar to
>> using a virtual CAN interface.
>>
>>>> Do we have an agreement on this?
>>>> Did we ever discuss this topic in this detailed manner before?
>>>
>>> As I see it, the CAN_CTRLMODE_LOOPBACK provides a internal hardware
>>> loopback to test the send and receive software (including echo skb). It
>>> has noting to to with echo skbs.
>>
>> Agreed.
>>
>> But the question is what happens to the IFF_ECHO 'mechanism' when the
>> CAN controller is switched into CAN_CTRLMODE_LOOPBACK?
>
> Nothing special. The software does *not* known that the message was
> looped back by the hardware. The TX and RX is treated a usual.
>
>> Do we get a virtual CAN behavior (from IFF_ECHO on driver level) or do
>> we get IFF_ECHO AND a reception due to the controllers loopback?
>
> The latter: The echoed message when TX is done and the RX (from the
> hardware loopback).

But this would be different to normal operation then!

When you have a second CAN interface on a real CAN bus that only ACKs 
your frames but doesn't send own traffic, you only see your echo'ed 
frames in the system (due to successful TX irq notification) - but no RX 
frames.

>>> The loopback mode never got big
>>> attention. I think it's rarely used and if, then just for testing
>>> purposes. That's maybe the reason why this issue was never discussed.

So you vote for "The echoed message when TX is done and the RX (from the 
hardware loopback)." - which reflects the current implementation in 
SJA1000 and M_CAN.

But my question is:

Are developers using CAN_CTRLMODE_LOOPBACK to

1. Run their CAN controller without a working CAN bus hardware
2. To test the hardware loopback mode of the controller

For case 1 the RX frames should be dropped and only the echo'ed frames 
should be provided to the system.

I hopefully was able to clearly describe my concern ...

Regards,
Oliver
