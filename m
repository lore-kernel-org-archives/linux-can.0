From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC] [PATCH v3] can: fix handling of unmodifiable configuration
 options
Date: Tue, 15 Mar 2016 09:17:06 +0100
Message-ID: <56E7C502.4080109@hartkopp.net>
References: <1457982490-27520-1-git-send-email-socketcan@hartkopp.net>
 <SG2PR06MB10380F64CC37C3F7B4D46017C3890@SG2PR06MB1038.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:18030 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933992AbcCOIRV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 15 Mar 2016 04:17:21 -0400
In-Reply-To: <SG2PR06MB10380F64CC37C3F7B4D46017C3890@SG2PR06MB1038.apcprd06.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Stephane Grosjean <s.grosjean@peak-system.com>

Hello Marc,

On 03/15/2016 08:15 AM, Ramesh Shanmugasundaram wrote:
>> Oliver Hartkopp <socketcan@hartkopp.net>
>> Subject: [RFC] [PATCH v3] can: fix handling of unmodifiable configuration
>> options

(..)

>> Reported-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>
> Reviewed-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
> Tested-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
>

I would suggest to queue this patch for stable 3.18+ where I applies 
without problems.

Ubuntu maintains a 3.16 longterm kernel - but I do not see a real 
benefit for that kernel as it would only affect the M_CAN driver there. 
I doubt any M_CAN hardware is used together with this specific Ubuntu 
kernel as we already would have get any feedback then.

Once this patch emerged in Linux 4.0 I'll send a patch for the PCAN USB 
FD adapters which are potential can_set_static_ctrlmode() users too.

Best regards,
Oliver

