From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v3] can: rcar_canfd: Add Renesas R-Car CAN FD driver
Date: Tue, 15 Mar 2016 13:46:26 +0100
Message-ID: <56E80422.9000902@hartkopp.net>
References: <1457019515-21158-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <1458035294-8150-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:25938 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbcCOMrP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 15 Mar 2016 08:47:15 -0400
In-Reply-To: <1458035294-8150-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Cc: mkl@pengutronix.de, linux-can@vger.kernel.org

Hi Ramesh,

two more questions from my side:

On 03/15/2016 10:48 AM, Ramesh Shanmugasundaram wrote:

> +config CAN_RCAR_CANFD
> +	tristate "Renesas R-Car CAN FD controller"
> +	depends on ARCH_RENESAS || ARM
> +	---help---
> +	  Say Y here if you want to use CAN FD controller found on
> +	  Renesas R-Car SoCs.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called rcar_canfd.

Would it make sense to add some more documentation here that this 
controller is a CANFD-only CAN controller which (of course) can cope 
with CAN2.0B frames but has no dedicated CAN2.0B mode?

(..)

> +static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch)
> +{

(..)

> +
> +	priv->can.bittiming_const = &rcar_canfd_nom_bittiming_const;
> +	priv->can.data_bittiming_const =
> +		&rcar_canfd_data_bittiming_const;
> +
> +	/* Controller starts in CAN FD only mode. In this mode, to interoperate
> +	 * with classical CAN only nodes, data bitrate should be configured the
> +	 * same as nominal bitrate.
> +	 */

'Should' sounds like a pretty soft requirement here - and this info 
should not hide deep in the code IMO.

What happens if the user only defines:

	"ip link set can0 up type can bitrate 1000000"

instead of

	"ip link set can0 up type can bitrate 1000000 dbitrate 1000000"

??

Would it make sense to set the data bitrate according to the arbitration 
bitrate in rcar_canfd_set_bittiming() or sanitize this at some other 
place when not data bitrate is given by the netlink command?

Regards,
Oliver
