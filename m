From: Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: Re: [RFC PATCH] can: add tx/rx led trigger support
Date: Wed, 11 Apr 2012 21:11:13 +0200
Message-ID: <CABkP77fhZateRcscBK0NsZWKGBA2x5eF0Sz8-5urzVKVvzt4Xw@mail.gmail.com>
References: <1334093965-2692-1-git-send-email-fabio.baltieri@gmail.com>
	<4F859927.1040404@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:41529 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756105Ab2DKTLO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Apr 2012 15:11:14 -0400
Received: by wibhj6 with SMTP id hj6so4731637wib.1
        for <linux-can@vger.kernel.org>; Wed, 11 Apr 2012 12:11:13 -0700 (PDT)
In-Reply-To: <4F859927.1040404@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org

Hello Wolfgang,

On Wed, Apr 11, 2012 at 4:45 PM, Wolfgang Grandegger <wg@grandegger.com=
> wrote:
>> this is a try to add generic tx/rx LED triggers for canbus interface=
s, somthing
>> I think is very useful in embedded systems where canbus devices ofte=
n have
>> status leds associated with them, maybe on the bus connector itself,=
 like
>
> Please define "often"? So far only a few CAN devices need LED control=
 by
> software. Actually, I only remember the PEAK PCMCIA card.

I'm actually referring to SoC-based boards with led-class supported
LEDs, which can be linked to kernel events (like
wifi-association/activity etc...).

>> ethernet interfaces. I saw a couple of hardware implementation to dr=
ive status
>> leds from tx/rx lines but these were not as effective as software on=
es.
>
> Why? LEDs are ususally controlled by software only if the hardware do=
es
> not do it (properly?). But your LED support cannot be compared with t=
he
> LEDs on the CAN devices itself.

I agree for "smart" CAN interfaces - like USB ones. What I had in mind
are embedded canbus controllers, which does not provide any activity
indication signal (as ethernet PHYs does). In that case I saw some
hardware implementation which try to drive LEDs from TX/RX signals of
the single-ended bus between controller and transceiver, and in that
case LEDs barely turns on for single packets and you can't have
individual tx/rx indication as the RX driver in the transceiver is
always active.

>> The implementation is similar to the MAC80211_LEDS one, and takes qu=
ite a lot
>> of inspiration and some code from it.
>>
>> In this case, however, tx and rx events are trapped from the af_can =
source file
>> as there are no generic tx/rx functions in can/dev.c. This also requ=
ired an
>> additional counter to discard rx events for looped frames.
>
> Well, controlling the LEDs from the protocol level seems wrong to me.=
 If
> at all, it should be handled by the CAN device interface.

Agreed, that was a try to keep it driver-independent. I'll rework the
code as suggested by Oliver.

>> Also, as all the support data are in the can_priv structure, this on=
ly supports
>> can-dev based drivers. All the others are ignored by checking the
>> netdev->rtnl_link_ops->kind string. This actually excludes only vcan=
 and slcan
>> drivers.
>>
>> The implementation should be quite unintrusive on existing code and =
can be disabled
>> altogether with a config option.
>
> I find it rather intrusive, especially when #ifdef's should be avoide=
d.

I only used one in "struct can_priv" and then redefined trap functions
to inline-noop. Is that a better way to do that?

> Furthermore it introduces overhead in the RX and TX path and uses a l=
ot
> of space in the "struct can_priv".

Ok for tx/rx path overhead, I did not like the solution either.

>> This has been tested tested on x86 and a powerpc with a custom USB-C=
AN
>> interface (which I hope to publish as open-hardware soon BTW) and i2=
c-based
>> leds.
>>
>> Any thoughts? Do you think this can be merged?
>
> LED interface might be useful, especially for debugging. Why not
> enabling it just if "CONFIG_CAN_DEBUG_DEVICES=3Dy". Also LEDs for err=
or
> states would make sense.

I see that more useful for an installer of the system to see that the
bus is working than for debugging the driver, also because what I had
in mind was some kind of device with front-panel connector and status
leds.

Agreed for error state. Of course that have to be trapped in the driver=
 too.

