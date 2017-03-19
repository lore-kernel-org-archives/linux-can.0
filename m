From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 2/3] can: m_can: Enable M_CAN IP version dependent
 initialization
Date: Sun, 19 Mar 2017 15:44:47 +0100
Message-ID: <91845de3-a9ed-a6e2-a7ba-f63ae0320f44@grandegger.com>
References: <1489154417-19669-1-git-send-email-mario.huettel@de.bosch.com>
 <1489154417-19669-4-git-send-email-mario.huettel@de.bosch.com>
 <4f1f7a6f-457f-b1f8-036e-745b5b2c48d5@hartkopp.net>
 <c3d26079-554b-104d-4836-825a8496b66f@de.bosch.com>
 <ffca3229-39f1-cc10-8086-72d7d94bdaef@hartkopp.net>
 <fe3184ee-6f56-33be-db57-4ecb5a9b1cad@hartkopp.net>
 <e04f267c-3f2d-50e6-0e94-982202c994e4@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy03.manitu.net ([217.11.48.67]:47484 "EHLO
        mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751463AbdCSOov (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 19 Mar 2017 10:44:51 -0400
In-Reply-To: <e04f267c-3f2d-50e6-0e94-982202c994e4@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "Mario.Huettel" <Mario.Huettel@de.bosch.com>, linux-can@vger.kernel.org


Am 19.03.2017 um 14:59 schrieb Wolfgang Grandegger:
> Hi Oliver,
>
> Am 18.03.2017 um 14:27 schrieb Oliver Hartkopp:
>> Hi Marc, Wolfgang,
>>
>> On 03/17/2017 06:52 PM, Oliver Hartkopp wrote:
>>> On 03/17/2017 12:06 PM, Mario.Huettel wrote:
>>>> On 03/16/2017 09:52 AM, Oliver Hartkopp wrote:
>>>>>> * Chip configuaration for CAN_CTRLMODE_LOOPBACK is changed: Enabled
>>>>>>   CCCR_MON bit. In combination with TEST_LBCK it activates the
>>>>>> internal
>>>>>>   loopback mode. Leaving CCCR_MON '0' results in external loopback
>>>>>> mode.
>>>>>
>>>>> How is the interaction with the IFF_ECHO functionality then?
>>>>
>>>> It is the same as before. Internal loopback mode cuts the connection to
>>>> the CAN RX and TX pins.
>>>>
>>>> However, sending a frame with enabled loopback results in following
>>>> situation:
>>>> * The socket that sent a frame receives the looped back frame
>>>
>>> In fact it receives the RX frame and not the echo'ed frame, right?
>>>
>>>> * Any other socket also receives the looped back frame but, in addition
>>>> to that, they
>>>>    also receive the echo frame created by the driver. Thus the frame is
>>>> received 2 times.
>>>
>>> This is bad.
>>>
>>> If I understood the frame flow correctly the 'non originating' socket
>>> receives two frames:
>>>
>>> 1. the frame from the completed TX operation (echo_skb / IFF_ECHO)
>>> 2. the frame received from the RX path from the hw loopback shortcut
>
> Yep.
>
>>> I would suggest to drop the frame coming from the RX path (case 2) when
>>> the CAN_CTRLMODE_LOOPBACK gets enabled.
>
> Why? Mario, what is you motivation/use case?
>
>> Do we have an agreement on this?
>> Did we ever discuss this topic in this detailed manner before?
>
> As I see it, the CAN_CTRLMODE_LOOPBACK provides a internal hardware
> loopback to test the send and receive software (including echo skb). It
> has noting to to with echo skbs. The loopback mode never got big
> attention. I think it's rarely used and if, then just for testing
> purposes. That's maybe the reason why this issue was never discussed.
> There might even be hardware specific issues, e.g. some controller may
> not even do the loopback like the SJA1000.

I just see that CAN_CTRLMODE_LOOPBACK is even undocumented :(, like most 
other CTRLMODEs.

Wolfgang.
