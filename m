From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Rebuild Drivers for Ubuntu
Date: Mon, 12 May 2014 08:22:51 +0200
Message-ID: <537068BB.5040901@hartkopp.net>
References: <loom.20140512T070934-65@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:27861 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbaELGW4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 12 May 2014 02:22:56 -0400
In-Reply-To: <loom.20140512T070934-65@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jeff Holtz <jeff.holtz@movimentogroup.com>
Cc: linux-can@vger.kernel.org

Hello Jeff,

I would suggest the following:

Download the can-modules git from gitorious:

	git clone git://gitorious.org/linux-can/can-modules.git

	cd can-modules/net/can/

	make CONFIG_CAN=n CONFIG_CAN_RAW=n CONFIG_CAN_BCM=n CONFIG_CAN_GW=n

This should have created a can-isotp.ko which you can load with

	sudo insmod ./can-isotp.ko


# dmesg | tail -1
[  452.044371] can: isotp protocol (rev 20130731 alpha)

There's no need to compile the CAN mainline modules again.
You just need the linux-headers-<your-kernel-version> and the standard gcc
build environment (which was needed to compile can-utils anyway).

Please give me some feedback if it doesn't work as expected on your machine.

Regards,
Oliver

On 12.05.2014 07:13, Jeff Holtz wrote:
> I'm developing some ISOTP programs and would like to rebuild the drivers to
> include the CAN-ISOTP.ko file for UBUNTU (currently using 14.04 LTS)  I can
> get the code for the build for 14.04 which includes all the can, can-bcm,
> can-raw ko's but nt the isotp.  I've git the can-modules but having
> difficulties merging the latest code and where to place it to build.  Any
> help/instructions would be appreciated.
> 
> for example:
>    cp ~/can-modules /usr/src/linux-3-13.0/.
>    make SUBDIR=drivers/net/can
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
