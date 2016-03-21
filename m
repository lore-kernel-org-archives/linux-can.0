From: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: RE: [PATCH v3] can: rcar_canfd: Add Renesas R-Car CAN FD driver
Date: Mon, 21 Mar 2016 15:43:13 +0000
Message-ID: <SG2PR06MB1038E51956A27CD72F472441C38F0@SG2PR06MB1038.apcprd06.prod.outlook.com>
References: <1457019515-21158-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <1458035294-8150-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <56E80422.9000902@hartkopp.net>
 <SG2PR06MB1038CF8299F3DC3E823BEC8AC3890@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <56E864AC.2040605@hartkopp.net>
 <SG2PR06MB1038BE32574EF8C5830C6A6FC38A0@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <56E92BCF.1080508@hartkopp.net>
 <SG2PR06MB1038489F8A5E87BCAFC62C5AC38A0@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <56E9CE32.6050504@hartkopp.net>
 <SG2PR06MB103804EF4D818384C4F24DF5C38B0@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <56EB17BB.9030308@hartkopp.net>
 <SG2PR06MB1038AD3F5496E8B833098229C38C0@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <56EC5AB0.1080107@hartkopp.net>
 <SG2PR06MB10387C76C0A3289A00D8AE69C38F0@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <56F013B3.6050301@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:63111 "EHLO
	relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755999AbcCUPnT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 21 Mar 2016 11:43:19 -0400
In-Reply-To: <56F013B3.6050301@hartkopp.net>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "wg@grandegger.com" <wg@grandegger.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Oliver.

> > /* The R-Car CAN FD controller can operate in either one of the below
> two modes
> >   *  - CAN FD only mode
> >   *  - Classical CAN (CAN 2.0) only mode
> >   *
> >   * This driver puts the controller in CAN FD only mode by default. In
> > this
> 
> This driver does not support the Classical CAN (CAN 2.0) mode of the
> controller which is handled by a different register set and therefore puts
> the controller in CAN FD only mode by default. In this

With a slight re-wording if I may

"This driver puts the controller in CAN FD only mode by default. In this mode, the 
controller acts as a CAN FD node that can also interoperate with CAN 2.0 nodes.

As of now, this driver does not support the classical CAN (CAN 2.0) mode, which
is handled by a different register map compared to CAN FD only mode"

It kind of implies "can only" mode patch will come next & we consciously submitted CAN FD only first to keep it simple :-)

Thanks,
Ramesh
