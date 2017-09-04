From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 3/6] can: flexcan: add error passive state quirk
Date: Mon, 4 Sep 2017 21:57:01 +0200
Message-ID: <6f1d4dbc-4f4d-ee10-00be-ab1fb3ec7a98@grandegger.com>
References: <3cbb306756434138b1c80fd76ecace8d@SGPMBX1017.APAC.bosch.com>
 <f43242ea-ca7e-8d56-880f-cd629759d185@grandegger.com>
 <a61de24480c0400ca438d4bcc974f7a7@SGPMBX1017.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy03.manitu.net ([217.11.48.67]:41780 "EHLO
        mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753957AbdIDT5E (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 4 Sep 2017 15:57:04 -0400
In-Reply-To: <a61de24480c0400ca438d4bcc974f7a7@SGPMBX1017.APAC.bosch.com>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

Hello,

Am 04.09.2017 um 12:00 schrieb ZHU Yi (ST-FIR/ENG1-Zhu):
> Hello Wolfgang,
> 
>>> From: Wolfgang Grandegger [mailto:wg@grandegger.com]
>>> Sent: Thursday, August 31, 2017 7:44 PM
>>>
>>> [...]
>>>
>>> Do we want to enable the error interrupt from the beginning? We can
>>> wait for the error warning interrupt!?
>> That's another good catch, if only FLEXCAN_QUIRK_BROKEN_PERR_STATE
>> been set, then it don't need to enable the error interrupt from the
>> beginning. This can save us at most 11 times error interrupts on
>> these cores when there are bus problems.
>>
>> If FLEXCAN_QUIRK_BROKEN_WERR_STATE is set, then the error interrupt
>> is still enabled from the beginning (for the old core which do not
>> have [TR]WRN_INT connected).
>>
>> However, this may complicates the handling inside flexcan_irq().
>>
>> In sunny day scenario, [...]
>>
>> In rainy day scenario, that is due to some unbelievable reason,
>> flexcan_irq_state() maybe called jumps some state transitions,
>> hence we added:
>> 1. explicitly disable error interrupt in bus off, to prevent
>>     surprise of still get error interrupts when the error state
>>     jump from active/warning to bus off (although in theory, bus
>>     off should not generate any interrupts, even the interrupt
>>     are enabled).
>> 2. explicitly enable error interrupt in error active, to prevent
>>     the error state jump from error passive to error active which
>>     leaves error interrupt still disabled, then on the old core,
>>     it cannot report correct state transitions again (in theory,
>>     this should not happen too).
>>
>> If we take these defensive thinking into account, then it will
>> results a complicated logic here - we need to differentiate the
>> old and new core, and handle them separately.
>>
>> Maybe we're a bit paranoic here, but we think the decision should
>> be considered among performance, reliability and maintainability.
>>
>> Here we think the performance gain is limited, because in worst case,
>> we get 11 times useless interrupt on the new core when every time the
>> bus has problem, and this is the best gain we can have. But on the
>> other hand, if we sacrifice this gain, we can get better reliability
>> (perhaps) and maintainability (same code for new and old core).
>>
>> What do you think?
> After some deep thinking, we realized that actually we can achieve
> all instead of sacrifice any one of aforementioned three points.
> 
> The pseudo code looks like below:
> ```
> if (state_changed &&
>      (priv->devtype_data->quirks & FLEXCAN_QUIRK_BROKEN_PERR_STATE) &&
>     !(priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)) {
> 	switch (priv->can.state) {
> 	case CAN_STATE_ERROR_PASSIVE:
> 	case CAN_STATE_BUS_OFF:
> 		// disable error interrupt
> 		break;
> 
> 	case CAN_STATE_ERROR_WARNING:
> 		// enable error interrupt
> 		break;
> 
> 	case CAN_STATE_ERROR_ACTIVE:
> 		if (!(priv->devtype_data->quirks & FLEXCAN_QUIRK_BROKEN_WERR_STATE))

This means that you have both set, FLEXCAN_QUIRK_BROKEN_WERR_STATE and 
FLEXCAN_QUIRK_BROKEN_PERR_STATE for the legacy cores.

> 			// disable error interrupt
> 		else
> 			// enable error interrupt
> 		break;
> 
> 	default:
> 		break;
> 	}
> }
> ```
> 
> In this way, we can achieve the optimization for the new core, and also
> take care of the paranoic cases, and the readability IMHO looks not bad. :)
> 
> Below are the test results (based on v4.11 with the proposed patches).
> 
> Test case:
> 1. Disconnect the cable
> 2. "ip link set xxx type can bitrate 500000" and "ip link set xxx up"
> 3. "cansend xxx 123#ffffffffffffffff"
> 
> Enabled [TR]WRN_INT and FLEXCAN_QUIRK_BROKEN_PERR_STATE on i.MX6:
> # dmesg | grep flexcan
> [    1.561013] flexcan 2090000.flexcan: 2090000.flexcan supply xceiver not found, using dummy regulator
> [    1.570393] flexcan 2090000.flexcan: can_rx_offload_init_queue: skb_queue_len_max=512
> [    1.570979] flexcan 2090000.flexcan: device registered (reg_base=e0a78000, irq=34)
> [    6.085287] flexcan 2090000.flexcan mob0: renamed from can0
> [   39.118751] flexcan 2090000.flexcan mob0: writing ctrl=0x013a2007
> [   39.118779] flexcan 2090000.flexcan mob0: flexcan_set_bittiming: mcr=0x5980000f ctrl=0x013a2007
> [   39.118797] flexcan 2090000.flexcan mob0: flexcan_chip_start: writing mcr=0x59a3023f
> [   39.118813] flexcan 2090000.flexcan mob0: flexcan_chip_start: writing ctrl=0x013a2057
> [   39.118910] flexcan 2090000.flexcan mob0: flexcan_chip_start: reading mcr=0x40a3023f ctrl=0x013aac57
> [   53.873593] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x62242
> [   53.873624] flexcan 2090000.flexcan mob0: New error state: 1
> [   53.873833] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42242
> [   53.874089] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42242
> [   53.874348] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42242
> [   53.874608] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42252
> [   53.874627] flexcan 2090000.flexcan mob0: New error state: 2
> 
> Disabled [TR]WRN_INT and enabled FLEXCAN_QUIRK_BROKEN_PERR_STATE +
> FLEXCAN_QUIRK_BROKEN_WERR_STATE on i.MX6:
> # dmesg | grep flexcan
> [    1.561071] flexcan 2090000.flexcan: 2090000.flexcan supply xceiver not found, using dummy regulator
> [    1.570452] flexcan 2090000.flexcan: can_rx_offload_init_queue: skb_queue_len_max=512
> [    1.571037] flexcan 2090000.flexcan: device registered (reg_base=e0a78000, irq=34)
> [    6.126949] flexcan 2090000.flexcan mob0: renamed from can0
> [   81.924194] flexcan 2090000.flexcan mob0: writing ctrl=0x013a2007
> [   81.924225] flexcan 2090000.flexcan mob0: flexcan_set_bittiming: mcr=0x5980000f ctrl=0x013a2007
> [   81.924243] flexcan 2090000.flexcan mob0: flexcan_chip_start: writing mcr=0x5983023f
> [   81.924258] flexcan 2090000.flexcan mob0: flexcan_chip_start: writing ctrl=0x013a2057
> [   81.924361] flexcan 2090000.flexcan mob0: flexcan_chip_start: reading mcr=0x4083023f ctrl=0x013ae057
> [   98.428902] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42042
> [   98.429145] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42042
> [   98.429400] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42042
> [   98.429666] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42042
> [   98.429975] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42042
> [   98.430183] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42042
> [   98.430442] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42042
> [   98.430706] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42042
> [   98.430962] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42042
> [   98.431221] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42042
> [   98.431484] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42042
> [   98.431746] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42242
> [   98.431775] flexcan 2090000.flexcan mob0: New error state: 1
> [   98.432001] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42242
> [   98.432262] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42242
> [   98.432523] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42242
> [   98.432781] flexcan 2090000.flexcan mob0: reg_iflag1=0x0 reg_esr=0x42252
> [   98.432806] flexcan 2090000.flexcan mob0: New error state: 2

Could you please show the full trace when reconnecting the cable to see 
how the state decreases. And then again unplug the cable. And send a 
message.

Wolfgang.