> Some more comments inline...
>
>> =A0include/linux/can/dev.h | =A0 =A09 +++
>> =A0net/can/Kconfig =A0 =A0 =A0 =A0 | =A0 10 +++
>> =A0net/can/Makefile =A0 =A0 =A0 =A0| =A0 =A02 +
>> =A0net/can/af_can.c =A0 =A0 =A0 =A0| =A0 14 ++++-
>> =A0net/can/led.c =A0 =A0 =A0 =A0 =A0 | =A0154 ++++++++++++++++++++++=
+++++++++++++++++++++++++
>> =A0net/can/led.h =A0 =A0 =A0 =A0 =A0 | =A0 29 +++++++++
>> =A06 files changed, 217 insertions(+), 1 deletions(-)
>> =A0create mode 100644 net/can/led.c
>> =A0create mode 100644 net/can/led.h
>>
>> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
>> index 5d2efe7..76eb70c 100644
>> --- a/include/linux/can/dev.h
>> +++ b/include/linux/can/dev.h
>> @@ -16,6 +16,8 @@
>> =A0#include <linux/can.h>
>> =A0#include <linux/can/netlink.h>
>> =A0#include <linux/can/error.h>
>> +#include <linux/timer.h>
>> +#include <linux/leds.h>
>>
>> =A0/*
>> =A0 * CAN mode
>> @@ -52,6 +54,13 @@ struct can_priv {
>>
>> =A0 =A0 =A0 unsigned int echo_skb_max;
>> =A0 =A0 =A0 struct sk_buff **echo_skb;
>> +
>> +#ifdef CONFIG_CAN_LEDS
>> + =A0 =A0 struct timer_list tx_off_timer, rx_off_timer;
>> + =A0 =A0 struct led_trigger *tx_led, *rx_led;
>> + =A0 =A0 char tx_led_name[32], rx_led_name[32];
>> + =A0 =A0 atomic_t led_discard_count;
>> +#endif
>
> This requires a lot of space. Please add just *one* pointer here and
> allocate the required space when needed.

How would that help?

>> =A0};
>>
>> =A0/*
>> diff --git a/net/can/Kconfig b/net/can/Kconfig
>> index 0320069..55894b7 100644
>> --- a/net/can/Kconfig
>> +++ b/net/can/Kconfig
>> @@ -52,4 +52,14 @@ config CAN_GW
>> =A0 =A0 =A0 =A0 They can be modified with AND/OR/XOR/SET operations =
as configured
>> =A0 =A0 =A0 =A0 by the netlink configuration interface known e.g. fr=
om iptables.
>>
>> +config CAN_LEDS
>> + =A0 =A0 bool "Enable LED triggers for Netlink based drivers"
>> + =A0 =A0 depends on CAN
>> + =A0 =A0 depends on CAN_DEV
>> + =A0 =A0 depends on LEDS_CLASS
>> + =A0 =A0 select LEDS_TRIGGERS
>> + =A0 =A0 ---help---
>> + =A0 =A0 =A0 This option enables two LED triggers for packet receiv=
e and transmit
>> + =A0 =A0 =A0 events on each CAN device based on the can-dev framewo=
rk.
>> +
>> =A0source "drivers/net/can/Kconfig"
>> diff --git a/net/can/Makefile b/net/can/Makefile
>> index cef49eb..fc6b286 100644
>> --- a/net/can/Makefile
>> +++ b/net/can/Makefile
>> @@ -5,6 +5,8 @@
>> =A0obj-$(CONFIG_CAN) =A0 =A0+=3D can.o
>> =A0can-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D af_can.=
o proc.o
>>
>> +can-$(CONFIG_CAN_LEDS) =A0 =A0 =A0 +=3D led.o
>> +
>> =A0obj-$(CONFIG_CAN_RAW) =A0 =A0 =A0 =A0+=3D can-raw.o
>> =A0can-raw-y =A0 =A0 =A0 =A0 =A0 =A0:=3D raw.o
>
> In this file you only find things for CAN protocol support. LEDs shou=
ld
> be handled by drivers/net/can/dev.c.

Agreed.

Thanks for the feedback.

Regards.

--=20
=46abio Baltieri
