Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794223621;
	b=dHKJ6wDYKrzErDo0Bk+lVykhAsSjw4PRlzVza2CzTCWHe46KjA3IQ9ehmkJRafw95fdU
	 Nhzznoov2pmopBm7QCZTVV/odq5zwhhIpG4pzgoJmEdXq+HXTYEJ4O9id3Yj1UlErK3Dl
	 1OLGuG6rY0wPtV+MoDgvwpkJvAZKVd2GvWQ/Z/YqHYYUQyNUp6LLoLBdxOG8ojUHQaCFF
	 PC6AnFB/vPxZqbz4BAaH0VLQX8ADqYIQNypWppV3dO1JO5PM9fR+cDax2VCC6cVkVEndt
	 65li0nHOXGV1p/czd//nKwYDkoUeFOPYWyi9M30Xy7kIRYGxvLPKMXF0SXeuyXtKwjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794223621;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=7vkR76vxiZvqQS1KpLweiiiuaXPvXlO8QS32ErQnsCs=;
	b=O+92Np3TNiBNROJsQs1QbLtj+/C/6xBvBzsUXY5xuR3yTpGFkVYo+L8G+Ru0b2v+elRd
	 iNFBsdo/hC1MI1WmjsHAPw0NXLzV9BxYANlpB35PoCw6HpCdZoT7FLXjNiQqAH9V/IhG5
	 93Jp/BcqSUUJ4P0H4oNi14p9yHTNzjSQt5avoiiW0pTF6dy5Ad4vkekKUHCSjv/tVVC4J
	 Z7iicmKruN1Gfs+B0OWcyWOJ6YZSsJgB2SrnqnPK9WwTV2mwZTJvERP13lksrCxgmsBzb
	 IZ0QJ8OKK0wfIS7gv5dOz52TuXsKmn718zxbep4lLjoLgiA5HLDS54TmbJCYS0DtULg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=HWM5DoXH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA320606A321
	for <linux-can@vger.kernel.org>; Mon,  9 Nov 2026 11:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA320606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=HWM5DoXH
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D8F76200EAE;
	Mon, 09 Nov 2026 12:26:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794223617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7vkR76vxiZvqQS1KpLweiiiuaXPvXlO8QS32ErQnsCs=;
	b=HWM5DoXHIG4qzIHhwgthjL028K5Eed50gbliMGYIzCKHin6kqSyZMmVKTJ3TTEtzYN4gut
	p2B9RriFMJZZQx/NZjkuoVlL4DUB+Jq7ulA/VD7FBj9qC4PXaShCeuP0BNbuITBGLcVMm9
	bk1Pv52FIE60M111LHVbvIAUjD4/w9XIv1YmnjHs7q/6fXjwckh8Cz8kOt3dnSQ4cnd+mq
	+ywrQhohwfhkuMdmvkkyYaOpjJFLPmDSUW5VH7WPVwDlCIJr/HY9u84XhPiyVPReINB3qA
	An1HpdyvSoaEKk5Y9nUQHpmBi7k1wt9PNQga4etnqF5iVVoaBo1XrY2xUUNj1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794223617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7vkR76vxiZvqQS1KpLweiiiuaXPvXlO8QS32ErQnsCs=;
	b=AnKJr2T9X0tAGFGuo7tZBDkFtWASED6PZpyo9j+zzojqULHebos5kZJjEHBw3BqOXe1NbY
	ETzjM22rAM7L+IR8BEIDMrCop53PzoMT5u+INmIbudFQFx2I4cqBy59tIVdyoLxqu5HwgP
	wSnEpCjo5g631xysNTXDZjqsJKSwvdf7D9Mrxa8EnESk7gLeEclI2DzcHLKvWfYtdOlqO2
	p37eoLs2cQcFDHw/K+iAX8HsTNSof+AI43bKlOr/uf9ngNXxO8zTXNWfOCJ4dkMw1LVp/J
	j05/91gZEInZkqDteC7Iz86s0dkMYZVvoz2bkdKdsGRUZorkvmlvzKkPlgpJyQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794223617; a=rsa-sha256;
	cv=none;
	b=Vg6UQO2k2heI/yNi9X5ZBCOLdZ2eXTqwqc09YyYlKFXiO4XIKOhRfNqE46FlbPY4/68BVF
	+PCj8UhtyqHRwtTNoRvUmx2dSMNMslRxOcMODwaXH6mhN71v/sRL8MWcxwQHVkmbj74+Gp
	5DG9HbCzT8iUGO4WPE2tJgG0/wYRmauyKJGzqHGhLqxOw/9isiWkknnZTi3TUGEUpfWkHx
	f0NwHB105WEog7heluvfWh60STX5KcZmj9MBWhVxOxV1YTc6AunhkqgMUZ7b8L43D6n/Dk
	Z2QQY786lIc3s4oMomaeUZnyQssLN9Pwy6V0RE9Ena3o59yUMbjMYmDHdvp6yg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xQNWb-003Kp0-2Y;
	Mon, 09 Nov 2026 12:26:57 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 815BC5E537A;
	Mon, 09 Nov 2026 11:26:57 +0000 (UTC)
