Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBAF476074;
	Tue,  1 Sep 2026 08:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252573; cv=none; b=dTpesL+MY+q+sZbasS4BoIiDIKeQXAOto9xTgeH6FT1xJbBt7amCpfEjbuOX6aETdc+kNJgsoP5W+AbLmoVT8D/skyWOeF1LkFxOtnWpHaURb1fmwbDZd9oJpKurpD8zjJjC3ZKNeWuXLKL9lOZPaZuvewPm24railzx8OALUf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252573; c=relaxed/simple;
	bh=Xyl+z8W3uION4WLwHnP01eQ0JM79vrYj7GF9oqbglH0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z8WWbuYqq7KhsKpmlDkNVEpRZbV1+gl1n6rTuPK3rbsKfbR/vbtYA6ze2p4VDBtcf5wrNi//2YyMX5ToQW5S5QEN++5Tz81Gr+1q89TWmZZrhXI1ISIED5DUNhi6hYSlFgk2uEAd/GUlUJARJ/ND0y10Q+l2gopzIMFKFtQnRUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfsUe1hL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfsUe1hL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB111F00A3D;
	Tue,  1 Sep 2026 08:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788252571;
	bh=jMF3OsMuDbTbk9sfGK2vA6KA7SRVSRFiafEyCsXfkbs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UfsUe1hLZNhKgZNaXqiSlFEEQsj5ozqMa2YRDQCzgheg7vxiPI6/2X1qqwrNgZRDU
	 eelICXURs17SROmwQfds9ck6xLTpotGJzRJMJPuW7h6WC1jVQuUfiGtTWzw/CalNKd
	 Q8HUjN3OvtufDEoGkoM0N7G2UxtMeNNoS4w5QbJODIqL94feHhWoOxHTqE8cZZUXoj
	 mOjZ2QpOl46SCampasuvzJ5BwZ3eBza+68+9ox58pIusxfQ1LTW1VpjzfFkRXpT1n6
	 RIOKDS0nMW+Z91lnhzD6968UgMLSNCkpD7RsOh5WSud4LnGMjkgHnEgUFzDNjpIq+e
	 HkGJJMQ5xc0Sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] can: at91_can: add missing can_rx_offload_del()
 in at91_can_remove()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ciprian Costea" <ciprianmarian.costea@oss.nxp.com>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, imx@lists.linux.dev, Frank.Li@kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org
In-Reply-To: <20260901083927.316283-3-ciprianmarian.costea@oss.nxp.com>
References: <20260901083927.316283-1-ciprianmarian.costea@oss.nxp.com>
 <20260901083927.316283-3-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 08:49:30 +0000
Message-Id: <20260901084931.0AB111F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver ignores the return value of `can_rx_offload_add_timesta=
mp()`, leading to a kernel panic upon allocation failure, and also misses c=
leanup in the probe error path.
--

commit 480793d438a773b528d044a7ee532ec7fbf0bc18
Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

can: at91_can: add missing can_rx_offload_del() in at91_can_remove()

at91_can_probe() sets up rx-offload via can_rx_offload_add_timestamp(),
but at91_can_remove() never calls can_rx_offload_del(). The NAPI
instance added by can_rx_offload_add_timestamp() is therefore never
removed on unbind.

[ ... ]

> diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
> index 58da323f14d7c..3ee908817add8 100644
> --- a/drivers/net/can/at91_can.c
> +++ b/drivers/net/can/at91_can.c
> @@ -1165,6 +1165,8 @@ static void at91_can_remove(struct platform_device =
*pdev)
> =20
>  	unregister_netdev(dev);
> =20
> +	can_rx_offload_del(&priv->offload);
> +

[Severity: High]
This isn't a bug introduced by this patch, but while fixing this missing
cleanup in at91_can_remove(), is there a similar leak in the at91_can_probe=
()
error path?

If register_candev() fails during probe, the exit_free error path is taken
but it misses calling can_rx_offload_del(). Could this leave a dangling NAPI
instance and leak the per-CPU queues?

drivers/net/can/at91_can.c:at91_can_probe() {
	...
	err =3D register_candev(dev);
	if (err) {
		dev_err(&pdev->dev, "registering netdev failed\n");
		goto exit_free;
	}
	...
 exit_free:
	free_candev(dev);
	...
}

Additionally, the return value of can_rx_offload_add_timestamp() in
at91_can_probe() is ignored.

If the allocation fails under memory pressure and returns an error like
-ENOMEM, the probe continues without allocating the per-CPU queues. When a
hardware interrupt eventually fires:

drivers/net/can/dev/rx-offload.c:can_rx_offload_irq_offload_timestamp() {
	...
	irq_queue =3D get_cpu_ptr(offload->skb_irq_queue);
	...
	__skb_queue_add_sort(irq_queue, skb, can_rx_offload_compare);
}

Could this result in passing an uninitialized NULL skb_irq_queue pointer to
get_cpu_ptr(), producing an invalid memory address and causing a fatal page
fault when dereferenced by __skb_queue_add_sort()?

Does at91_can_probe() need to check the return value of
can_rx_offload_add_timestamp() and handle the allocation error?

>  	iounmap(priv->reg_base);
> =20
>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901083927.3162=
83-1-ciprianmarian.costea@oss.nxp.com?part=3D2
