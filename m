From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: flexcan missing error state transitions
Date: Thu, 31 Aug 2017 11:53:43 +0200
Message-ID: <5c1b52f3-56b9-b885-add2-57b5fbc05107@grandegger.com>
References: <5213bc7ebd454acea568aba682d696ca@SGPMBX1017.APAC.bosch.com>
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
 <c3bb7b46-d7f6-b188-73a2-d74e42ebf4f1@grandegger.com>
 <1305c2749a86402fa15c48113bb0ed54@SGPMBX1017.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy03.manitu.net ([217.11.48.67]:59594 "EHLO
        mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbdHaJxq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 31 Aug 2017 05:53:46 -0400
In-Reply-To: <1305c2749a86402fa15c48113bb0ed54@SGPMBX1017.APAC.bosch.com>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

Hello ZHU Yi,

Am 31.08.2017 um 10:33 schrieb ZHU Yi (ST-FIR/ENG1-Zhu):
> Hello Wolfgang,
> 
>> From: Wolfgang Grandegger [mailto:wg@grandegger.com]
>> Sent: Wednesday, August 30, 2017 6:59 PM
>> [...]
>>
>>> The error interrupt will always be triggered after the send, because the
>>> auto-retransmission will keep getting Ack error if the cable is not connected,
>>> that's where the interrupt flooding come from (and the flooding won't stop
>>> until the cable is connected again).
>>
>> You mean the error interrupt signalling the ACK error occurs even with
>> FLEXCAN_CTRL_ERR_MSK *not* set in "ctrl"?
>> Or is it set from the beginning?
> Sorry for the incomplete description, I forgot to mention it is assumed
> that the broken error state quirk fix is enabled for the core, hence
> the error interrupt is enabled from the beginning.

OK.

> Although only p1010 enabled the quirk so far, but to our understanding,
> the rest core seems also need the quirk enabled to report correct state
> transitions, e.g., i.MX6.

I will have a i.MX53 and i.MX28 board soon on my table to check error 
passive handling. Would be nice to reduce interrupt flooding on these as 
well.

> However, as neither of us can test the legacy and other cores, so we
> cannot touch them without testing. Perhaps someone who has the access
> to these cores can give a hand to verify that in future.

Other tester are welcome!

>>
>> [...]
>> Here FLEXCAN_CTRL_ERR_MSK (0x4000) is set in "ctrl"!
>>
>> Could you please add to flexcan_irq():
>>
>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
>> index 13f0f21..0df0c34 100644
>> --- a/drivers/net/can/flexcan.c
>> +++ b/drivers/net/can/flexcan.c
>> @@ -758,6 +758,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
>>          }
>>
>>          reg_esr = flexcan_read(&regs->esr);
>> +       netdev_dbg(dev, "reg_iflag1=%#x reg_esr=%#x\n", reg_iflag1, regs->esr);
>>
>>          /* ACK all bus error and state change IRQ sources */
>>          if (reg_esr & FLEXCAN_ESR_ALL_INT) {
>> 	reg_esr = flexcan_read(&regs->esr);
>>
>> This would make cleaner what is going on.
> Sure. Below test is based on kernel v4.11 with the proposed patches.
> To demonstrate the theory of the legacy cores should also work, the
> "[TR]WRN_INT" are disabled.
> (clear WRN_EN in MCR and [TR]WRN_MSK in CTRL1)

OK, then I understand how the following works:
> Test case:
> 1. Disconnect the cable
> 2. "ip link set xxx type can bitrate 500000" and "ip link set xxx up"
> 3. "cansend xxx 123#ffffffffffffffff"
> 
> # dmesg | grep flexcan
> [    1.561243] flexcan 2090000.flexcan: 2090000.flexcan supply xceiver not found, using dummy regulator
> [    1.570621] flexcan 2090000.flexcan: can_rx_offload_init_queue: skb_queue_len_max=512
> [    1.571207] flexcan 2090000.flexcan: device registered (reg_base=e0a78000, irq=34)
> [    6.227746] flexcan 2090000.flexcan mob0: renamed from can0
> [   34.400669] flexcan 2090000.flexcan mob0: writing ctrl=0x013a2007
> [   34.400698] flexcan 2090000.flexcan mob0: flexcan_set_bittiming: mcr=0x5980000f ctrl=0x013a2007
> [   34.400715] flexcan 2090000.flexcan mob0: flexcan_chip_start: writing mcr=0x5983023f
> [   34.400731] flexcan 2090000.flexcan mob0: flexcan_chip_start: writing ctrl=0x013a2057
> [   34.400829] flexcan 2090000.flexcan mob0: flexcan_chip_start: reading mcr=0x4083023f ctrl=0x013ae057
> [   44.112307] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42042
> [   44.112547] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42042
> [   44.112810] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42042
> [   44.113074] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42042
> [   44.113331] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42042
> [   44.113603] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42042
> [   44.113851] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42042
> [   44.114124] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42042
> [   44.114367] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42042
> [   44.114631] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42042
> [   44.114884] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42042
> [   44.115142] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42242
> [   44.115162] flexcan 2090000.flexcan mob0: New error state: 1
> [   44.115404] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42242
> [   44.115661] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42242
> [   44.115921] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42242
> [   44.116180] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42252
> [   44.116199] flexcan 2090000.flexcan mob0: New error state: 2

We disable the bus errors when error passive is reached. But what 
happens if the error state decreases. It will require successful 
transmissions. When the TX done interrupt comes, changes to error 
warning are realized. Then we re-enable the error interrupt. But below 
error warning, we would like to disable the error interrupt (for the 
mx6q). That might be a problem but could be fixed by special treatment 
(for legacy cores).

Wolfgang.
