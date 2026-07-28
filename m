Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB0B3B7B68
	for <linux-can@vger.kernel.org>; Tue, 28 Jul 2026 06:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785219220; cv=none; b=qnLYhxOxnFo7hz+4Ykpb/sac2KL072OcQIMIwJgYHexg483thNM1Jd/f7EBMigG74379Coq4809mGmuSkzbTQwFYG6IGC2FZfKx+S7kPoEtCYXSIkrvBNqiR5XV664z/yRImzXCq7TmKUW+bDQnFAQ5gBnl67ZbyR4QFn2zC3Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785219220; c=relaxed/simple;
	bh=EYiy1eL3i4uDrBbySOmfojqsGWd5FLD2OrO1/aDFmy8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PqKRY3emmMRhCYTpQ6iUGkJ9tZZAh2E/tAr77Utga6LvTUI6iuUta9Wei0ISKyjUVRXy2ZZ5jkJnG+HDp35aDAa/zONAE4hlGBBwTQiAhLjMh28FEj/zUsPLXsprCWoxg0UV4+ThbWFEmSUffzzHt5RzT3NVqfONOGJjG1IJVuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3v0RzkX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3v0RzkX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6711F000E9;
	Tue, 28 Jul 2026 06:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785219218;
	bh=tjPtufvQjPeqsrWSupXmm4r9ZyKgXUFKvoeFYW0U+4c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k3v0RzkX0HVRd5nGjDqIXPFVpaHd/2aulo76dQ/8hedHGJ7Mp3lxKmZ4kgVqGNe0E
	 Kw00T6lW5GYlcdJHc+wI9tkv2T47mOYoNJRtvFuw5LGjo/pzf2YL0YxCTklS8ayDo8
	 2N05NlZ0Kj2XLnWGL1nXrWaIWEQR1XQAtFMlJIOW3nNprkUX1SZD2rsAEFRlmUKEpc
	 ZYXRYoP6VVfuxTcUVcfM7P2DI8N6Sf13JbqmyHT+Z8EZdewGzR441ZaAYMEco7VhMJ
	 B5O2f9POMS/dKYV34k6+voTRogfYHh9y0mNQv5TN8DSfDSGzDC3YR6/N03RGYg/KLc
	 X+K9jZDiG7ExQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can v1 1/2] can: j1939: use netdevice_tracker for
 j1939_{priv,session,ecu} tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oleksij Rempel" <o.rempel@pengutronix.de>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260728055835.1151785-2-o.rempel@pengutronix.de>
References: <20260728055835.1151785-1-o.rempel@pengutronix.de>
 <20260728055835.1151785-2-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 06:13:38 +0000
Message-Id: <20260728061338.9A6711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] ECU list `priv->ecus` is modified locklessly during concurrent unm=
apping.
--

--- Patch [1]: [PATCH can v1 1/2] can: j1939: use netdevice_tracker for j19=
39_{priv,session,ecu} tracking ---
commit fa6ae711cbc8e468a294fc1a54de5efa19c0b5b3
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

can: j1939: use netdevice_tracker for j1939_{priv,session,ecu} tracking
   =20
This patch enables netdevice_tracker for j1939_priv, j1939_session, and
j1939_ecu structures. It aims to help identify the source of refcount
leaks reported by syzbot during unregister_netdevice().

> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index dc374286eeb6e..cdc3c0a719379 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c
> @@ -20,6 +20,7 @@ static void __j1939_ecu_release(struct kref *kref)
>  	struct j1939_priv *priv =3D ecu->priv;
> =20
>  	list_del(&ecu->list);

[Severity: High]
This is a pre-existing issue, but is it safe to modify priv->ecus here with=
out
holding priv->lock?

If a process unbinds a socket and drops its ECU reference concurrently with=
 the
network receive path processing a packet:

CPU1 (Socket thread)
j1939_local_ecu_put()
  /* drops refcount to 1 */

CPU2 (SoftIRQ)
j1939_ac_recv()
  j1939_ecu_put(ecu); /* locklessly drops final reference */

This leads to __j1939_ecu_release() executing list_del(&ecu->list) and
kfree(ecu) without holding priv->lock.=20

Can this happen concurrently with other threads iterating priv->ecus under
priv->lock, potentially resulting in data races, list corruption, and
use-after-free bugs?

> +	netdev_put(priv->ndev, &ecu->priv_dev_tracker);
>  	kfree(ecu);
>  	j1939_priv_put(priv);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728055835.1151=
785-1-o.rempel@pengutronix.de?part=3D1
