From: wg <wg@grandegger.com>
Subject: Re: Usb to can driver
Date: Wed, 26 Jun 2013 09:10:47 +0200
Message-ID: <a32451031b577e68f4c79750800c5d71@grandegger.com>
References: <1372204758.9593.13.camel@blackbox>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from uranus.manitu.net ([217.11.48.8]:41940 "EHLO uranus.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751195Ab3FZHKu (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 26 Jun 2013 03:10:50 -0400
In-Reply-To: <1372204758.9593.13.camel@blackbox>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Max S." <max@schneidersoft.net>
Cc: linux-can@vger.kernel.org

Hi Max,



On Tue, 25 Jun 2013 23:59:18 +0000, "Max S." <max@schneidersoft.net>

wrote:

> Some more questions regarding usb to can driver.

> 

> When CAN_CTRLMODE_LISTENONLY is set; why does the start_xmit function

> still get called?

> Its not really a problem, I'm just wondering why when a socket is listen

> only, it still attempts to TX...



Good point. Would be more clever to not start the tx queue in that case.



> My firmware implements LOOPBACK by default. That is all frames sent by

> the can hardware are also returned over usb. I use this effect to call

> can_get_echo_skb() during bulk in. To support LOOPBACK mode as per

> socketcan; should i also call netif_rx() durring bulk in if

> CAN_CTRLMODE_LOOPBACK is

> set?



Message echo (normally via echo_skbs) and loopback (via

CAN_CTRLMODE_LOOPBACK)

are somehow different things. The first is a local loopback of sent

frames,

which is described here:



  http://lxr.linux.no/#linux+v3.9.7/Documentation/networking/can.txt#L178



Be aware that this feature can be switched off by the app via setsockopt

as

described in 4.1.3 and 4.1.4:



  http://lxr.linux.no/#linux+v3.9.7/Documentation/networking/can.txt#L496



Does the hardware communicate a TX done event as well?



CAN_CTRLMODE_LOOPBACK is a real hardware loopback. Normally the message

does

not even go out to the bus mainly useful for testing. For the software the

loopback message should be handled like any other incoming message.



> I am currently using:

> struct __packed gs_host_frame {

> 	u32 echo_id;

> 	u32 can_id;

> 

> 	u32 can_dlc;

> 	u32 channel;

> 	u32 flags;

> 

> 	u8 data[8];

> };

> as the data format between host/device. Using u32 for

> memory alignment as suggested. Is there any way I can reduce the amount

> of wasted space? At 1Mhz std rtr frame is ~21K frames/s. For two

> channels both ways that's 21x2x2=84k frames/s. At 28 bytes per frame

> that's 84x28x8=18.816Mbit/s too much for a USB full-speed device. I

> want to reduce gs_host_frame size and get closer to 12Mbit/s.



I think u8 is ok for echo_id, can_dlc, channel and flags. Just take care

that these 4 bytes are on a 32-bit boundary.



> What is the purpose of enum can_mode and set mode? I see that allot of

> drivers more or less ignore it.

> reacting to only START but not SLEEP or STOP...



It is used for bus-off-recovery as desribed here:



  http://lxr.linux.no/#linux+v3.9.7/Documentation/networking/can.txt#L891



Then CAN_MODE_START is used here:



  http://lxr.linux.no/#linux+v3.9.7/drivers/net/can/dev.c#L440



STOP and SLEEP are currently unused.



Wolfgang.
