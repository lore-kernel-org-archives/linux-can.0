From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Trying to use ESD CAN-USB with SocketCAN
Date: Thu, 28 Feb 2013 20:59:46 +0100
Message-ID: <512FB732.6030705@hartkopp.net>
References: <loom.20130228T180224-395@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:47449 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150Ab3B1T7t (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Feb 2013 14:59:49 -0500
In-Reply-To: <loom.20130228T180224-395@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: GeoffO <geoffeolson@gmail.com>
Cc: linux-can@vger.kernel.org

On 28.02.2013 18:57, GeoffO wrote:

> I wanted to setup SocketCAN on my PC to prepare for an embedded Linux project,
> so I purchased a USB device from ESD who claimed it supports SocketCAN.


> Plugged-in ESD CAN-USB/Micro and got this new device
> 	/dev/ttyACM0
> 


Ugh?!

The ESD USB/Micro is a separate USB CAN driver, see:

http://lxr.linux.no/#linux+v3.8.1/drivers/net/can/usb/Kconfig#L9

and

http://lxr.linux.no/#linux+v3.8.1/drivers/net/can/usb/esd_usb2.c

Therefore i wonder why a /dev/ttyACM is created and not just a 'can0'.

Can you send the dmesg output when plugging the interface?
What kernel version do you use?
What does 'lsusb -v -v' tell about the ESD adapter?

Regards,
Oliver
