From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v8 4/7] can: provide a separate bittiming_const parameter
 to bittiming functions
Date: Fri, 28 Feb 2014 16:15:52 +0100
Message-ID: <5310A828.3030507@hartkopp.net>
References: <1393593549-23072-1-git-send-email-socketcan@hartkopp.net> <1393593549-23072-5-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:63328 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580AbaB1PPy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 28 Feb 2014 10:15:54 -0500
In-Reply-To: <1393593549-23072-5-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hey Marc,

i've just seen a whitespace issue here:

On 28.02.2014 14:19, Oliver Hartkopp wrote:

> -	return 0;
> +	if (!bt->tq && bt->bitrate)
> +			err = can_calc_bittiming(dev, bt, btc);
> +	else if (bt->tq && !bt->bitrate)
> +			err = can_fixup_bittiming(dev, bt, btc);
> +	else
> +		err = -EINVAL;
> +
> +	return err;

Should I send a v9 or what's the best way for you?

Regards,
Oliver
