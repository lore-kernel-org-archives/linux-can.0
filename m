Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF4E2F0C74
	for <linux-can@vger.kernel.org>; Tue, 28 Jul 2026 13:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785243992; cv=none; b=rZoGVPAVMNCr2Fd8+Eeuc+JAWV+RKCQbE5LG33bOSF/j0/uMJ22Y646eOO9xgB6Pcsuyjy/P635NvOM+ZNk0StToVjmkP735XHKzi491tiLhdQg4Ryx22VadZI/RFNr+y3gG5DRsXua8GzC9bkHlvwoL5+SmSxoQrF8tx9en684=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785243992; c=relaxed/simple;
	bh=q5/mIDzzWiyKLYNcj8FB/fEEAWtgq+fxrHFY/wntuLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETtIBfctyaAlBjpPBo0KL+ldlZgpgKzpEIojHHDPYyEB+jK7WclpGEtwr2nug9F4a0owP65Nq9H9jTCRSA9ir8HQmxBOjZqDhztTqFd+9oESOlStp1doDks+bqvMFvNuB0B3sTkNCaug7pjxKfYsw4tuJGDC1mkq3vXv/5gf3xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 7E4602029DD;
	Tue, 28 Jul 2026 15:06:24 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wohVo-001ivV-1O;
	Tue, 28 Jul 2026 15:06:24 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wohVo-00000009qr6-1Nua;
	Tue, 28 Jul 2026 15:06:24 +0200
Date: Tue, 28 Jul 2026 15:06:24 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: sashiko-reviews@lists.linux.dev
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH can v1 1/2] can: j1939: use netdevice_tracker for
 j1939_{priv,session,ecu} tracking
Message-ID: <amipUDANStLdpEYW@pengutronix.de>
References: <20260728055835.1151785-1-o.rempel@pengutronix.de>
 <20260728055835.1151785-2-o.rempel@pengutronix.de>
 <20260728061338.9A6711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260728061338.9A6711F000E9@smtp.kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Tue, Jul 28, 2026 at 06:13:38AM +0000, sashiko-bot@kernel.org wrote:
> --- Patch [1]: [PATCH can v1 1/2] can: j1939: use netdevice_tracker for j1939_{priv,session,ecu} tracking ---
> commit fa6ae711cbc8e468a294fc1a54de5efa19c0b5b3
> Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> 
> can: j1939: use netdevice_tracker for j1939_{priv,session,ecu} tracking
>     
> This patch enables netdevice_tracker for j1939_priv, j1939_session, and
> j1939_ecu structures. It aims to help identify the source of refcount
> leaks reported by syzbot during unregister_netdevice().
> 
> > diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> > index dc374286eeb6e..cdc3c0a719379 100644
> > --- a/net/can/j1939/bus.c
> > +++ b/net/can/j1939/bus.c
> > @@ -20,6 +20,7 @@ static void __j1939_ecu_release(struct kref *kref)
> >  	struct j1939_priv *priv = ecu->priv;
> >  
> >  	list_del(&ecu->list);
> 
> [Severity: High]
> This is a pre-existing issue, but is it safe to modify priv->ecus here without
> holding priv->lock?
> 
> If a process unbinds a socket and drops its ECU reference concurrently with the
> network receive path processing a packet:

Ack - we will keep it mind. This is not blocker for current patch set.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
