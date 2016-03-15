From: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: RE: [PATCH v3] can: rcar_canfd: Add Renesas R-Car CAN FD driver
Date: Tue, 15 Mar 2016 14:17:24 +0000
Message-ID: <SG2PR06MB1038CF8299F3DC3E823BEC8AC3890@SG2PR06MB1038.apcprd06.prod.outlook.com>
References: <1457019515-21158-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <1458035294-8150-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <56E80422.9000902@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from [210.160.252.171] ([210.160.252.171]:27279 "EHLO
	relmlie4.idc.renesas.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S965404AbcCOOR6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 15 Mar 2016 10:17:58 -0400
In-Reply-To: <56E80422.9000902@hartkopp.net>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Oliver

> On 03/15/2016 10:48 AM, Ramesh Shanmugasundaram wrote:
> 
> > +config CAN_RCAR_CANFD
> > +	tristate "Renesas R-Car CAN FD controller"
> > +	depends on ARCH_RENESAS || ARM
> > +	---help---
> > +	  Say Y here if you want to use CAN FD controller found on
> > +	  Renesas R-Car SoCs.
> > +
> > +	  To compile this driver as a module, choose M here: the module will
> > +	  be called rcar_canfd.
> 
> Would it make sense to add some more documentation here that this
> controller is a CANFD-only CAN controller which (of course) can cope with
> CAN2.0B frames but has no dedicated CAN2.0B mode?

OK. I'll modify it as 

"Say Y here if you want to use CAN FD controller found on
Renesas R-Car SoCs. The driver puts the controller in CANFD-only mode,
which can interoperate with CAN2.0 nodes but does not support
dedicated CAN 2.0 mode"

Sounds OK?

> 
> (..)
> 
> > +static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv,
> > +u32 ch) {
> 
> (..)
> 
> > +
> > +	priv->can.bittiming_const = &rcar_canfd_nom_bittiming_const;
> > +	priv->can.data_bittiming_const =
> > +		&rcar_canfd_data_bittiming_const;
> > +
> > +	/* Controller starts in CAN FD only mode. In this mode, to
> interoperate
> > +	 * with classical CAN only nodes, data bitrate should be configured
> the
> > +	 * same as nominal bitrate.
> > +	 */
> 
> 'Should' sounds like a pretty soft requirement here - and this info should
> not hide deep in the code IMO.

OK. I'll add a comment at the start of the driver like
---
"The driver puts the controller in CAN FD only mode. In this mode, the controller acts as a CAN FD node that can also interoperate with CAN 2.0 nodes. The driver does not support dedicated CAN 2.0 only mode at present.

When configuring the controller to interoperate with CAN 2.0 nodes only, the data bitrate MUST be configured the same as nominal bitrate.

e.g. ip link set can0 up type can bitrate 1000000 dbitrate 1000000"
---

Will this be OK?

> 
> What happens if the user only defines:
> 
> 	"ip link set can0 up type can bitrate 1000000"
> 
> instead of
> 
> 	"ip link set can0 up type can bitrate 1000000 dbitrate 1000000"
> 
> ??

This is not possible isn't it? netlink already does a sanity check on dbitrate before bring up of a FD node.

> 
> Would it make sense to set the data bitrate according to the arbitration
> bitrate in rcar_canfd_set_bittiming() or sanitize this at some other place
> when not data bitrate is given by the netlink command?

This is not required in my opinion. For e.g.

1) ip link set can0 up type can bitrate 1000000
- This is not possible as mentioned above

2) ip link set can0 up type can bitrate 1000000 dbitrate 500000
- Again netlink sanity checks will fail.

3) ip link set can0 up type can bitrate 500000 dbitrate 1000000
- If the user's intention is to configure CAN 2.0, they would not try this (i.e.) providing a dbitrate
- Of course, this will be accepted as a valid FD configuration

4) ip link set can0 up type can bitrate 1000000 dbitrate 2000000
ip link set can0 down
ip link set can0 up type can bitrate 500000
- This is accepted and valid. This means the nom & data bitrates are 500000 & 2000000 respectively and still in FD mode. This kind of config is true for any "net" device.

Conclusion is, if the user's intention is to configure CAN 2.0 node they would not provide data bitrate and if they do, it has to be same as nominal. Otherwise it becomes a valid FD configuration. In all these configs - mode, mtu & bitrates are consistent.

Thanks,
Ramesh