Date: Mon, 9 Nov 2026 12:26:57 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: linux-can@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [PATCH] can: mcp251xfd: Always stop on BUS_OFF and call
 netif_stop_queue
Message-ID: <20261109-kickass-thundering-mule-ead9e8-mkl@pengutronix.de>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.12523541-9b07-4081-b2ca-c8093468f69e@emailsignatures365.codetwo.com>
 <20261109070605.9761-1-mike.looijmans@topic.nl>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="puxb6mnxxbabw7h2"
Content-Disposition: inline
In-Reply-To: <20261109070605.9761-1-mike.looijmans@topic.nl>


--puxb6mnxxbabw7h2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: mcp251xfd: Always stop on BUS_OFF and call
 netif_stop_queue
MIME-Version: 1.0

On 09.11.2026 08:06:03, Mike Looijmans wrote:
> When there's an error attempting to store the BER counter, don't abort
> but continue shutting down the chip as required.
>
> After disabling communications, also stop the TX queue with a call to
> netif_stop_queue. When the interface restarts, mcp251xfd_set_mode will
> call netif_wake_queue and resume.
>
> This fixes a hangup in either send() or poll() from userspace. To
> reproduce: I ran "cansequence can0 -p" to flood the system with packets.
> While running that, I shorted the CAN signals, causing a bus error.
> Usually communications would resume after the CAN bus restarted, but
> sometimes the system got stuck and refused to send any more packets.
> The sending process would be in either poll() or send(), waiting for
> the queue to resume. To "unstuck" the process from send() it was
> sufficient to send any packet on the can interface from another
> process. To get it out of the poll() hang, only bringing the can
> interface down (and up) would work.
>
> After adding the netif_stop_queue call, I was unable to reproduce the
> problem.
>
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>
> ---
>
>  drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net=
/can/spi/mcp251xfd/mcp251xfd-core.c
> index f441f2265299e..9770416b24723 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> @@ -1131,10 +1131,11 @@ static int mcp251xfd_handle_cerrif(struct mcp251x=
fd_priv *priv)
>  		 */
>  		err =3D __mcp251xfd_get_berr_counter(priv->ndev, &priv->bec);
>  		if (err)
> -			return err;
> +			netdev_err(priv->ndev, "Failed to store BER counter\n");

Do you see this error message? The only thing that can fail is the SPI
communication (and probably some OOM) and if that fails we have a bigger
problem. Can you adjust the error message, that it prints "Failed to read
BER counter\n", which is a bit more towards the root cause of the problem.

>
>  		mcp251xfd_chip_stop(priv, CAN_STATE_BUS_OFF);
>  		can_bus_off(priv->ndev);
> +		netif_stop_queue(priv->ndev);

I think the cause is that can_bus_off() asynchronously stops the netif
queue. Can you apply this patch (instead of yours) and check if it
triggers?

--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -156,6 +156,12 @@ static inline bool can_dev_dropped_skb(struct net_devi=
ce *dev, struct sk_buff *s
        u32 silent_mode =3D priv->ctrlmode & (CAN_CTRLMODE_LISTENONLY |
                                            CAN_CTRLMODE_RESTRICTED);

+       if (priv->state >=3D CAN_STATE_BUS_OFF) {
+               netdev_info_once(dev, "interface in %s state, dropping skb\=
n",
+                                can_get_state_str(priv->state));
+               goto invalid_skb;
+       }
+
        if (silent_mode) {
                netdev_info_once(dev, "interface in %s mode, dropping skb\n=
",
                                 can_get_ctrlmode_str(silent_mode));

regards,
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--puxb6mnxxbabw7h2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCavGt/gAKCRDMOmT6rpmt
0hFXAP9fzYF2PJmXHa5XZ7LbdkhBeRPwa/1Oy+ePRhrSRYde7AEAsQrIieZog6MS
OimnCO7nRq+5kkDkjAFQy5I01uKYBA4=
=diKH
-----END PGP SIGNATURE-----

--puxb6mnxxbabw7h2--
