Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25E6443A9D
	for <linux-can@vger.kernel.org>; Thu, 27 Aug 2026 12:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787832659; cv=none; b=DB7SVfBqyOX9zuznhH+swpmn5LUrFplUa6UlsvN/TAB4y/mxfa6grjHIQTai1Qn14+65JUTM4oPV54kvL9ovHP3B+5doylVFNSHmpcMvLHgvB3N7SKnmeFYy+AzdcM7OBuhdQ07yaj4vpt059Q0hL2IQyGAjv6+8PgV0MZMwJeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787832659; c=relaxed/simple;
	bh=xGWdnJ7xaoEDFyvj/4uHqwKocyKNL5gXvWurDCEERro=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VmE6ZfcQ0hFKJx/GpYR7rOwVsPFtzge8mwSnArRBEOG2aX8SHGbZOcmGZa2S5NPeNfwjA+sUXaw44Y1oFbUPAiC4hksvJ9tMQwxpXwC9p0zOAV0kxEaAvgXxI5XoYWvLGH0PZkMUPXLOhwzJWfoGP+4sDDqbfxmGcKBAsoRCV0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCDtAGXj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCDtAGXj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6DD1F00A3A;
	Thu, 27 Aug 2026 12:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787832657;
	bh=e7GAEz1yy0T85/YWBFSMkacVX6FzlQToyHUrSQHvrrQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mCDtAGXjvcZEiAuObACYESXXTFIeA9ipC6pJ2SPV49SZr23g4ieQO2sbMDKQxjFUb
	 qkvGan1cOrGVd9eCWTHKWJAM0Za88oRS/Kpb0C/YVvG5CqupL8k6Ac14crYq+zgcg3
	 RMLZjXH98HFK4QdaZJPY0vun99UAd41moStvX9UM5N+HE4/wqcVMFR25t+FD1Bw9mn
	 FuiUMCC6zNRygM61aNQbqpg3z9CuySKmM8bXiumMxSGPl2hhD/UjMlyu7kz4M90ohu
	 N6qFbhR0P+bcyov8CbXXemsLmmI5sytlDc+BvcSx1rFbZNHoIIjPLr8Rq6zXEfljd3
	 KENifYR7vDRJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 14/14] can: hi311x: drop hi3110_lock before
 free_irq() on open failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260826121036.2706424-15-mkl@pengutronix.de>
References: <20260826121036.2706424-1-mkl@pengutronix.de>
 <20260826121036.2706424-15-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 12:10:57 +0000
Message-Id: <20260827121057.9B6DD1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent execution of hi3110_clean() without mutual exclusion ca=
n result in a double-free of priv->tx_skb and a data race on priv->tx_busy.
- [High] hi3110_stop() does not cancel pending driver workqueues (priv->res=
tart_work and priv->tx_work), leading to use-after-free, IRQ storms, or har=
dware access after power off.
--

commit 22aa36b3ba9420685fbf25a2a6f3ce41f336fdb3
Author: Runyu Xiao <runyu.xiao@seu.edu.cn>

can: hi311x: drop hi3110_lock before free_irq() on open failure

hi3110_open() requests a threaded IRQ and then performs hardware setup while
holding priv->hi3110_lock. If setup fails, dropping the lock before calling
free_irq() prevents a deadlock against a pending IRQ thread.

Link: https://patch.msgid.link/20260820020631.316418-1-runyu.xiao@seu.edu.cn

> diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
> index ae90e6716de5b..2be851e8907d0 100644
> --- a/drivers/net/can/spi/hi311x.c
> +++ b/drivers/net/can/spi/hi311x.c
> @@ -787,7 +787,10 @@ static int hi3110_open(struct net_device *net)
>  	return 0;
> =20
>   out_free_irq:
> +	priv->force_quit =3D 1;
> +	mutex_unlock(&priv->hi3110_lock);
>  	free_irq(spi->irq, priv);
> +	mutex_lock(&priv->hi3110_lock);
>  	hi3110_hw_sleep(spi);
>   out_close:
>  	hi3110_power_enable(priv->transceiver, 0);

[Severity: High]
This isn't a bug introduced by this patch, but can concurrent execution of
hi3110_clean() without mutual exclusion result in a double-free of
priv->tx_skb and a data race on priv->tx_busy?

It appears hi3110_do_set_mode() can enter hi3110_clean() unlocked, while
hi3110_tx_work_handler() can enter it locked. If they run concurrently, cou=
ld
this result in simultaneously invoking dev_kfree_skb() and corrupting the
echo skb state?

drivers/net/can/spi/hi311x.c:hi3110_clean() {
    ...
    dev_kfree_skb(priv->tx_skb);
    if (priv->tx_busy)
        can_free_echo_skb(priv->net, 0, NULL);
    ...
}

[Severity: High]
This is a pre-existing issue, but does hi3110_stop() need to cancel pending
driver workqueues like priv->restart_work and priv->tx_work?

Currently, there is no cancel_work_sync() in hi3110_stop(). Could this lead
to hardware access after power off if hi3110_can_remove() disables main VDD
power before the workqueue is drained?

For instance, if hi3110_restart_work_handler() runs after power off, would
it force execution against powered-off hardware and cause SPI bus faults?

drivers/net/can/spi/hi311x.c:hi3110_restart_work_handler() {
    ...
    if (priv->restart_tx) {
        priv->restart_tx =3D 0;
        hi3110_hw_reset(spi);
        hi3110_setup(net);
        hi3110_clean(net);
        hi3110_set_normal_mode(spi);
        netif_wake_queue(net);
    }
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826121036.2706=
424-1-mkl@pengutronix.de?part=3D14
