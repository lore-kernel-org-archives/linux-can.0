From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 3/4] can: flexcan: implement error passive state quirk
Date: Fri, 8 Sep 2017 09:02:01 +0200
Message-ID: <92d997b5-957e-7e0b-70aa-bff16e289e81@grandegger.com>
References: <87faf67d90a246938e0b51d2ddbc8b82@SGPMBX1017.APAC.bosch.com>
 <cc678b44-0aa8-ac91-567e-8b9c234ed024@grandegger.com>
 <ad3cf1da-ca4b-6149-876a-0c983f9d48c8@grandegger.com>
 <dfb4fd69b6d0463ca565245f4c072b90@SGPMBX1017.APAC.bosch.com>
 <1685670a-c87d-2204-7e46-c36ebb8b072f@grandegger.com>
 <bf6cad90aa9d4e8da439a5ac2e21eafd@SGPMBX1017.APAC.bosch.com>
 <20820cdf-afff-9d04-3c9c-511e45bd0853@grandegger.com>
 <1ccdad7593e34103bd4d96f5b1e64ea7@SGPMBX1017.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy01.manitu.net ([217.11.48.65]:45200 "EHLO
        mailproxy01.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753126AbdIHHCD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Sep 2017 03:02:03 -0400
In-Reply-To: <1ccdad7593e34103bd4d96f5b1e64ea7@SGPMBX1017.APAC.bosch.com>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

Hello ZHU Yi,

Am 08.09.2017 um 08:10 schrieb ZHU Yi (ST-FIR/ENG1-Zhu):
> Hello Wolfgang,
> 
>> From: Wolfgang Grandegger [mailto:wg@grandegger.com]
>> Sent: Friday, September 08, 2017 2:17 AM
>>
>> [...]
>> Error warning is always reported and with the quirk above also error
>> passive. After reconnecting the cable the error counter also jumps to
>> 135. With bus-off, the device also reports 3->0 after bus error
>> recovery:
> 
> i.MX6 don't report 3->0 after bus error recovery (remove short-circuit!?):
> [   74.222135] flexcan 2090000.flexcan mob0: New error state: 2
> [   74.222170] flexcan 2090000.flexcan mob0: reg_ctrl=0x13aac57, reg_iflag1=0x0, reg_esr=0x64252, err=136/0
> [   74.222915] flexcan 2090000.flexcan mob0: New error state: 3
> [   74.222933] flexcan 2090000.flexcan mob0: bus-off
> [   74.222979] flexcan 2090000.flexcan mob0: reg_ctrl=0x13aac57, reg_iflag1=0x0, reg_esr=0x4036, err=0/0
> 
> I'm wondering what is the correct behavior?
> 
> The automatic recovering from bus off is disabled in FlexCAN by write
> 1 to BOFF_REC of CTRL, see
> http://elixir.free-electrons.com/linux/latest/source/drivers/net/can/flexcan.c#L883.
> 
> Hence after the core enters bus off, it needs to stay in this state
> until "restart-ms" or manually restart, according to:

I forgot to mention, I used "restart-ms 100" for my tests with the i.MX28.

> 12.1.4.4 Bus-off management
> [...]
> Upon a restart request, a node which is in the bus-off state shall be
> integrating to the CAN communication (see 10.9.4) and may become
> error-active (no longer bus-off) with its error counters both set to
> zero after having monitored 128 occurrences of the idle condition
> (see 4.28) on the bus (see Figure 28).

On most controllers we do not use the hardware recovery procedure but
just restart the controller. In the past I already had plans to change
that:

http://socket-can.996257.n3.nabble.com/RFC-improve-and-consolidate-state-change-and-bus-off-handling-td2755.html

> But according to below trace, seems i.MX28 still change state to error
> active even there is no restart request.

Restart after 100ms was set. BTW: a restart message is always sent:

http://elixir.free-electrons.com/linux/latest/source/drivers/net/can/dev.c#L545

>> [  674.862816] flexcan 80032000.can can0: ctrl=0x11aac53 reg_iflag=0x0 reg_esr=0x24252 err=138/1
> ctrl: BOFF_MSK=1b, ERR_MSK=0b, [TR]WRN_MSK=11b
> esr:  TWRN_INT=1b, FLT_CONF=01b
> so the state change to error passive upon a "warning" interrupt.
>> [  674.871542] flexcan 80032000.can can0: state 0->2 ctrl
> 
>> [  674.877038] flexcan 80032000.can can0: ctrl=0x11aac53 reg_iflag=0x0 reg_esr=0x4034 err=0/0
> ctrl: BOFF_MSK=1b, ERR_MSK=0b, [TR]WRN_MSK=11b
> esr:  BOFF_INT=1b, FLT_CONF=11b
> so the state change to bus off upon a "bus off" interrupt.
>> [  674.885837] flexcan 80032000.can can0: state 2->3 ctrl
> 
>> root@m28evk:~# [  674.985897] flexcan 80032000.can can0: ctrl=0x11aa053 reg_iflag=0x0 reg_esr=0x4 err=0/0

The log above is approx. 100ms after the previous one.

> ctrl: BOFF_MSK=1b, ERR_MSK=0b, [TR]WRN_MSK=00b
> esr:  BOFF_INT=1b, FLT_CONF=00b
> so the state change to error active upon a "bus off" interrupt.

No, after restart.

>> [  674.994090] flexcan 80032000.can can0: state 3->0 ctrl
> 
> The strange thing is the BOFF_INT generated again without restart,
> and the [TR]WRN_MSK are cleared to 0 when this happen. Because:
> 1. if the node enters bus off, it should not generate irq anymore (right?)

Yes, but some controller still do.

> 2. driver code won't only clear [TR]WRN_MSK but leave BOFF_MSK set
> 
> I'm not sure is the core still able to send/receive frame when it is
> in this "error active" state (without restart).
> 
> If it still works, then the core just performs some magical
> auto-recovery which violates the BOFF_REC setting.

Maybe.

> If it cannot work, then that means wrong state been reported, and
> perhaps another quirk needed for i.MX28 to report bus off instead
> of error active in this case.
> 
> What do you think?

As mentioned above, "restart 100" was used for the link. Unfortunately,
bus-off handling is not consistent for all CAN controllers, as mentioned
in the link above.

Wolfgang.
