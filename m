From: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: RE: [RFC] [PATCH v3] can: fix handling of unmodifiable configuration
 options
Date: Tue, 15 Mar 2016 07:15:36 +0000
Message-ID: <SG2PR06MB10380F64CC37C3F7B4D46017C3890@SG2PR06MB1038.apcprd06.prod.outlook.com>
References: <1457982490-27520-1-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:31986 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S934058AbcCOHPj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 15 Mar 2016 03:15:39 -0400
In-Reply-To: <1457982490-27520-1-git-send-email-socketcan@hartkopp.net>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Oliver,

Thanks for the patch.

> Oliver Hartkopp <socketcan@hartkopp.net>
> Subject: [RFC] [PATCH v3] can: fix handling of unmodifiable configuration
> options
> 
> As described in 'can: m_can: tag current CAN FD controllers as non-ISO'
> (6cfda7fbebe) it is possible to define fixed configuration options by
> setting the according bit in 'ctrlmode' and clear it in
> 'ctrlmode_supported'.
> This leads to the incovenience that the fixed configuration can not be
> passed by netlink (ip tool) even when it has the correct value (e.g. non-
> ISO, FD).
> 
> This patch fixes that issue and allows fixed set bit values to be set
> again which does not change the unmodifiable content. For this reason a
> new helper
> can_set_static_ctrlmode() has been introduced to provide a proper
> interface to handle static enabled CAN controller options.
> 
> Additionally it fixes the inconsitency that was prohibiting the support of
> 'CANFD-only' controller drivers.
> 
> Reported-by: Ramesh Shanmugasundaram
> <ramesh.shanmugasundaram@bp.renesas.com>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Reviewed-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Tested-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>

Thanks,
Ramesh

