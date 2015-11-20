From: Olivier Sobrie <olivier@sobrie.be>
Subject: Re: can: kvaser_usb: Add support for Kvaser CAN/USB devices
Date: Fri, 20 Nov 2015 09:19:21 +0100
Message-ID: <20151120081921.GA32659@thinkoso.home>
References: <20151119124219.GC2638@mwanda>
Reply-To: Olivier Sobrie <olivier@sobrie.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33625 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162144AbbKTISJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 Nov 2015 03:18:09 -0500
Received: by wmec201 with SMTP id c201so60663141wme.0
        for <linux-can@vger.kernel.org>; Fri, 20 Nov 2015 00:18:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20151119124219.GC2638@mwanda>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>

Hello Dan,

On Thu, Nov 19, 2015 at 03:42:19PM +0300, Dan Carpenter wrote:
> Hello Olivier Sobrie,
> 
> The patch 080f40a6fa28: "can: kvaser_usb: Add support for Kvaser
> CAN/USB devices" from Nov 21, 2012, leads to the following static
> checker warning:
> 
> 	drivers/net/can/usb/kvaser_usb.c:949 kvaser_usb_rx_error()
> 	0x08 | 0x18 has 0x08 set on both sides
> 
> drivers/net/can/usb/kvaser_usb.c
>    941          switch (dev->family) {
>    942          case KVASER_LEAF:
>    943                  if (es->leaf.error_factor) {
>    944                          cf->can_id |= CAN_ERR_BUSERROR | CAN_ERR_PROT;
>    945  
>    946                          if (es->leaf.error_factor & M16C_EF_ACKE)
>    947                                  cf->data[3] |= (CAN_ERR_PROT_LOC_ACK);
>    948                          if (es->leaf.error_factor & M16C_EF_CRCE)
>    949                                  cf->data[3] |= (CAN_ERR_PROT_LOC_CRC_SEQ |
>    950                                                  CAN_ERR_PROT_LOC_CRC_DEL);
> 
> CAN_ERR_PROT_LOC_CRC_SEQ is 0x08
> CAN_ERR_PROT_LOC_CRC_DEL is 0x18
> 
> It's weird that the bits overlap.  Was that intentional?  Why isn't it
> enough to just say?:
> 					cf->data[3] |= CAN_ERR_PROT_LOC_CRC_DEL;
> 
> The static checker complains about most places where
> CAN_ERR_PROT_LOC_CRC_SEQ is used.  I see us setting the flag but not I
> don't see where we test for this so I'm not sure.

No it wasn't intentional. I think that it was inspired from other CAN
drivers. I see the same in net/can/c_can/c_can.c and
net/can/m_can/m_can.c. Sorry for the error.
Btw, which static checker are you using?

As suggested by Oliver, I assume we can transform this in
  cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
and fix all the other places where bitwise operations are done
for errors in data[3].

Should I send a patch to fix this? Or do you or someone else plan
to send a patch?

Thanks,

Olivier
