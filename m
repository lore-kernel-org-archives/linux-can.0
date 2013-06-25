From: "Max S." <max@schneidersoft.net>
Subject: Usb to can driver
Date: Tue, 25 Jun 2013 23:59:18 +0000
Message-ID: <1372204758.9593.13.camel@blackbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.schneidersoft.net ([173.45.248.65]:58016 "EHLO
	mail.schneidersoft.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081Ab3FYXv5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 25 Jun 2013 19:51:57 -0400
Received: from [192.168.1.13] (unknown [187.90.208.114])
	by mail.schneidersoft.net (Postfix) with ESMTPSA id D84C61A2F2
	for <linux-can@vger.kernel.org>; Tue, 25 Jun 2013 18:52:30 -0500 (CDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Some more questions regarding usb to can driver.

When CAN_CTRLMODE_LISTENONLY is set; why does the start_xmit function still get called?
Its not really a problem, I'm just wondering why when a socket is listen only, it still attempts to TX...

My firmware implements LOOPBACK by default. That is all frames sent by
the can hardware are also returned over usb. I use this effect to call
can_get_echo_skb() during bulk in. To support LOOPBACK mode as per
socketcan; should i also call netif_rx() durring bulk in if CAN_CTRLMODE_LOOPBACK is
set?

I am currently using:
struct __packed gs_host_frame {
	u32 echo_id;
	u32 can_id;

	u32 can_dlc;
	u32 channel;
	u32 flags;

	u8 data[8];
};
as the data format between host/device. Using u32 for
memory alignment as suggested. Is there any way I can reduce the amount
of wasted space? At 1Mhz std rtr frame is ~21K frames/s. For two
channels both ways that's 21x2x2=84k frames/s. At 28 bytes per frame
that's 84x28x8=18.816Mbit/s too much for a USB full-speed device. I
want to reduce gs_host_frame size and get closer to 12Mbit/s.

What is the purpose of enum can_mode and set mode? I see that allot of drivers more or less ignore it.
reacting to only START but not SLEEP or STOP...

Max Schnedier.

