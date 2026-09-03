Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F4246EF7F
	for <linux-can@vger.kernel.org>; Thu,  3 Sep 2026 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788429890; cv=none; b=bdPmv/Ncxe52bSnq3brgNXg12WZj6y6k/XlXOCefnVQ6CE5w32OVwYSB4Nulo/c8eCGPEBUR9P3aHCLTgP/cyCxfr0c14zUQ6tTNV0AIWjKczlUvPkGCSG4CAfI/7wxycUZjwOMcdd5LpCabhqhW2Zrcsy5syv8P7+F2BID/gds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788429890; c=relaxed/simple;
	bh=aYDcvYGlJz8b2C3OwnhZegR9RdPmtIi0rPBz8u7UIH0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GwHzZOZ7L77yppEOOqlCw6HmR7P+ELC+/cVTU2/TWvZZDr16Nj9chgCiW3+gUwFqW9uo3CfgtzFD6nTu5WVHzNgRJ61zKDI/GfJy2GpYjjdeAkPwXgWZgLboEZPzRMNMH0RZC5n41Z3sax0Pb1IpLHoxJMamSR9xWSARq8TiAqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfaA8NUH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfaA8NUH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7E41F000E9;
	Thu,  3 Sep 2026 10:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788429889;
	bh=+qSYu6HCYk0yJgP7m8Rg91nZ8gtP9anGxoQx6OUVgcg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lfaA8NUHbNceuln8XTrmsOpnlFAvSNMwzdhmw4rJT5XXmabAtE0C6wuLYpLdksquu
	 +Gg/VqVxjatx8RpsdawUVC5QV+9nyhDMNev2pzzPN8dBvFatf8JLRJL8rDjgr9MXW7
	 r8iAsrPjNj5r16rgrYro0fzJ0S5yTPmBxVDyUMm0rJX8BmURgwYYkIOPbd2S1nsL5Y
	 IBrtne9hKKVOza3peoe7m7YiBFSzAJKmzTFfoQOkIxYV34H+xWN7hgvs3XQBiTF4xW
	 IxU08ji+zcVA+eIZsDtqJd8Qyy/q9y/D/mVpgJGckG2vJZfWR1P7xDfesds0yOYyDF
	 Xsrj1qG4CyMeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: sja1000: drop RX frame when skb allocation fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yun Lu" <luyun_611@163.com>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260903095444.495807-1-luyun_611@163.com>
References: <20260903095444.495807-1-luyun_611@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 10:04:48 +0000
Message-Id: <20260903100449.0D7E41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] In sja1000_err(), an SKB allocation failure returns -ENOMEM, disca=
rding IRQ_WAKE_THREAD requests and causing the interrupt handler to erroneo=
usly return IRQ_NONE.
--

commit 6507d559134b8295113fac43d6ce819e79885772
Author: Yun Lu <luyun@kylinos.cn>

can: sja1000: drop RX frame when skb allocation fails

This patch prevents a lockup in sja1000_rx() by dropping the frame and
releasing the receive buffer if SKB allocation fails.

> diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/=
sja1000.c
> index 3cdb583ee3e50..da107feb22af7 100644
> --- a/drivers/net/can/sja1000/sja1000.c
> +++ b/drivers/net/can/sja1000/sja1000.c
> @@ -348,8 +348,12 @@ static void sja1000_rx(struct net_device *dev)
> =20
>  	/* create zero'ed CAN frame buffer */
>  	skb =3D alloc_can_skb(dev, &cf);
> -	if (skb =3D=3D NULL)
> +	if (!skb) {
> +		/* drop the frame to guarantee forward progress of the ISR */
> +		sja1000_write_cmdreg(priv, CMD_RRB);
> +		stats->rx_dropped++;
>  		return;
> +	}
> =20
>  	fi =3D priv->read_reg(priv, SJA1000_FI);

[Severity: High]
This is a pre-existing issue, but while looking at SKB allocation failures
in the interrupt handler, does a similar allocation failure in
sja1000_err() lead to the IRQ line being permanently disabled?

Under memory pressure, if the SKB allocation fails in sja1000_err():

drivers/net/can/sja1000/sja1000.c:sja1000_err() {
    ...
	if (!skb)
		return -ENOMEM;

	netif_rx(skb);

	return ret;
}

This unconditionally returns -ENOMEM, which discards any IRQ_WAKE_THREAD
requests needed for overrun recovery like SJA1000_QUIRK_RESET_ON_OVERRUN.

This error propagates to sja1000_interrupt(), causing the loop to break
before incrementing n:

drivers/net/can/sja1000/sja1000.c:sja1000_interrupt() {
    ...
			err =3D sja1000_err(dev, isrc, status);
			if (err =3D=3D IRQ_WAKE_THREAD)
				ret =3D err;
			if (err)
				break;
		}
		n++;
    ...
}

If this happens on the first loop iteration where n is 0, the handler
returns IRQ_NONE despite having successfully acknowledged the interrupt in
hardware:

drivers/net/can/sja1000/sja1000.c:sja1000_interrupt() {
    ...
out:
	if (!ret)
		ret =3D (n) ? IRQ_HANDLED : IRQ_NONE;
    ...
}

Could repeated IRQ_NONE returns under sustained memory pressure cause the
core IRQ subsystem to permanently disable the device's IRQ line?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903095444.4958=
07-1-luyun_611@163.com?part=3D1
