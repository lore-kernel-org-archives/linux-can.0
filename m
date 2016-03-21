From: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: RE: [PATCH v3] can: rcar_canfd: Add Renesas R-Car CAN FD driver
Date: Mon, 21 Mar 2016 08:30:20 +0000
Message-ID: <SG2PR06MB10387C76C0A3289A00D8AE69C38F0@SG2PR06MB1038.apcprd06.prod.outlook.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:9623 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751861AbcCUIa0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 21 Mar 2016 04:30:26 -0400
In-Reply-To: <56EC5AB0.1080107@hartkopp.net>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "wg@grandegger.com" <wg@grandegger.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Oliver,

Should we change the subject of this thread as we are discussing core can? May be others are not reading it as it's not a topic affecting their controller :-)

> On 03/18/2016 02:23 PM, Ramesh Shanmugasundaram wrote:
(...)
> 
> The effect would be that the bitrate(s) and the ctrlmode would have to be
> provided in one netlink message - instead of up to three.
> 
> Today the only known alternative to the 'ip' tool from iproute2 is
> 'libsocketcan'
> 
> http://git.pengutronix.de/?p=tools/libsocketcan.git;a=summary
> 
> But libsocketcan is not CAN FD aware by now.

OK
 
> > The rules I proposed yesterday would also break existing documentation
(...)
> Exactly! That's why I would like to force all ctrlmode_static options to
> be passed.
> 
> In the case of R-Car CAN FD the above example would lead to an error as
> 'fd on' is missing.

Yes.

> 
(...)
> Oh. Without a link to the netdevice we won't be able to check the CAN FD
> capabilities - but we could check the following:
> 
> 1. If we have a ctrlmode attribute and it has CAN_CTRLMODE_FD set we need
> to have bitrate and data bitrate attributes.
> 
> 2. If we have a data bitrate attribute we need to have a bitrate attribute
> and a ctrlmode attribute with CAN_CTRLMODE_FD set.

Yes, but it cannot enforce all ctrlmode_static options being passed. But I see we are doing that check in changelink as it has ndev context. So, it's fine.

> > If we agree on "configuration block", we could resolve dependencies in
> ops->changelink at the end of the function.
> 
> That won't work as ops->changelink has no context and is executed for
> every netlink attribute separately when netlink parses the message.

Nope. changelink is called only once for a "ip link" command irrespective of the number of attributes it's touching. For e.g. 

ip link set can0 type can bitrate 1000000 dbitrate 1000000 fd on

will invoke changelink only once. Hence I mentioned, if we agree on "config block" => "nom rate, data rate, fd flags", we could enforce it & dependencies at the end of changelink function.

But I am ok with your v4 patch - can_validate is enforcing config block and can_changelink is enforcing all static option on. Its fine.
 
> > Anyways that's implementation detail as you mentioned.
(...)
> I think making things more explicit is a good idea.

OK. We shall make this the conclusion. Worth updating Documentation/networking/can.txt?

Coming back to original rcar_canfd patch, will this comment at the start of the code helpful?

/* The R-Car CAN FD controller can operate in either one of the below two modes
 *  - CAN FD only mode
 *  - Classical CAN (CAN 2.0) only mode
 *
 * This driver puts the controller in CAN FD only mode by default. In this
 * mode, the controller acts as a CAN FD node that can also interoperate with
 * CAN 2.0 nodes. The driver does not support dedicated classical CAN (CAN 2.0)
 * mode at present.
 */

Thanks,
Ramesh

