Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADC3261573
	for <linux-can@vger.kernel.org>; Fri, 23 Jan 2026 13:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769173516; cv=none; b=kWfUGHlgfMOwkOcwz5cViXnAde8gmMhnVr3SfyU+gOptLVhNRDARSEXVSa65UwtKVaAr/tRyQFJJCi0hsMn97jDPLNtmZYyUhqQeyQByZuO2/xv0dCwys2iyO/joTHdY0W/xW1Exw1UCgITuOtcuqlqoT9YD5Ix3kyHX844zooQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769173516; c=relaxed/simple;
	bh=trMJ25mRu8cHme8yiA9ZI39SG5xwATk8mnZJ85/ZB7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQGhSQOxTJdY/vkUgSnL/JWdaqc2fYH4KmNfu7k3GPDPcOaWkzj9Zet5uciRg8jIRblHC/0L3rqPT7zU3HuRvujH9T8ZwnVvHKINR3Gspfgg+/lTIkiXkAAPJTmV0G+OpT23QCyZFR5gXLZqdieQVcOUhnvqI5H8QyIWtFXZaC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.tretter@pengutronix.de>)
	id 1vjGqc-0002Og-33; Fri, 23 Jan 2026 14:05:10 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <m.tretter@pengutronix.de>)
	id 1vjGqb-0025yA-3D;
	Fri, 23 Jan 2026 14:05:09 +0100
Received: from mtr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <m.tretter@pengutronix.de>)
	id 1vjGqb-00AvRa-0g;
	Fri, 23 Jan 2026 14:05:09 +0100
Date: Fri, 23 Jan 2026 14:05:09 +0100
From: Michael Tretter <m.tretter@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Achim Baumgartner <abaumgartner@topcon.com>,
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH can-next v2 2/2] can: sja1000: sja1000_err(): use error
 counter for error state
Message-ID: <aXNyBejLTMvMHiUH@pengutronix.de>
References: <20260123-sja1000-state-handling-v2-0-687498087dad@pengutronix.de>
 <20260123-sja1000-state-handling-v2-2-687498087dad@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260123-sja1000-state-handling-v2-2-687498087dad@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.tretter@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

On Fri, 23 Jan 2026 11:16:27 +0100, Marc Kleine-Budde wrote:
> From: Michael Tretter <m.tretter@pengutronix.de>
> 
> The CAN controller sends the EPI interrupt whenever it reaches the error
> passive status or enters the error active status from the error passive
> status.
> 
> Instead of keeping track of the controller status in the driver, read the
> txerr and rxerr counters and use can_state_get_by_berr_counter() to
> determine the state of the CAN controller.
> 
> Suggested-by: Achim Baumgartner <abaumgartner@topcon.com>
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/sja1000/sja1000.c | 33 +++++++--------------------------
>  1 file changed, 7 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
> index ae3244b63b65..67fccc15ed20 100644
> --- a/drivers/net/can/sja1000/sja1000.c
> +++ b/drivers/net/can/sja1000/sja1000.c
> @@ -407,10 +407,9 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
>  {
>  	struct sja1000_priv *priv = netdev_priv(dev);
>  	struct net_device_stats *stats = &dev->stats;
> +	enum can_state state, rx_state, tx_state;
>  	struct can_frame *cf;
>  	struct sk_buff *skb;
> -	enum can_state state = priv->can.state;
> -	enum can_state rx_state, tx_state;
>  	struct can_berr_counter bec;
>  	uint8_t ecc, alc;
>  	int ret = 0;
> @@ -418,6 +417,12 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
>  	skb = alloc_can_err_skb(dev, &cf);
>  
>  	sja1000_get_berr_counter(dev, &bec);
> +	can_state_get_by_berr_counter(dev, &bec, &tx_state, &rx_state);
> +
> +	if (status & SR_BS)
> +		rx_state = CAN_STATE_BUS_OFF;

I was wondering why you dropped the check for (status & SR_ES). SR_ES
just indicates that one of the error counters exceeded the warning
limit, which is handled by can_state_get_by_berr_counter(). Thus, it's
fine to drop the check.

Thanks!

Michael

> +
> +	state = max(tx_state, rx_state);
>  
>  	if (isrc & IRQ_DOI) {
>  		/* data overrun interrupt */
> @@ -440,18 +445,6 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
>  		if (priv->flags & SJA1000_QUIRK_RESET_ON_OVERRUN)
>  			ret = IRQ_WAKE_THREAD;
>  	}
> -
> -	if (isrc & IRQ_EI) {
> -		/* error warning interrupt */
> -		netdev_dbg(dev, "error warning interrupt\n");
> -
> -		if (status & SR_BS)
> -			state = CAN_STATE_BUS_OFF;
> -		else if (status & SR_ES)
> -			state = CAN_STATE_ERROR_WARNING;
> -		else
> -			state = CAN_STATE_ERROR_ACTIVE;
> -	}
>  	if (state != CAN_STATE_BUS_OFF && skb) {
>  		cf->can_id |= CAN_ERR_CNT;
>  		cf->data[6] = bec.txerr;
> @@ -493,15 +486,6 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
>  			stats->rx_errors++;
>  		}
>  	}
> -	if (isrc & IRQ_EPI) {
> -		/* error passive interrupt */
> -		netdev_dbg(dev, "error passive interrupt\n");
> -
> -		if (state == CAN_STATE_ERROR_PASSIVE)
> -			state = CAN_STATE_ERROR_WARNING;
> -		else
> -			state = CAN_STATE_ERROR_PASSIVE;
> -	}
>  	if (isrc & IRQ_ALI) {
>  		/* arbitration lost interrupt */
>  		netdev_dbg(dev, "arbitration lost interrupt\n");
> @@ -514,9 +498,6 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
>  	}
>  
>  	if (state != priv->can.state) {
> -		tx_state = bec.txerr >= bec.rxerr ? state : 0;
> -		rx_state = bec.txerr <= bec.rxerr ? state : 0;
> -
>  		can_change_state(dev, cf, tx_state, rx_state);
>  
>  		if(state == CAN_STATE_BUS_OFF)
> 
> -- 
> 2.51.0
> 
> 
