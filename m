From: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: RE: [RFC] [PATCH v4] can: fix handling of unmodifiable configuration
 options
Date: Mon, 21 Mar 2016 15:19:41 +0000
Message-ID: <SG2PR06MB10384D5560A346BFF451F61DC38F0@SG2PR06MB1038.apcprd06.prod.outlook.com>
References: <1458374870-5380-1-git-send-email-socketcan@hartkopp.net>
 <SG2PR06MB10388D08005F04DAD837A02DC38F0@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <56F00B1E.5080909@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:62460 "EHLO
	relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756004AbcCUPTq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 21 Mar 2016 11:19:46 -0400
In-Reply-To: <56F00B1E.5080909@hartkopp.net>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Oliver,

> thanks for your feedback - also in the other thread with the wrong subject
> :-)
Thanks :-)

> 
> Indeed I feel pretty good about this solution:
> 
> 1. it maintains the current behaviour for CAN2.0 controllers 2. it forces
> valid combinations for CAN FD 3. it forces the user to think about static
> ctrlmodes
> 
> The only thing I was not sure about when forcing static ctrlmodes to be
> set was the fact that you would need to set fd-non-iso for the MCAN
> controller setup - even when you only configure it for CAN2.0 traffic:
> 
> ip link set can0 type can bitrate 100000 -> ok
> 
> ip link set can0 type can bitrate 100000 one-shot on -> fail

Oh! I checked for M_CAN but only the config above this. Good that you spotted.

> 
> ip link set can0 type can bitrate 100000 one-shot on fd-non-iso on -> ok
> 
> To be consistent with 'static ctrlmodes have to be provided' it looks ok.
> But from a CAN2.0 perspective it looks confusing.

Definitely.

> 
> I wonder if it makes sense to handle this *special* case not to force fd-
> non-iso when the controller won't get into FD mode. What do you think?

Yes, I agree. Non-ISO only mode will eventually phase out and having a "special" case for this sounds logical.
 
Thanks,
Ramesh
