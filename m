From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Tutorial or Read-me file for Linux can API
Date: Fri, 05 Apr 2013 08:00:34 +0200
Message-ID: <515E6882.7070807@hartkopp.net>
References: <loom.20130405T062502-943@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:8710 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848Ab3DEGAh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 5 Apr 2013 02:00:37 -0400
In-Reply-To: <loom.20130405T062502-943@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Katoch <din.gulu.er@gmail.com>
Cc: linux-can@vger.kernel.org

On 05.04.2013 06:29, Katoch wrote:

> Hi,
> 
> I am going through a can base network driver for MCP-2515
> https://github.com/raspberrypi/linux/blob/rpi-3.6.y/drivers/net/can/mcp251x.c
> 
> Please suggest where i can find the description of the function, :--
> alloc_candev
> open_candev
> alloc_can_skb
> can_dropped_invalid_skb
> alloc_can_err_skb
> etc .....
> 


The mcp251x driver uses the Linux CAN driver infrastructure, e.g. to be able
to set bitrates and other settings with the ip tool from the iproute2 package.

See:

http://lxr.linux.no/#linux+v3.8.5/Documentation/networking/can.txt#L746

You can find the according header files and implementations in:

	linux/include/linux/can/dev.h

and

	linux/drivers/net/can/dev.c

Please take care that CONFIG_CAN_DEV and CONFIG_CAN_CALC_BITTIMING are enabled
in your Linux kernel configuration, see:

http://lxr.linux.no/#linux+v3.8.5/drivers/net/can/Kconfig#L33

Regards,
Oliver

