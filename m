From: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: RE: [PATCH] can-calc-bit-timing: better bitrate calculcation
Date: Tue, 1 Mar 2016 07:17:42 +0000
Message-ID: <SG2PR06MB1038C9E5B0AB918E5F080500C3BB0@SG2PR06MB1038.apcprd06.prod.outlook.com>
References: <1456755188-28938-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:59985 "EHLO
	relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750823AbcCAHRs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 1 Mar 2016 02:17:48 -0500
In-Reply-To: <1456755188-28938-1-git-send-email-mkl@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Marc,

> From: Marc Kleine-Budde [mailto:mkl@pengutronix.de]
> Sent: 29 February 2016 14:13
> To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
> Cc: linux-can@vger.kernel.org; Marc Kleine-Budde <mkl@pengutronix.de>
> Subject: [PATCH] can-calc-bit-timing: better bitrate calculcation
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> 
> This is work-in-progress. I've to port the current algorithm from the
> kernel here, than rebase the algorithm ontop, than port the algorithm to
> the kernel.

I tried this on kernel and it seems to work fine. Tried 1Mbps bitrate (as that's the one with different BRP between 39.999998/9 & 40MHz clock) and it's OK

Thanks,
Ramesh 
