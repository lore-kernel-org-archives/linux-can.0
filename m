From: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: RE: [PATCH v3] can: rcar_canfd: Add Renesas R-Car CAN FD driver
Date: Wed, 16 Mar 2016 07:45:28 +0000
Message-ID: <SG2PR06MB1038BE32574EF8C5830C6A6FC38A0@SG2PR06MB1038.apcprd06.prod.outlook.com>
References: <1457019515-21158-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <1458035294-8150-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <56E80422.9000902@hartkopp.net>
 <SG2PR06MB1038CF8299F3DC3E823BEC8AC3890@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <56E864AC.2040605@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:65128 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933773AbcCPHpd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 16 Mar 2016 03:45:33 -0400
In-Reply-To: <56E864AC.2040605@hartkopp.net>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Oliver,

> >> On 03/15/2016 10:48 AM, Ramesh Shanmugasundaram wrote:
> >>
> >>> +config CAN_RCAR_CANFD
> >>> +	tristate "Renesas R-Car CAN FD controller"
(...)
> >>
> >> 'Should' sounds like a pretty soft requirement here - and this info
> >> should not hide deep in the code IMO.
> >
> > OK. I'll add a comment at the start of the driver like
> > ---
> > "The driver puts the controller in CAN FD only mode. In this mode, the
> controller acts as a CAN FD node that can also interoperate with CAN 2.0
> nodes. The driver does not support dedicated CAN 2.0 only mode at present.
> >
> > When configuring the controller to interoperate with CAN 2.0 nodes only,
> the data bitrate MUST be configured the same as nominal bitrate.
> >
> > e.g. ip link set can0 up type can bitrate 1000000 dbitrate 1000000"
> > ---
> >
> > Will this be OK?
> 
> See comment below.
> 
> >
> >>
> >> What happens if the user only defines:
> >>
> >> 	"ip link set can0 up type can bitrate 1000000"
> >>
> >> instead of
> >>
> >> 	"ip link set can0 up type can bitrate 1000000 dbitrate 1000000"
> >>
> >> ??
> >
> > This is not possible isn't it? netlink already does a sanity check on
> dbitrate before bring up of a FD node.
> 
> No. It's not netlink but the open_candev() function which does the sanity
> check - the function you call in rcar_canfd_open():

Yes, my intention is to mention that this config is not possible but I misused netlink instead of the exact function name. 

> 
>  > +
>  > +static int rcar_canfd_open(struct net_device *ndev)  > +{
>  > +	struct rcar_canfd_channel *priv = netdev_priv(ndev);
>  > +	struct rcar_canfd_global *gpriv = priv->gpriv;
>  > +	int err;
>  > +
>  > +	/* Peripheral clock is already enabled in probe */
>  > +	err = clk_prepare_enable(gpriv->can_clk);
>  > +	if (err) {
>  > +		netdev_err(ndev, "failed to enable CAN clock, error %d\n",
> err);
>  > +		goto out_clock;
>  > +	}
> 
> I wonder if it makes sense to add
> 
> if (!priv->data_bittiming.bitrate) {
> 
> 	/* copy arbitration bitrate to data bitrate registers */
> 
> }
> 
> here instead of urging the user to provide an identical data bitrate to
> configure a working CAN2.0 setup.
> 
>  > +
>  > + err = open_candev(ndev);
>  > + if (err) {
>  > + netdev_err(ndev, "open_candev() failed, error %d\n", err);  > + goto
> out_can_clock;  > + }  > +
> 
> As we omitted to force the user to provide 'fd on' at configuration time
> - why should we force users to provide a second bitrate for a CAN2.0
> operation??

We are not forcing "fd on" because it is still a consistent configuration w.r.t mode, mtu & bitrates. 
> 
> This looks more straight forward to me and hides the fact of handling a
> CANFD-only controller differently to a CAN2.0 or CAN2.0/CANFD controller
> setup.

I think we are going back to the original discussion. To quote you from earlier thread

---
When you have a CAN FD /capable/ controller the idea is:

"ip link set can0 up type can bitrate 1000000"

The controller is in CAN2.0 mode:

1. It can send and receive CAN2.0 frames @1MBit/s.
2. The MTU is set to 16 (sizeof(struct can_frame)) ; CAN_CTRLMODE_FD is unset.
3. The CAN controller is not CAN FD tolerant (will produce error frames)
---

This is the normal config setup for a CAN 2.0 controller too. Assuming we are hiding the CAN FD only mode, points 2 & 3 are broken isn't it? Not sure why we want to hide CAN FD only mode? It adds more ambiguity only. What do you think?

Thanks,
Ramesh


