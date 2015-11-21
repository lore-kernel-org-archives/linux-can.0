From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: can: kvaser_usb: Add support for Kvaser CAN/USB devices
Date: Sat, 21 Nov 2015 13:40:05 +0100
Message-ID: <56506625.50003@hartkopp.net>
References: <20151119124219.GC2638@mwanda> <20151120081921.GA32659@thinkoso.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:41748 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbbKUMkM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 21 Nov 2015 07:40:12 -0500
In-Reply-To: <20151120081921.GA32659@thinkoso.home>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Olivier Sobrie <olivier@sobrie.be>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

Hello Olivier,

On 11/20/2015 09:19 AM, Olivier Sobrie wrote:

> No it wasn't intentional. I think that it was inspired from other CAN
> drivers. I see the same in net/can/c_can/c_can.c and
> net/can/m_can/m_can.c. Sorry for the error.
> Btw, which static checker are you using?
> 
> As suggested by Oliver, I assume we can transform this in
>   cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
> and fix all the other places where bitwise operations are done
> for errors in data[3].
> 
> Should I send a patch to fix this? Or do you or someone else plan
> to send a patch?

I already prepared a patch to fix the data[3] assignment issue.

It's a bunch of drivers that do it wrong:

drivers/net/can/c_can/c_can.c:
drivers/net/can/cc770/cc770.c:
drivers/net/can/flexcan.c:
drivers/net/can/m_can/m_can.c:
drivers/net/can/pch_can.c:
drivers/net/can/rcar_can.c:
drivers/net/can/ti_hecc.c:
drivers/net/can/usb/kvaser_usb.c:
drivers/net/can/usb/usb_8dev.c:
drivers/net/can/xilinx_can.c:

So if it's ok for you I'll post it this weekend :-)

Best regards,
Oliver
