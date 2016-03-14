From: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: RE: [RFC] [PATCH v2] can: fix handling of unmodifiable configuration
 options
Date: Mon, 14 Mar 2016 10:15:38 +0000
Message-ID: <SG2PR06MB1038D9B53602CECA8E34C4D4C3880@SG2PR06MB1038.apcprd06.prod.outlook.com>
References: <1457807487-14691-1-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:39029 "EHLO
	relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752020AbcCNKPm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 14 Mar 2016 06:15:42 -0400
In-Reply-To: <1457807487-14691-1-git-send-email-socketcan@hartkopp.net>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Oliver,

Thanks for the patch.

> Oliver Hartkopp <socketcan@hartkopp.net>
> Subject: [RFC] [PATCH v2] can: fix handling of unmodifiable configuration
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

Thanks. This looks cleaner. I'll use this function in my driver.

> 
> Additionally it fixes the inconsitency that was prohibiting the support of
> 'CANFD-only' controller drivers.
> 
> Reported-by: Ramesh Shanmugasundaram
> <ramesh.shanmugasundaram@bp.renesas.com>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  drivers/net/can/dev.c         | 18 +++++++++++++++---
>  drivers/net/can/m_can/m_can.c |  2 +-
>  include/linux/can/dev.h       | 14 ++++++++++++--
>  3 files changed, 28 insertions(+), 6 deletions(-)
> 

(...)

> 
> +static inline void can_set_static_ctrlmode(struct can_priv *priv,
> +					   const u32 static_mode)
> +{
> +	priv->ctrlmode = static_mode;
> +	priv->ctrlmode_static = static_mode;
> +}

Is it worth taking the ndev as arg and change the MTU as well in this function? This way mode & MTU would be consistent and would reflect the same in a configuration like this

"ip link set can0 up type can bitrate 1000000 dbitrate 1000000"

Would this be an overkill?

Thanks,
Ramesh
