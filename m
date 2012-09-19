From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v4] can: sja1000: Add support for listen-only mode and
 one-shot mode
Date: Wed, 19 Sep 2012 18:49:07 +0200
Message-ID: <5059F783.5030200@hartkopp.net>
References: <50597536.10703@grandegger.com> <1348050256-9432-1-git-send-email-andreas@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:64401 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398Ab2ISQtJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 19 Sep 2012 12:49:09 -0400
In-Reply-To: <1348050256-9432-1-git-send-email-andreas@gaisler.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: linux-can@vger.kernel.org, software@gaisler.com

On 19.09.2012 12:24, Andreas Larsson wrote:

It's really a nitpick, but

>

>  		/* set chip to normal mode */
> -		priv->write_reg(priv, REG_MOD, 0x00);
> +		if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
> +			priv->write_reg(priv, REG_MOD, MOD_LOM);
> +		else
> +			priv->write_reg(priv, REG_MOD, 0x00);
>  		udelay(10);
>  		status = priv->read_reg(priv, REG_MOD);
>  	}


i would prefer an empty line before (and probably also after) 'udelay(10)'.
For better readability.

Anyway you can add my

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

too.

Thanks,
Oliver
