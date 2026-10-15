Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B1C4A13AF
	for <linux-can@vger.kernel.org>; Thu, 15 Oct 2026 06:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792046843; cv=none; b=mz3kAKJ7sxTZ1BxThgjRRxDRzC55v65wNzj1MYbsJP/ZfAzkq+fwiumYbpdjuMmTOYE7snyJVjxOpsb1DXlC0YzmJp0gt3VdKSIVHav881iPJ3eJY1HM5oNvt/gZe64NrJBKs3Fw4kaGOGGL2UeywP5PRAS3pB9X/YaDgs2OtoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792046843; c=relaxed/simple;
	bh=+XiP5SYNLz+V9WO9ur7oMJE2Qj9JuKkUhaZS7PPy3Zo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=iNS33GNuFMiWDmLUfIHDTx75/pNuvvVRVfiOgK87hue2iprUfwXTvA569OBEScxdIw8eIQFsVtwR7QtwATwlvoRZtbRQ6tRb3mglK5ltvP3QN9k3mxkG0VHx0194nyDeFIjJAgiJIgqouN4zzFWKH5XwEBe3vZDmdoFZ1B9OysA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aL7PmSVy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aL7PmSVy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A4F1F000C4;
	Thu, 15 Oct 2026 06:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792046841;
	bh=NNeBHzCa1Ye1ADTPUmXly0iRpCKB0yRbcbicVty3/ZI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aL7PmSVynshr6MY8NCcLoAmizXCTIp2wptk1pWAd1XkkTApWTDT/A94jqFglV4NX5
	 whsH5CfqbRYI+xk+3E1NRrKdTgy+kxKvDnh3j66NgBJGz6GcK8rvojosbxCAVe5x71
	 abLMGSYzxKTjztseoEkk4q1ZFUKEBEJAOcqC9VC0N5I9p30pY+leP4S4oV/biBk+2X
	 kWT3NDogJtR1STbWRR9eepFFwb9hGc2P8zpRMP4fQ29zBX9o/ojT30CkH01HJdLLFj
	 sInrfpNK0efLkWJJuAVSS4Z3z9yLIC4T8r+/Ywc4YvVAFie4niBZHbmugf4nZUnF6r
	 jnkTtJn/rHMtQ==
Message-ID: <sashiko-outbox-172364@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can] can: j1939: don't drop the last ECU reference
 without priv->lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Patrick Dahlke" <me@patrickdahlke.com>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261015-j1939-ecu-release-lock-v1-1-39dcb8a0f2f9@patrickdahlke.com>
References: <20261015-j1939-ecu-release-lock-v1-1-39dcb8a0f2f9@patrickdahlke.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 06:47:20 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] can/j1939: UAF of priv->lock in j1939_ecu_timer_handler()
--

commit e395c3132226e329efed25775c10d329a0724203
Author: Patrick Dahlke <me@patrickdahlke.com>

can: j1939: don't drop the last ECU reference without priv->lock

struct j1939_ecu objects are linked into priv->ecus, which is protected
by priv->lock. __j1939_ecu_release() unlinks the ECU with list_del(), so
the final j1939_ecu_put() must happen with priv->lock held for writing.

[ ... ]

> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index cdc3c0a719379..ec8ee0f980fb4 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c
> @@ -19,6 +19,11 @@ static void __j1939_ecu_release(struct kref *kref)
>  	struct j1939_ecu *ecu =3D container_of(kref, struct j1939_ecu, kref);
>  	struct j1939_priv *priv =3D ecu->priv;
> =20
> +	/* priv->ecus is protected by priv->lock, so the last reference
> +	 * must only be dropped with priv->lock held for writing.
> +	 */
> +	lockdep_assert_held_write(&priv->lock);
> +
>  	list_del(&ecu->list);
>  	netdev_put(priv->ndev, &ecu->priv_dev_tracker);
>  	kfree(ecu);
>  	j1939_priv_put(priv);
>  }

[Severity: High]
Does enforcing this pattern cause a use-after-free of priv->lock?

If j1939_priv_put() drops the last reference to priv, it will free priv whi=
le
priv->lock is still held by the caller of j1939_ecu_put().

For example, the asynchronous j1939_ecu_timer_handler() executes with
write_lock_bh(&priv->lock) held, but does not hold an independent reference
to priv, relying solely on ecu->priv:

net/can/j1939/bus.c:j1939_ecu_timer_handler() {
    ...
	write_lock_bh(&priv->lock);
	...
	j1939_ecu_put(ecu);
	write_unlock_bh(&priv->lock);
    ...
}

If the network interface is down and all sockets are closed, dropping the
final ECU reference in j1939_ecu_put() invokes __j1939_ecu_release(). This
drops the ECU's reference to priv, freeing priv and priv->lock before
j1939_ecu_timer_handler() calls write_unlock_bh(&priv->lock).

Can this use-after-free be avoided by taking an explicit reference to priv
before dropping the ECU, or deferring j1939_priv_put() outside the lock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-j1939-ecu-=
release-lock-v1-1-39dcb8a0f2f9@patrickdahlke.com?part=3D1
