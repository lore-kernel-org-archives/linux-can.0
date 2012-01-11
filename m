From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Softing Firmware on gitorious
Date: Wed, 11 Jan 2012 17:18:55 +0100
Message-ID: <4F0DB66F.50509@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:39935 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757159Ab2AKQTM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Jan 2012 11:19:12 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <kurt.van.dijck@eia.be>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Kurt,

i just uploaded the Softing firmware from BerliOS to our new 

https://gitorious.org/linux-can/can-misc

git repository.

See at 

https://gitorious.org/linux-can/can-misc/blobs/master/firmware/softing-fw-4.6-binaries.tar.gz

Currently the only reference is in the Linux Kernel in the Softing Kconfig:

config CAN_SOFTING_CS
        tristate "Softing Gmbh CAN pcmcia cards"
        depends on PCMCIA
        depends on CAN_SOFTING
        ---help---
          Support for PCMCIA cards from Softing Gmbh & some cards
          from Vector Gmbh.
          You need firmware for these, which you can get at
          http://developer.berlios.de/projects/socketcan/
          This version of the driver is written against
          firmware version 4.6 (softing-fw-4.6-binaries.tar.gz)
          In order to use the card as CAN device, you need the Softing generic
          support too.


The question is now:

1. change the link in the Kconfig
2. Add the PCMCIA firmware to the Linux Kernel (linux/firmware/*.ihex)
3. 1 & 2

???

Regards,
Oliver

