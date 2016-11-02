From: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: RE: Adding new CAN driver
Date: Wed, 2 Nov 2016 15:49:50 +0000
Message-ID: <SG2PR06MB1038F0416E850F0C09BC5CCEC3A00@SG2PR06MB1038.apcprd06.prod.outlook.com>
References: <CAKT-o-cOb0sqRmvH+BKjX4yvBLp5_GqVd6=ifr2jm5T75-hcZA@mail.gmail.com>
 <ddb4ed13-819f-ad8c-8ce2-da7585a79098@pengutronix.de>
 <SG2PR06MB10384C09F05B12731B6D7151C3A00@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <3113364.8FuUfmAlHQ@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:49937 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755969AbcKBPtz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Nov 2016 11:49:55 -0400
In-Reply-To: <3113364.8FuUfmAlHQ@ws-stein>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, =?iso-8859-2?Q?Ko=B3=B3=B1taj=2C_Remigiusz?= <remigiusz.kollataj@mobica.com>, Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>

> > > > I didn't get a chance to work on adding support for termination to
> > > > "ip". Before investing any effort I would prefer to get
> > > > confirmation from Oliver of Marc that the direction is right.
> > > > Anyway setting up termination via sysfs works just fine. It is
> > > > described in readme file in repository.
> > >
> > >
> > > I'd like to see a netlink interface for this. Oliver what about
> > > adding it to CTRL_MODE?
> >
> >
> > Is it about the CAN bus termination? Why the driver need to be aware of
> it?
> > If it needed for some reason shouldn't it be a device tree property of
> > that device/bridge node?
>=20
> I would consider this as a feature, which has to be enabled or disabled o=
n
> demand dynamically, depending on current physical connection, especially
> regarding USB devices. In thise cases there is also no device tree
> applicable.

OK. My question was on the lines - "Is the termination information is neede=
d on a register of the CAN device that the driver manages?" There are cases=
 where the termination is provided by the D-sub connector. The controller s=
hould just see bus error when improperly terminated. I don't know about USB=
 based devices and please forgive me if this is the norm.

But this is physical layer information as Oliver mentioned. The CAN transce=
iver may even require some start-up state that may be enabled by setting co=
uple of GPIOs (as on my board). Yes, it is part of the CAN interface config=
uration but it not part of the CAN controller driver. I think we could map =
it to Ethernet MAC & PHY case - isn't it?=20

Thanks,
Ramesh
