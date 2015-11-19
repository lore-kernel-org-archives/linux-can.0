From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: can: kvaser_usb: Add support for Kvaser CAN/USB devices
Date: Thu, 19 Nov 2015 14:46:12 +0100 (CET)
Message-ID: <450503867.2550407.1447940772832.JavaMail.open-xchange@omgreatgod.store>
References: <20151119124219.GC2638@mwanda> <564DCD57.1000801@pengutronix.de>
Reply-To: Oliver Hartkopp <socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:30640 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757783AbbKSNqR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 19 Nov 2015 08:46:17 -0500
In-Reply-To: <564DCD57.1000801@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>, olivier@sobrie.be, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org



> Marc Kleine-Budde <mkl@pengutronix.de> hat am 19. November 2015 um 14:23
> geschrieben:
> 
> 
> On 11/19/2015 01:42 PM, Dan Carpenter wrote:
> > Hello Olivier Sobrie,
> > 
> > The patch 080f40a6fa28: "can: kvaser_usb: Add support for Kvaser
> > CAN/USB devices" from Nov 21, 2012, leads to the following static
> > checker warning:
> > 
> > 	drivers/net/can/usb/kvaser_usb.c:949 kvaser_usb_rx_error()
> > 	0x08 | 0x18 has 0x08 set on both sides
> > 
> > drivers/net/can/usb/kvaser_usb.c
> >    941          switch (dev->family) {
> >    942          case KVASER_LEAF:
> >    943                  if (es->leaf.error_factor) {
> >    944                          cf->can_id |= CAN_ERR_BUSERROR |
> > CAN_ERR_PROT;
> >    945  
> >    946                          if (es->leaf.error_factor & M16C_EF_ACKE)
> >    947                                  cf->data[3] |=
> > (CAN_ERR_PROT_LOC_ACK);
> >    948                          if (es->leaf.error_factor & M16C_EF_CRCE)
> >    949                                  cf->data[3] |=
> > (CAN_ERR_PROT_LOC_CRC_SEQ |
> >    950
> >                                                  CAN_ERR_PROT_LOC_CRC_DEL);
> > 
> > CAN_ERR_PROT_LOC_CRC_SEQ is 0x08
> > CAN_ERR_PROT_LOC_CRC_DEL is 0x18
> > 
> > It's weird that the bits overlap.  Was that intentional?  Why isn't it
> > enough to just say?:
> > 					cf->data[3] |= CAN_ERR_PROT_LOC_CRC_DEL;
> 
> Looking at include/uapi/linux/can/error.h I'd say, they are not meant to
> be used bitwise. Oliver?

You are right!

The values reflect more or less the incident position (location) where the error
in bit stream processing occurred.

Instead of 

cf->data[3] |= (CAN_ERR_PROT_LOC_CRC_SEQ | ...

it should be

cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;

There's no need for bitwise OR'ed values in data[3].

Regards,
Oliver
