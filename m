From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: USB CAN Scripts - was Re: usb_8dev: USB Protocoll available?
Date: Sun, 16 Dec 2012 17:54:00 +0100
Message-ID: <50CDFCA8.6000409@hartkopp.net>
References: <20683.22879.172661.430971@elektron.ikp.physik.tu-darmstadt.de> <50CC2226.10107@universalnet.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:48877 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555Ab2LPQyE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 16 Dec 2012 11:54:04 -0500
In-Reply-To: <50CC2226.10107@universalnet.at>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Bernd Krumboeck <krumboeck@universalnet.at>, Kurt Van Dijck <kurt.van.dijck@eia.be>, Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can@vger.kernel.org

Hello Bernd,

thanks for sending the [v9] version of the 8devices USB2CAN.

I'm looking forward to get my own devices (hopefully) the next days to test
your driver too. When it's applied to Daves net-next we have additional two
month to test ;-)

Btw. you mentioned the need for some scripting support ...

To me the problem is when attaching some USB CAN adapter the enumeration of
these adapters is arbitrarily.

E.g. if i wanted to set the bitrate according to the specific adapter, i need
some kind of reference, let's say a unique device identifier.

When i would be able to identify the USB CAN adapters device ID i could add
some udev scripts to set the bitrate - even if i change the plug-in order.

The PEAK USB adapters have this info:

peak_usb 2-1.3:1.0: PEAK-System PCAN-USB adapter hwrev 28 serial FFFFFFFF (1 channel)
peak_usb 2-1.3:1.0 can2: attached to PCAN-USB channel 0 (device 67)

This device number "67" can be set by the user to identify the adapter.

In your mail ...

On 15.12.2012 08:09, Bernd Krumboeck wrote:
> Maybe this will help you (lsusb -v):

> 
> Bus 006 Device 006: ID 0483:1234 SGS Thomson Microelectronics
> Device Descriptor:


(..)

>   iManufacturer           1 edevices
>   iProduct                2 USB2CAN converter
>   iSerial                 3 ED000202


(..)

... there's a serial number "ED000202" available.

Maybe we should discuss about having that kind of unique identifier available
in the sysfs (as we do not have a MAC address like USB ethernet adapters) for
udev scripts as discussed above.

I wonder if we could/should re-use the already existing

	/sys/class/net/canX/addr
	/sys/class/net/canX/addr_len

for this purpose ?!?

Regards,
Oliver
