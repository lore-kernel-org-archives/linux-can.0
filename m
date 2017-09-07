From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 3/4] can: flexcan: implement error passive state quirk
Date: Thu, 7 Sep 2017 09:26:42 +0200
Message-ID: <1685670a-c87d-2204-7e46-c36ebb8b072f@grandegger.com>
References: <87faf67d90a246938e0b51d2ddbc8b82@SGPMBX1017.APAC.bosch.com>
 <cc678b44-0aa8-ac91-567e-8b9c234ed024@grandegger.com>
 <ad3cf1da-ca4b-6149-876a-0c983f9d48c8@grandegger.com>
 <dfb4fd69b6d0463ca565245f4c072b90@SGPMBX1017.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy02.manitu.net ([217.11.48.66]:34500 "EHLO
        mailproxy02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751398AbdIGH0o (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 7 Sep 2017 03:26:44 -0400
In-Reply-To: <dfb4fd69b6d0463ca565245f4c072b90@SGPMBX1017.APAC.bosch.com>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

Hello ZHU Yi,

Am 07.09.2017 um 08:01 schrieb ZHU Yi (ST-FIR/ENG1-Zhu):
> Hello Wolfgang,
> 
>> From: Wolfgang Grandegger [mailto:wg@grandegger.com]
>> Sent: Thursday, September 07, 2017 4:17 AM
>> Hello ZHU Yi,
>>
>> now testing on an i.MX53 board (quirks=2):
>>
>> Am 06.09.2017 um 13:47 schrieb Wolfgang Grandegger:
[snip]
>> I need here:
>> 
>> 	    (priv->devtype_data->quirks & (FLEXCAN_QUIRK_BROKEN_PERR_STATE |
>> 					   FLEXCAN_QUIRK_BROKEN_WERR_STATE)) &&
>> 
>> Or maybe better, add FLEXCAN_QUIRK_BROKEN_PERR_STATE to the legacy cores
>> as well.
> The reason why not add FLEXCAN_QUIRK_BROKEN_WERR_STATE here is to leave
> the untested cores which enabled legacy FLEXCAN_QUIRK_BROKEN_ERR_STATE
> before will not be affected by this change, e.g., p1010. If these cores
> are test in future, then the quirks can be updated to throttle the
> interrupt flooding as well.

I tested the i.MX53. The P1010 is an old PowerPC SOC. Can't tell if it's 
error handling is different.

> And to our understanding, there should be no existing FlexCAN core
> which missing [TR]WRN_INT but having error passive interrupt, that
> means FLEXCAN_QUIRK_BROKEN_WERR_STATE should never been set alone
> if set the [PW]ERR_STATE quirks according to the hardware feature.

Yep.

> The combination of these two quirks should be:
> 1. FLEXCAN_QUIRK_BROKEN_PERR_STATE is set for new core
> 2. FLEXCAN_QUIRK_BROKEN_WERR_STATE | FLEXCAN_QUIRK_BROKEN_PERR_STATE
>    are set for old core
> 3. None of these quirks been set for the future core which capable of
>    generate state interrupt for all state transitions

Yep.

> If we add the WERR_STATE here, the pros is the old core will automatic
> take advantage of this change, the cons is the quirks do not need to
> match the exact hardware feature, which may lead to a bit chaos IMHO.

Well, it's not always possible to make it right for all hardware 
variants. People will speak up in case of problems.

> What do you think?

I would set FLEXCAN_QUIRK_BROKEN_PERR_STATE for the legacy cores as 
well. I have an i.MX28 board here as well. It should not need the 
quirks. Will test it later this week.

[snip]
>> Here is the annotated trace when unplugging and reconnecting the cable:
>>
>> # ip link set can0 txqueuelen 1000 up type can bitrate 1000000
>> # cansend can0 123#abcd
>> flexcan 53fc8000.can can0: ctrl=0x11aec53 reg_iflag=0x200 reg_esr=0x80 err=0/0
>>
>> *** disconnect CAN cable ***
>>
>> # cansend can0 123#abcd
>> flexcan 53fc8000.can can0: ctrl=0x11aec53 reg_iflag=0x0 reg_esr=0x2042 err=8/0
>> flexcan 53fc8000.can can0: ctrl=0x11aec53 reg_iflag=0x0 reg_esr=0x22252 err=128/0
>> flexcan 53fc8000.can can0: state 0->2 ctrl
>>
>> It jumps immediately to error passive!
> On i.MX6 it doesn't jump, supprise of i.MX53 :)
> 
>>
>> *** reconnect CAN cable ***
>>
>> flexcan 53fc8000.can can0: ctrl=0x11aac53 reg_iflag=0x200 reg_esr=0x2292 err=135/0
>>
>> The error counter jumps to 135... weird!
> A possible explanation is, while reconnecting, the error counter first
> decrease by 1, and then increase by 8, so we get 135. But if this is
> the case, due to the auto-retransmission will only sent one frame, that
> means i.MX53 doesn't strict to the error counter decrease rule:
> 12.1.4.2 Error counting
> g) After the successful transmission of a frame (getting ACK and no
>     error has been detected until EOF is finished), the transmit error
>     counter shall be decremented by 1 unless it was already 0.
> So we should get either 127 if succeed, or 128 if ACK error detected.

Well, the error handling of that core is just buggy.

>> # cansend can0 123#abcd
>> flexcan 53fc8000.can can0: ctrl=0x11aac53 reg_iflag=0x200 reg_esr=0x290 err=134/0
>> ...
>> # cansend can0 123#abcd
>> flexcan 53fc8000.can can0: ctrl=0x11aac53 reg_iflag=0x200 reg_esr=0x290 err=128/0
>> # cansend can0 123#abcd
>> flexcan 53fc8000.can can0: ctrl=0x11aac53 reg_iflag=0x200 reg_esr=0x280 err=127/0
>> flexcan 53fc8000.can can0: state 2->1 ctrl
>>
>> Then it takes some transfers before error warning is reached.
>>
>> # cansend can0 123#abcd
>> flexcan 53fc8000.can can0: ctrl=0x11aec53 reg_iflag=0x200 reg_esr=0x280 err=126/0
>> ...
>> # cansend can0 123#abcd
>> flexcan 53fc8000.can can0: ctrl=0x11aec53 reg_iflag=0x200 reg_esr=0x280 err=97/0
>> # cansend can0 123#abcd
>> flexcan 53fc8000.can can0: ctrl=0x11aec53 reg_iflag=0x200 reg_esr=0x280 err=96/0
>> # cansend can0 123#abcd
>> flexcan 53fc8000.can can0: ctrl=0x11aec53 reg_iflag=0x200 reg_esr=0x80 err=95/0
>> flexcan 53fc8000.can can0: state 1->0 ctrl
>> # cansend can0 123#abcd
>> flexcan 53fc8000.can can0: ctrl=0x11aec53 reg_iflag=0x200 reg_esr=0x80 err=94/0
>>
>> *** disconnect CAN cable again ***
>>
>> # cansend can0 123#abcd
>> flexcan 53fc8000.can can0: ctrl=0x11aec53 reg_iflag=0x0 reg_esr=0x22242 err=98/0
>> flexcan 53fc8000.can can0: state 0->1 ctrl
>> flexcan 53fc8000.can can0: ctrl=0x11aec53 reg_iflag=0x0 reg_esr=0x2252 err=130/0
>> flexcan 53fc8000.can can0: state 1->2 ctrl
>>
>> This time error warning is signalled". And here is with short-circuiting
>> CAN low and high:
>>
>> # cansend can0 123#abcd
>> flexcan 53fc8000.can can0: ctrl=0x11aec53 reg_iflag=0x0 reg_esr=0x24252 err=136/0
>> flexcan 53fc8000.can can0: state 0->2 ctrl
>> flexcan 53fc8000.can can0: ctrl=0x11aac53 reg_iflag=0x0 reg_esr=0x4034 err=0/0
>> flexcan 53fc8000.can can0: state 2->3 ctrl
>> # ip link set can0 type can restart
>>
>> Even if the state reporting is kind of weird with that core, interrupt flooding
>> does not happen.
> Great! The patch seems work on this core too. :)

Yes, it works for the i.MX53, at least.

> BTW, do you apply the patch from the inline text of the e-mail? We are
> curious of whether outlook 2013 is able to send inline patch or not.

No problem, "git am" worked like a charm.

Wolfgang.
