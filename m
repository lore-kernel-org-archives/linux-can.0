From: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: RE: [PATCH v3] can: rcar_canfd: Add Renesas R-Car CAN FD driver
Date: Wed, 16 Mar 2016 10:50:36 +0000
Message-ID: <SG2PR06MB1038489F8A5E87BCAFC62C5AC38A0@SG2PR06MB1038.apcprd06.prod.outlook.com>
References: <1457019515-21158-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <1458035294-8150-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <56E80422.9000902@hartkopp.net>
 <SG2PR06MB1038CF8299F3DC3E823BEC8AC3890@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <56E864AC.2040605@hartkopp.net>
 <SG2PR06MB1038BE32574EF8C5830C6A6FC38A0@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <56E92BCF.1080508@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:19468 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S966205AbcCPKuk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 16 Mar 2016 06:50:40 -0400
In-Reply-To: <56E92BCF.1080508@hartkopp.net>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "mkl@pengutronix.de" <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Oliver,

> >>>>
> >>>> What happens if the user only defines:
> >>>>
> >>>> 	"ip link set can0 up type can bitrate 1000000"
> >>>>
> >>>> instead of
> >>>>
> >>>> 	"ip link set can0 up type can bitrate 1000000 dbitrate 1000000"
> >>>>
> >>>> ??
> >>>
> >>> This is not possible isn't it? netlink already does a sanity check
> >>> on
> >> dbitrate before bring up of a FD node.
> >>
> >> No. It's not netlink but the open_candev() function which does the
> >> sanity check - the function you call in rcar_canfd_open():
> >
> > Yes, my intention is to mention that this config is not possible but I
> misused netlink instead of the exact function name.
> >
> >>
> >>   > +
> >>   > +static int rcar_canfd_open(struct net_device *ndev)  > +{
> >>   > +	struct rcar_canfd_channel *priv = netdev_priv(ndev);
> >>   > +	struct rcar_canfd_global *gpriv = priv->gpriv;
> >>   > +	int err;
> >>   > +
> >>   > +	/* Peripheral clock is already enabled in probe */
> >>   > +	err = clk_prepare_enable(gpriv->can_clk);
> >>   > +	if (err) {
> >>   > +		netdev_err(ndev, "failed to enable CAN clock, error
> %d\n",
> >> err);
> >>   > +		goto out_clock;
> >>   > +	}
> >>
> >> I wonder if it makes sense to add
> >>
> >> if (!priv->data_bittiming.bitrate) {
> >>
> >> 	/* copy arbitration bitrate to data bitrate registers */
> >>
> >> }
> >>
> >> here instead of urging the user to provide an identical data bitrate
> >> to configure a working CAN2.0 setup.
> >>
> >>   > +
> >>   > + err = open_candev(ndev);
> >>   > + if (err) {
> >>   > + netdev_err(ndev, "open_candev() failed, error %d\n", err);  > +
> >> goto out_can_clock;  > + }  > +
> >>
> >> As we omitted to force the user to provide 'fd on' at configuration
> >> time
> >> - why should we force users to provide a second bitrate for a CAN2.0
> >> operation??
> >
> > We are not forcing "fd on" because it is still a consistent
> configuration w.r.t mode, mtu & bitrates.
> 
> But the default value is "fd off" - even if no one provides this
> configuration option all the time.
> 
> So it's some kind of 'silent' knowledge to take a look at the MTU?
> That's bad too.

We could argue M_CAN supporting non-iso mode only as silent knowledge because we are not explicitly configuring it? The user should know what they are doing and driver should provide sanity checks for a consistent configuration IMO.

> >>
> >> This looks more straight forward to me and hides the fact of handling
> >> a CANFD-only controller differently to a CAN2.0 or CAN2.0/CANFD
> >> controller setup.
> >
> > I think we are going back to the original discussion. To quote you
> > from earlier thread
> >
> > ---
> > When you have a CAN FD /capable/ controller the idea is:
> >
> > "ip link set can0 up type can bitrate 1000000"
> >
> > The controller is in CAN2.0 mode:
> >
> > 1. It can send and receive CAN2.0 frames @1MBit/s.
> > 2. The MTU is set to 16 (sizeof(struct can_frame)) ; CAN_CTRLMODE_FD is
> unset.
> > 3. The CAN controller is not CAN FD tolerant (will produce error
> > frames)
> > ---
> >
> > This is the normal config setup for a CAN 2.0 controller too. Assuming
> we are hiding the CAN FD only mode, points 2 & 3 are broken isn't it? Not
> sure why we want to hide CAN FD only mode? It adds more ambiguity only.
> What do you think?
> 
> Yes. You are right. Up to that statement I was not really aware of a
> CANFD-only CAN controller setup and how to handle it best.
> 
> But now that we have one - and after our discussions - I would suggest to
> have a similar user experience for CAN2.0-only / CAN2.0/CANFD / CANFD-only
> CAN controllers.
> 
> E.g. when I set "ip link set can0 up type can bitrate 1000000" on a PEAK
> PCAN USB FD adapter it acts like a CAN2.0 adapter and I can send and
> receive CAN2.0 frames.

Will it generate error on CAN FD frame reception? What's the MTU?
What's the behaviour for these configurations?

ip link set can0 up type can bitrate 1000000 dbitrate 1000000 
ip link set can0 up type can bitrate 1000000 dbitrate 1000000 fd off

Again, will it generate error on CAN FD frame reception? What's the MTU?

> 
> When a user wants to setup CAN2.0 communication with the RCar CAN FD
> controller he has to provide a second bitrate but not necessarily 'fd on'
> (which is inconsistent).
> 
> Assume the user wants to have a simple CAN2.0 setup with the RCar CAN FD.
> The steps would be
 
When I submit the "can-only" mode patch next, the user have the option of configuring a pure CAN 2.0 node. This would be a like a DT option "renesas,can-nofd". Of course the user has to read the manual/doc/bindings to know such capability exists. 

If the user wants CAN FD only mode and still want to interoperate with CAN 2.0 node, making this differentiation explicitly in doc/configuration would be cleaner IMO.

> 1. ip link set can0 up type can bitrate 1000000 2. Use the CAN_RAW socket
> without (== default) CAN_RAW_FD_FRAMES sockopt
> 
> At least this looks more elegant and fulfills the user needs and
> functionality than providing an extra 'fd on' or an extra bitrate.
> 
> The only difference 'under the hood' would be that the RCar CAN FD
> controller would accept CAN FD frames - that are not visible on this
> CAN_RAW socket.

That would affect stats and internal counters. Still it would be a hack isn't it?

> 
> IMO we would get much less problems and user disorientation when you copy
> the bitrate into the unset data bitrate registers.
> 
> Making everything 'really correct' would mean that the user must set 'fd
> on'
> every time and we would need to check whether the static ctrlmode bits are
> always set by the user.

Hmm... then M_CAN has to set

ip link set can0 up type can bitrate 1000000 dbitrate 2000000 fd on fd-non-iso on

Not sure if we really want this? It's nice we are having a good discussion on this topic.

Thanks,
Ramesh
