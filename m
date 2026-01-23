Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43FC19CD05
	for <linux-can@vger.kernel.org>; Fri, 23 Jan 2026 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769173269; cv=none; b=q8Veb6y8FQHblpGdEty+Lh7G84gSMb97v/bYVzoPL29shfciRTjHeB51lD9pkB8jl+iroEh7+5uy2ej6VnYcW6BybnpkjJQAHzJuruC18qwvtW/LVjA9IXN3Ezgj5xqj8wDjPFI2i5K8MjFPGe4TPvUJRTlplVO2FJIuh/doLTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769173269; c=relaxed/simple;
	bh=q0kHQvJ19/iaMpgoUrbYCl0uSRO5+gjjliJ2s/orBko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeMAqlEfRLx6ErBUyib2jDuJbCC3NJwBsGWp0nLpMxxGD+jE9LeFfH3B+5FJlWu/2Enmt26BO5NdQr0H4qBl9/m3u3yQPTZKbawRnEa57TsFbG8j41cXkulok1ct3jm3KAU497gY+KvocAyoPpptV42VW3ms1Z4JCraVGYcWRbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.tretter@pengutronix.de>)
	id 1vjGmb-0001KB-Bi; Fri, 23 Jan 2026 14:01:01 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <m.tretter@pengutronix.de>)
	id 1vjGmb-0025tU-0w;
	Fri, 23 Jan 2026 14:01:00 +0100
Received: from mtr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <m.tretter@pengutronix.de>)
	id 1vjGma-00AvQi-1d;
	Fri, 23 Jan 2026 14:01:00 +0100
Date: Fri, 23 Jan 2026 14:01:00 +0100
From: Michael Tretter <m.tretter@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Achim Baumgartner <abaumgartner@topcon.com>,
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH can-next v2 1/2] can: sja1000: sja1000_err(): make use of
 sja1000_get_berr_counter() to read error counters
Message-ID: <aXNxDA8C5KFLPWjW@pengutronix.de>
References: <20260123-sja1000-state-handling-v2-0-687498087dad@pengutronix.de>
 <20260123-sja1000-state-handling-v2-1-687498087dad@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260123-sja1000-state-handling-v2-1-687498087dad@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.tretter@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

On Fri, 23 Jan 2026 11:16:26 +0100, Marc Kleine-Budde wrote:
> This is a preparation patch to make use of can_state_get_by_berr_counter()
> which works on a struct can_berr_counter.
> 
> Reuse the existing function sja1000_get_berr_counter() to read the error
> counters into a struct can_berr_counter.
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Reviewed-by: Michael Tretter <m.tretter@pengutronix.de>

> ---
>  drivers/net/can/sja1000/sja1000.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
> index a8fa0d6516b9..ae3244b63b65 100644
> --- a/drivers/net/can/sja1000/sja1000.c
> +++ b/drivers/net/can/sja1000/sja1000.c
> @@ -411,14 +411,13 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
>  	struct sk_buff *skb;
>  	enum can_state state = priv->can.state;
>  	enum can_state rx_state, tx_state;
> -	unsigned int rxerr, txerr;
> +	struct can_berr_counter bec;
>  	uint8_t ecc, alc;
>  	int ret = 0;
>  
>  	skb = alloc_can_err_skb(dev, &cf);
>  
> -	txerr = priv->read_reg(priv, SJA1000_TXERR);
> -	rxerr = priv->read_reg(priv, SJA1000_RXERR);
> +	sja1000_get_berr_counter(dev, &bec);
>  
>  	if (isrc & IRQ_DOI) {
>  		/* data overrun interrupt */
> @@ -455,8 +454,8 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
>  	}
>  	if (state != CAN_STATE_BUS_OFF && skb) {
>  		cf->can_id |= CAN_ERR_CNT;
> -		cf->data[6] = txerr;
> -		cf->data[7] = rxerr;
> +		cf->data[6] = bec.txerr;
> +		cf->data[7] = bec.rxerr;
>  	}
>  	if (isrc & IRQ_BEI) {
>  		/* bus error interrupt */
> @@ -515,8 +514,8 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
>  	}
>  
>  	if (state != priv->can.state) {
> -		tx_state = txerr >= rxerr ? state : 0;
> -		rx_state = txerr <= rxerr ? state : 0;
> +		tx_state = bec.txerr >= bec.rxerr ? state : 0;
> +		rx_state = bec.txerr <= bec.rxerr ? state : 0;
>  
>  		can_change_state(dev, cf, tx_state, rx_state);
>  
> 
> -- 
> 2.51.0
> 
> 
