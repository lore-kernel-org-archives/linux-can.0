From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC] can: Introducing CANFD for af_can & can-raw
Date: Wed, 21 Mar 2012 14:21:22 +0100
Message-ID: <4F69D5D2.5080003@hartkopp.net>
References: <20120321091055.GA433@vandijck-laurijssen.be> <E1SAIM4-0007a6-Sf@smtprelay03.ispgateway.de> <20120321110502.GA3372@vandijck-laurijssen.be> <4F69BEE3.2040705@pengutronix.de> <20120321120846.GB3372@vandijck-laurijssen.be> <4F69CA74.3020607@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:37320 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758782Ab2CUNV0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 Mar 2012 09:21:26 -0400
In-Reply-To: <4F69CA74.3020607@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Kurt Van Dijck <kurt.van.dijck@eia.be>
Cc: dev@sebastianhaas.info, linux-can@vger.kernel.org

Hi all,

of course i also thought about some concepts to support CAN FD ;-)

But then it melted down to the question what a potential CAN FD controller
would support:

1. Will it support sending of CAN frames & CAN FD frames with one config?
2. Is a CAN FD frame with DLC=8 different to a CAN2.0 frame with DLC=8 ?
   (as we know CAN ID 0x123 (EFF) and CAN ID 0x123 (SFF) are different)
3. Will these differences be visible in the CAN registers? Is this relevant?

What i got from the iCC was that when you have a partly migrated network and
you want to run e.g. a fast firmware upload between two CAN FD capable nodes,
the other (standard CAN 2.0b) nodes have to be in listen only mode to not jam
the bus with error frames.

After the firmware upload all the CAN nodes switch back to CAN2.0b mode (which
has to be done by root netlink access).

IMO we need to introduce a new struct canfd_frame

struct canfd_frame {
        canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
        __u8    can_dlc; /* data length code: 0 .. F */
        __u8    data[64] __attribute__((aligned(8)));
};

which can become the mayor internal data structure.

It should be no problem to move to canfd_frame inside the kernel but if we
come to the point that we get to the userspace ABI there should be no tricky
way to check lengths or flags or return values are are not needed to be
checked with the current ABI now.

When there's a defined socket API that makes use of struct can_frame (like
can_raw, can_bcm, can_gw - but not isotp! \o/ ) we need to

- duplicate the socket API - like CAN_RAWFD (ugly)
- switch the frame size (e.g. via sockopt)
- a third unknown idea ...

E.g. when having a CAN FD aware candump/cansend application, it can try to
switch the socket to CAN FD. If it works -> use CAN FD, if not we're probably
on an older kernel that does not support CAN FD ...

I think it's much more tricky to find a proper solution here.

Regards,
Oliver
