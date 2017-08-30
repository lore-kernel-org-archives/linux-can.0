From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: flexcan missing error state transitions
Date: Wed, 30 Aug 2017 12:59:20 +0200
Message-ID: <c3bb7b46-d7f6-b188-73a2-d74e42ebf4f1@grandegger.com>
References: <5213bc7ebd454acea568aba682d696ca@SGPMBX1017.APAC.bosch.com>
 <150333230375.13890.2773067532209799515@maxwell>
 <8e8b90f72f374fb1ab82bc29b8cfc108@SI-MBX1030.de.bosch.com>
 <150333966184.28484.15326759292718336833@maxwell>
 <e54b0db7ec524bcca65e1975aaf13b2b@SI-MBX1030.de.bosch.com>
 <71679863-5b47-faf2-ca44-27eb1abf16c6@pengutronix.de>
 <2ec91a72-49b2-ca43-9472-8f079b278c80@grandegger.com>
 <a257405ba06949a9be5d64912d72d0ba@SGPMBX1017.APAC.bosch.com>
 <23b53bdc-b7d4-f6de-b192-629ffe9795b0@grandegger.com>
 <c5b11618c98a41108dfbe6cf034398f0@SGPMBX1017.APAC.bosch.com>
 <3486f6ae-f4ef-fc94-e706-775f8af60826@grandegger.com>
 <2245ab57e90f44d88e53449156cc1e1b@SGPMBX1017.APAC.bosch.com>
 <6bd916d4-3eb2-c247-2072-6b4c95dd5c69@grandegger.com>
 <9904cd2d80964810b56b8612cc02bfb6@SGPMBX1017.APAC.bosch.com>
 <5faf942d-4680-45a7-74f2-208a2b9f73f8@grandegger.com>
 <db68b0a396574fe7883f962863804a4a@SGPMBX1017.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy03.manitu.net ([217.11.48.67]:56620 "EHLO
        mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbdH3K7X (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 30 Aug 2017 06:59:23 -0400
In-Reply-To: <db68b0a396574fe7883f962863804a4a@SGPMBX1017.APAC.bosch.com>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

Hello ZHU Yi,

Am 30.08.2017 um 11:05 schrieb ZHU Yi (ST-FIR/ENG1-Zhu):
> Hello Wolfgang,
> 
>> From: Wolfgang Grandegger [mailto:wg@grandegger.com]
>> Sent: Wednesday, August 30, 2017 3:16 PM
>>
>> Hello ZHU Yi,
>>
>> Am 30.08.2017 um 08:50 schrieb ZHU Yi (ST-FIR/ENG1-Zhu):
>>> Hello Wolfgang,
>>>
>>>> From: Wolfgang Grandegger [mailto:wg@grandegger.com]
>>>> Sent: Wednesday, August 30, 2017 2:26 PM
>>>>
>>>> Am 30.08.2017 um 06:22 schrieb ZHU Yi (ST-FIR/ENG1-Zhu):
>>>>>
>>>>>> From: Wolfgang Grandegger [mailto:wg@grandegger.com]
>>>>>> Sent: Tuesday, August 29, 2017 7:17 PM
>>>>>>
>>>>>> Am 29.08.2017 um 10:49 schrieb ZHU Yi (ST-FIR/ENG1-Zhu):
>>>>>> [...]
>>>>>>
>>>>>> For the legacy FLEXCAN_QUIRK_BROKEN_ERR_STATE we do not want to
>>>>>> disable
>>>>>> bus error interrupts as well. To handle that properly, I think we need
>>>>> I'm not sure why we do not want to disable error interrupt for legacy broken
>> core,
>>>>> I think if this approach works for both (with/without warning irq) core, then
>>>>> disable the interrupts helps avoid flooding.
>>>>
>>>> How does it work if no cable is connected?  On a legacy device (with
>>>> broken [TR]WRN_INT), no interrupt will arrive other than the bus error
>>>> interrupt. Maybe I have missed something. Unfortunately, I do not have
>>>> any Flexcan device at hand to check myself.
>>> The bus error interrupt means error counter changed, and we can derive correct
>>> state from that. Ah, the node needs to try to send something, otherwise,
>>> the state will not change, but this is valid for all can controllers.
>>
>> Of course, we can always read the error counter on demand. But no
>> interrupt will be triggered after the send. How should the state change
>> then be realized?
> The error interrupt will always be triggered after the send, because the
> auto-retransmission will keep getting Ack error if the cable is not connected,
> that's where the interrupt flooding come from (and the flooding won't stop
> until the cable is connected again).

You mean the error interrupt signalling the ACK error occurs even with
FLEXCAN_CTRL_ERR_MSK *not* set in "ctrl"?
Or is it set from the beginning?

> 
> After the cable is connected, and there're error conditions, e.g., bus short,
> the node would eventually go to bus off, in this case, the flooding will stop
> when it enter bus off state.
> 
> So if auto-retransmission is enabled, then the error interrupt will be generated,
> and we can use this to realize the state change.
> 
> As we understood so far, flexcan core does not have register to disable
> auto-retransmission. Is this understanding correct?

That's what I try to understand as well.

> 
>>
>>>>>>> One more thing regarding patch 2 is, it doesn't rely on error warning
>>>>>>> can be reported by [TR]WRN_INT, because this state can also be reported
>>>>>>> upon the _any_ interrupt. Only bus-off state needs to have dedicated
>>>>>>> interrupt line (is this true for all flexcan core?)
>>>>>>
>>>>>> I don't think so. How should it work if no cable is connected? Anyway,
>>>>>> the patch seems not to be to lenghty.
>>>>> I disabled the [TR]WRN_INT on i.MX6 by change
>>>>> (http://elixir.free-
>> electrons.com/linux/latest/source/drivers/net/can/flexcan.c#L88)
>>>>> to:
>>>>> #define FLEXCAN_CTRL_ERR_STATE FLEXCAN_CTRL_BOFF_MSK
>>>>> and tested with the patch, seems the state transitions still works fine.
>>>>
>>>> With no cable connected?
>>> Yes,
>>> 1. Unplug the cable will change to error passive
>>
>> No cable is connected. Then do an "ifconfig canX up". Then send  a
>> message. The state should change from "active->warning->passive", but
>> that's only realized by the driver if an interrupt is received. On
>> legacy cores, the bus error interrupt does the trigger. Can you show the
>> output of "dmesg| grep flexcan" with "CONFIG_CAN_DEBUG_DEVICES=y" for
>> that scenario, or even better the output of:
>>
>>     # candump -e -td any,0:0,#FFFFFFFF
>>
>>> 2. plug back the cable will eventually change to error active
>>> 3. unplug the cable while the bus is recovering to error warning / error active,
>>> it will report error passive again
>>> 4. repeat plug/unplug the cable and watched the state change as expected
>>
>> It may report something, but only if the TX done interrupt occurs.
> 
> **Test with [TR]WRN_INT enabled:**
> # dmesg | grep flexcan
> [    1.560695] flexcan 2090000.flexcan: 2090000.flexcan supply xceiver not found, using dummy regulator
> [    1.570075] flexcan 2090000.flexcan: can_rx_offload_init_queue: skb_queue_len_max=512
> [    1.570660] flexcan 2090000.flexcan: device registered (reg_base=e0a78000, irq=34)
> [    6.126129] flexcan 2090000.flexcan mob0: renamed from can0
> [  103.057132] flexcan 2090000.flexcan mob0: writing ctrl=0x013a2007
> [  103.057161] flexcan 2090000.flexcan mob0: flexcan_set_bittiming: mcr=0x5980000f ctrl=0x013a2007
> [  103.057178] flexcan 2090000.flexcan mob0: flexcan_chip_start: writing mcr=0x59a3023f
> [  103.057193] flexcan 2090000.flexcan mob0: flexcan_chip_start: writing ctrl=0x013a2057
> [  103.057291] flexcan 2090000.flexcan mob0: flexcan_chip_start: reading mcr=0x40a3023f ctrl=0x013aec57

Here FLEXCAN_CTRL_ERR_MSK (0x4000) is set in "ctrl"!

Could you please add to flexcan_irq():

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 13f0f21..0df0c34 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -758,6 +758,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
        }
 
        reg_esr = flexcan_read(&regs->esr);
+       netdev_dbg(dev, "reg_iflag1=%#x reg_esr=%#x\n", reg_iflag1, regs->esr);
 
        /* ACK all bus error and state change IRQ sources */
        if (reg_esr & FLEXCAN_ESR_ALL_INT) {
	reg_esr = flexcan_read(&regs->esr);
	
This would make cleaner what is going on.

Thanks,

Wolfgang.
