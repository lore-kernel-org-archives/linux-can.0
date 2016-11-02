From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: Adding new CAN driver
Date: Wed, 02 Nov 2016 15:14:52 +0100
Message-ID: <3113364.8FuUfmAlHQ@ws-stein>
References: <CAKT-o-cOb0sqRmvH+BKjX4yvBLp5_GqVd6=ifr2jm5T75-hcZA@mail.gmail.com> <ddb4ed13-819f-ad8c-8ce2-da7585a79098@pengutronix.de> <SG2PR06MB10384C09F05B12731B6D7151C3A00@SG2PR06MB1038.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:33973 "EHLO
        webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751075AbcKBOPC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Nov 2016 10:15:02 -0400
In-Reply-To: <SG2PR06MB10384C09F05B12731B6D7151C3A00@SG2PR06MB1038.apcprd06.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, =?utf-8?B?S2/FgsWCxIV0YWos?= Remigiusz <remigiusz.kollataj@mobica.com>, Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>

On Wednesday 02 November 2016 13:38:22, Ramesh Shanmugasundaram wrote:
> > > I didn't get a chance to work on adding support for termination to
> > > "ip". Before investing any effort I would prefer to get confirmation
> > > from Oliver of Marc that the direction is right. Anyway setting up
> > > termination via sysfs works just fine. It is described in readme file
> > > in repository.
> > 
> > 
> > I'd like to see a netlink interface for this. Oliver what about adding it
> > to CTRL_MODE?
> 
> 
> Is it about the CAN bus termination? Why the driver need to be aware of it?
> If it needed for some reason shouldn't it be a device tree property of that
> device/bridge node? 

I would consider this as a feature, which has to be enabled or disabled on 
demand dynamically, depending on current physical connection, especially 
regarding USB devices. In thise cases there is also no device tree applicable.

Best regards,
Alexander

