From: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Subject: Testing peak_pci v6.1 / peak_usb v6 / peak_pcmcia v4.1
Date: Thu, 23 Feb 2012 14:44:10 +0100
Message-ID: <4F4642AA.9060103@volkswagen.de>
References: <4F44AE8F.4070505@peak-system.com> <4F4511DC.60708@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mr2.volkswagen.de ([194.114.62.76]:37649 "EHLO
	mr2.volkswagen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135Ab2BWNoW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 23 Feb 2012 08:44:22 -0500
In-Reply-To: <4F4511DC.60708@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Stephane,

you can add to all these drivers

- peak_pci v6.1 (http://marc.info/?l=linux-can&m=132973636320107&w=2)
- peak_usb v6 (http://marc.info/?l=linux-can&m=132998590401560&w=2)
- peak_pcmcia v4.1 (http://marc.info/?l=linux-pcmcia&m=132938721324159&w=2)

my

Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>

Very impressive! Whatever i tried - i didn't run into any problem with
plugging / unplugging all of these interfaces (with & without traffic load).

Testbed was:

peak_pci 0000:0e:00.0: can0 at reg_base=0xf827e000 cfg_base=0xf814e000 irq=19
peak_pci 0000:0e:00.0: can1 at reg_base=0xf827e400 cfg_base=0xf814e000 irq=19
peak_pcmcia 0.0: PEAK-System pcmcia card PC_CAN_CARD fw 1.5
peak_pcmcia 0.0: can2 on channel 0 at 0x00012100 irq 19
peak_pcmcia 0.0: can3 on channel 1 at 0x00012120 irq 19
peak_usb 2-2:1.0: PEAK-System PCAN-USB Pro hwrev 0 serial FFFFFFFF.00000001 (2 channels)
peak_usb 2-2:1.0: can4: attached to PCAN-USB Pro channel 0 (device 1)
peak_usb 2-2:1.0: can5: attached to PCAN-USB Pro channel 1 (device 0)
peak_usb 5-1:1.0: PEAK-System PCAN-USB adapter hwrev 28 serial FFFFFFFF (1 channel)
peak_usb 5-1:1.0: can6: attached to PCAN-USB channel 0 (device 46)

can0 - can2 - can4 - can6 - PEAK MicroMod (for 100% busload)
can1 - can3 - can5

Just two nitpicks:

When having traffic the LEDs from the PCIeC are flashing faster than the PCMCIA LEDs.
With no traffic and interface is up, they are flashing with the same frequency.

The other one:

usb 2-2: new high-speed USB device number 4 using ehci_hcd
usb 2-2: config 1 interface 0 altsetting 0 bulk endpoint 0x83 has invalid maxpacket 64
usb 2-2: config 1 interface 1 altsetting 0 bulk endpoint 0x86 has invalid maxpacket 64
peak_usb 2-2:1.0: PEAK-System PCAN-USB Pro hwrev 0 serial FFFFFFFF.00000001 (2 channels)
peak_usb 2-2:1.0: can4: attached to PCAN-USB Pro channel 0 (device 1)
peak_usb 2-2:1.0: can5: attached to PCAN-USB Pro channel 1 (device 0)
usbcore: registered new interface driver peak_usb

Do you have any idea what 

"altsetting 0 bulk endpoint 0x83 has invalid maxpacket 64"

means?

Is this something that's caused by your driver or it is caused by the
hardware configuration of the USBpro adapter? I assume it's the latter. 

Regards,
Oliver





