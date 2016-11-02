From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: Adding new CAN driver
Date: Wed, 02 Nov 2016 17:08:45 +0100
Message-ID: <1490105.s3iJfGbYsS@ws-stein>
References: <CAKT-o-cOb0sqRmvH+BKjX4yvBLp5_GqVd6=ifr2jm5T75-hcZA@mail.gmail.com> <3113364.8FuUfmAlHQ@ws-stein> <SG2PR06MB1038F0416E850F0C09BC5CCEC3A00@SG2PR06MB1038.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:43034 "EHLO
        webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752844AbcKBQJM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Nov 2016 12:09:12 -0400
In-Reply-To: <SG2PR06MB1038F0416E850F0C09BC5CCEC3A00@SG2PR06MB1038.apcprd06.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, =?utf-8?B?S2/FgsWCxIV0YWos?= Remigiusz <remigiusz.kollataj@mobica.com>, Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>

On Wednesday 02 November 2016 15:49:50, Ramesh Shanmugasundaram wrote:
> > > > > I didn't get a chance to work on adding support for termination to
> > > > > "ip". Before investing any effort I would prefer to get
> > > > > confirmation from Oliver of Marc that the direction is right.
> > > > > Anyway setting up termination via sysfs works just fine. It is
> > > > > described in readme file in repository.
> > > > 
> > > > I'd like to see a netlink interface for this. Oliver what about
> > > > adding it to CTRL_MODE?
> > > 
> > > Is it about the CAN bus termination? Why the driver need to be aware of
> > 
> > it?
> > 
> > > If it needed for some reason shouldn't it be a device tree property of
> > > that device/bridge node?
> > 
> > I would consider this as a feature, which has to be enabled or disabled on
> > demand dynamically, depending on current physical connection, especially
> > regarding USB devices. In thise cases there is also no device tree
> > applicable.
> 
> OK. My question was on the lines - "Is the termination information is needed
> on a register of the CAN device that the driver manages?" There are cases
> where the termination is provided by the D-sub connector. The controller
> should just see bus error when improperly terminated. I don't know about
> USB based devices and please forgive me if this is the norm.

No problem, I just wanted to point out that device tree is not suitable in 
this case.

> But this is physical layer information as Oliver mentioned. The CAN
> transceiver may even require some start-up state that may be enabled by
> setting couple of GPIOs (as on my board). Yes, it is part of the CAN
> interface configuration but it not part of the CAN controller driver. I
> think we could map it to Ethernet MAC & PHY case - isn't it?

The transceiver might be managed by regulators as done by e.g. flexcan. This 
is part of the hardware description, so device tree here is fine.
But in my opinion bus termination is an end user configuration which might 
change rather often than not. It might be independent of the controller driver 
as e.g. in flexcan, but it might be part of the device as in USB hardware 
which requires some specific command to change bus termination.
IMHO it makes no sense to split an USB interface driver into two parts using 
the same interface in the end.

Best regards,
Alexander
