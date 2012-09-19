From: Andreas Larsson <andreas@gaisler.com>
Subject: Re: [PATCH v2] can: sja1000: Add support for listen-only mode and
 one-shot mode
Date: Wed, 19 Sep 2012 07:55:40 +0200
Message-ID: <50595E5C.4000207@gaisler.com>
References: <5058994E.8000501@gaisler.com> <1347986041-5358-1-git-send-email-andreas@gaisler.com> <5058AC95.5070406@pengutronix.de> <5058AE27.5020406@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from vsp-authed02.binero.net ([195.74.38.226]:39605 "HELO
	vsp-authed-03-02.binero.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754086Ab2ISFzr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 19 Sep 2012 01:55:47 -0400
In-Reply-To: <5058AE27.5020406@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, software@gaisler.com

On 09/18/2012 07:23 PM, Oliver Hartkopp wrote:
> On 18.09.2012 19:17, Marc Kleine-Budde wrote:
> What about using just the constants:
>
> if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
> 	priv->write_reg(priv, REG_MOD, MOD_LOM);
> else
> 	priv->write_reg(priv, REG_MOD, 0x00);
>
> Which omits any experiments with extra variables ...

> The same here:
>
> if (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
> 	sja1000_write_cmdreg(priv, CMD_TR|CMD_AT);
> else
> 	sja1000_write_cmdreg(priv, CMD_TR);

Yes, that looks nice.

Cheers,
Andreas

