From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 2/3] can: m_can: Enable M_CAN IP version dependent
 initialization
Date: Fri, 17 Mar 2017 18:52:26 +0100
Message-ID: <ffca3229-39f1-cc10-8086-72d7d94bdaef@hartkopp.net>
References: <1489154417-19669-1-git-send-email-mario.huettel@de.bosch.com>
 <1489154417-19669-4-git-send-email-mario.huettel@de.bosch.com>
 <4f1f7a6f-457f-b1f8-036e-745b5b2c48d5@hartkopp.net>
 <c3d26079-554b-104d-4836-825a8496b66f@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:28867 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbdCQRx1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 17 Mar 2017 13:53:27 -0400
In-Reply-To: <c3d26079-554b-104d-4836-825a8496b66f@de.bosch.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Mario.Huettel" <Mario.Huettel@de.bosch.com>, linux-can@vger.kernel.org

Hello Mario,

On 03/17/2017 12:06 PM, Mario.Huettel wrote:
> On 03/16/2017 09:52 AM, Oliver Hartkopp wrote:
>>> * Chip configuaration for CAN_CTRLMODE_LOOPBACK is changed: Enabled
>>>   CCCR_MON bit. In combination with TEST_LBCK it activates the internal
>>>   loopback mode. Leaving CCCR_MON '0' results in external loopback mode.
>>
>> How is the interaction with the IFF_ECHO functionality then?
>
> It is the same as before. Internal loopback mode cuts the connection to
> the CAN RX and TX pins.
>
>
> However, sending a frame with enabled loopback results in following
> situation:
> * The socket that sent a frame receives the looped back frame

In fact it receives the RX frame and not the echo'ed frame, right?

> * Any other socket also receives the looped back frame but, in addition
> to that, they
>    also receive the echo frame created by the driver. Thus the frame is
> received 2 times.

This is bad.

If I understood the frame flow correctly the 'non originating' socket 
receives two frames:

1. the frame from the completed TX operation (echo_skb / IFF_ECHO)
2. the frame received from the RX path from the hw loopback shortcut

I would suggest to drop the frame coming from the RX path (case 2) when 
the CAN_CTRLMODE_LOOPBACK gets enabled.

> I also observe this behavior in the old driver.

Then it was always broken - and should be fixed.
Unfortunately I never had any hardware to test this.

>> Funny thing. So there are 3.2.x IP cores the only support the ISO mode?
>
> Yes. We leave the choice, whether to support Non-ISO operation, to the
> chip manufacturer.
> Many customers want a fixed ISO-behavior as it reduces the risk of a
> false configuration.

Interesting background.

> Regarding the code issues you highlighted. I fully agree with them and
> will fix them for patch v2.

Thanks.

Best regards,
Oliver

