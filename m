Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFB15221CF
	for <linux-can@vger.kernel.org>; Wed, 14 Oct 2026 13:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984947; cv=none; b=TmSEOQFydSOR8yWtHmeFJeW4Bzd4ca9Dypgq++vv0djMi0mqaDzQDzzMk06mnDxqDAIySDG4LdsVyoNMEaF+owZKSOB1XjPrzWtn3qC+Ttzqw4wF53jXFnwkS9jy6jQTyWNSczK5RGWGXKQKEv19f1Izjm3ICalFw7B1Bj3EFDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984947; c=relaxed/simple;
	bh=BiaxYDkqVwXqjsJ1EL9ks/qyc2UAhPlTUp00Vmce2rg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=sg04Z771X8y3lQ7BIzPG6HZXmRiZqExTUzKImDs1siq0Y3b8MOSkmLeSeLuUtBX3qCP0Wbk99EfcRIp65582tiaiqv2t93bsE+4Hs4Fw+2v4exPq7yBzM39sOVOELg3xPVdZh+1Jc/pB51pfZlaI0DK/Be7MRP/vj+MUjH0Z5Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaLwevxI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaLwevxI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F4C1F000FF;
	Wed, 14 Oct 2026 13:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791984937;
	bh=Maz7e6QxzIJFTJ/51moQBbdsrEJeeNDP62M7qBv0rzI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LaLwevxIWAUf937VzoVdkcUkcjAb+VoI4AMK9j5I2fagW/exl9Cy4ZlYGldE/Nwx3
	 2RqSrDqa5osqGuKKBz72GQQxHymmQ49LF70780IgNrPtlkJ9R9R5sCgArD39spkYrh
	 6UGOxMTMiRUGrgDTvVk+PmJXgRXA1wSIlZCklylJjegMYwZwTZH+ZUihhMZvDVmMSg
	 1b8sJMWfUl6Zft4Hco3Ss0ML/Kobrgayaqvo/Y3C5Yb07gX3CXuHvEGcfWg0fszOuI
	 9ueiz/MxPanrW5R/Ch1dx8NbvOUt+pxJsmvSMaUHXUqFugooUfm85VnXntdOFJK6sn
	 SMTNldnmooq5g==
Message-ID: <sashiko-outbox-171361@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 4/5] can: rockchip_canfd: prevent timestamp work
 from rearming after bus-off
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261014-rockchip-canfd-restart-close-v3-4-f0eb41090242@qq.com>
References: <20261014-rockchip-canfd-restart-close-v3-0-f0eb41090242@qq.com>
 <20261014-rockchip-canfd-restart-close-v3-4-f0eb41090242@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 13:35:36 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] can: rockchip_canfd: torn read and data race on timecounter state
--

commit ba848a69df4d87c5d955ac1607d9318a5bab577e
Author: Cunhao Lu <1579567540@qq.com>

can: rockchip_canfd: prevent timestamp work from rearming after bus-off

This commit adds a timestamp_lock and timestamp_active flag to prevent the
timestamp work from requeuing itself after cancellation. It synchronizes the
worker's active check, timecounter read, and self-requeue.

> diff --git a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c b/driver=
s/net/can/rockchip/rockchip_canfd-timestamp.c
> index ad582afbbd682..0fa791849c957 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
> @@ -30,18 +30,27 @@ static void rkcanfd_timestamp_work(struct work_struct=
 *work)
>  {
>  	const struct delayed_work *delayed_work =3D to_delayed_work(work);
>  	struct rkcanfd_priv *priv;
> +	unsigned long flags;
> =20
>  	priv =3D container_of(delayed_work, struct rkcanfd_priv, timestamp);
> -	timecounter_read(&priv->tc);
> -
> -	schedule_delayed_work(&priv->timestamp, priv->work_delay_jiffies);
> +	spin_lock_irqsave(&priv->timestamp_lock, flags);
> +	if (priv->timestamp_active) {
> +		timecounter_read(&priv->tc);

[Severity: Medium]
Does this leave a data race with datapath readers?

The worker thread updates the timecounter state here while holding
timestamp_lock. However, the RX/TX datapath calls
rkcanfd_skb_set_timestamp() which reads the timecounter locklessly:

rkcanfd_skb_set_timestamp() {
    ...
    ns =3D timecounter_cyc2time(&priv->tc, timestamp);
    ...
}

Since timecounter_read() modifies the timecounter state non-atomically,
can the concurrent lockless read result in torn reads or an inconsistent
observation of the cycle counter and nanoseconds, especially on 32-bit
platforms?

> +
> +		/* Serialize requeueing with timestamp_stop(). */
> +		schedule_delayed_work(&priv->timestamp, priv->work_delay_jiffies);
> +	}
> +	spin_unlock_irqrestore(&priv->timestamp_lock, flags);
>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-rockchip-c=
anfd-restart-close-v3-0-f0eb41090242@qq.com?part=3D4
