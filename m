From: Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: Re: usb-can device
Date: Wed, 29 Aug 2012 01:34:59 +0200
Message-ID: <20120828233459.GA3046@gmail.com>
References: <1345996339.6610.10.camel@slaptop>
 <503A4E9B.9060308@pengutronix.de>
 <503B1198.3010506@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:63282 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab2H1Xfd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 28 Aug 2012 19:35:33 -0400
Received: by wibhr14 with SMTP id hr14so5384622wib.1
        for <linux-can@vger.kernel.org>; Tue, 28 Aug 2012 16:35:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <503B1198.3010506@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "Max S." <max@schneidersoft.net>, linux-can@vger.kernel.org

Hello everyone,

On Mon, Aug 27, 2012 at 08:20:08AM +0200, Oliver Hartkopp wrote:
> > There is no standard driver, however I was thinking last week that
> > someone should write a CDC CAN driver. CDC Ethernet is a standard to
> > send ethernet frames over USB.
>
> Due to the lack of USB CAN Hardware, where i could implement my own firmware i
> thought about using http://www.8devices.com/product/2/usb2can which is pretty
> cheap and also provides schematics to be able to alter the firmware with it's
> onboard JTAG interface (see schematic):
> 
> http://www.8devices.com/uploads/downloads/usb2can.pdf
> 
> The idea is to bring the USB CAN interface as near as possible to the
> SocketCAN network interface:

Oliver, I developed an USB to CANBUS interface some months ago, that
I'm currently using for all my tests and developement.

I had the intention to release the full hardware, firmware and kernel
driver code, but I still have not had time to write a decent
documentation, a blog post, request proper USB IDs and design a rev2 -
anyway, as there seems to be some interest on the subject I pushed the
current design (hardware is in Eagle 6 format) on github at:

https://github.com/fabiobaltieri/open-usb-can

The hardware is currently based on an ATMega32U2 (yes, a 16MHz 8-bit
AVR) + MCP2515 as can controller, not exactly the best performing
hardware but really cheap and easy to hack.  Also, there are mounting
options for both normal and isolated transceiver (using an ADM3053,
should come cheaper and smaller than isolator + dc/dc + normal xcvr).

The USB stack is based on Werner Almesberger's ben-wpan code, which is
lightweight and clean, while the kernel driver is based on code from
ems_usb and esd_usb2.

In my test this design seems to perform quite well with busses up to
250kbps, and I also used it on my Toyota's 500kbps bus with very few rx
overruns.

So, this is probabily not the best bust sniffer in the world, but should
be ok for protocol development and testing.

The USB protocol I implemented at the time share some of your ideas (the
code is in the kernel-module directory):

> - send struct can_frames
> - receive struct can_frames (for instant CAN data forwarding)

I'm using a packed version of struct can_frame, that was to save some
bytes in USB messages and MCU's memory but should not really make a big
difference.

> - receive struct can_frames (for instant CAN error messages(!) forwarding)

Got it! No difference between normal and error frames in my kernel
driver.  The firmware speaks socketcan! (I stole some headers :-) )

> - send an endian pattern inside the USB URB (*1)

That should be easy to implement... sure it makes sense to do that in
the USB controller rather than the host?  That's just a le32_to_cpu per
packet...

> - send skb->sk pointers along with CAN data (*2)

That's to be implemented, I'm echoing from tx URB callback as ems, but I
have a buffer status pointer and two spare bytes in the rx message which
may be used to implement a better echo strategy.

> - define a simple interface for open/close/bitrate-setting

I'm using just some control requests for CAN_START and CAN_STOP and a
dedicated CAN_PUT_CONFIG with a specific struct open_usb_can_config for
configuration which is basically a subset of struct can_bittiming using
8-bit fields.

Oliver, Marc, do you think that this design my be used as a base to do
some generic USB-CAN (CDC CAN?) protocol development?  I would be happy
to help!

Max, does this helps you with the design?  I understand that you are
using some other Atmel MCUs... maybe you can directly re-use part of the
code.

Fabio
