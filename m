Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467FA489896
	for <linux-can@vger.kernel.org>; Fri, 31 Jul 2026 23:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785540698; cv=none; b=NsFBJFM7r+wnSmIASQ0DzPMkRv1Ldcbcp//phjuSI9PufRJS/8vkJRO/zPbzgRjJM3Ys87/0dlhJ93Fv9XCJGMZBJgGiCrAYgiiFbrQxtoczp/wIVBQo+VyakVuwTqp84i2xlvMF39J+LHBi6EMMjxWWWWGfMYQjnciGLYNsL3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785540698; c=relaxed/simple;
	bh=mIFlQcMBUi/lUJ7A3yTk7CWmUJgNFj+pF1Bhby3AyCA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JrDsOJBbU3YemCk9C8tI4S7swwY7s4D2PWO3Km0sBXK2idAaYjtLaE8+CKGCcpN6dIBcqpTU8emvvKEW7jKvmZgoTgTCXwatIjhKtdNEaVk4ZT3K/S6qsQuvmGAXCiDzJB/yUe8KLWEMdq10MRbJ3D1Y7VZwBZC6aiOZOeH+q1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAvl62Dt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAvl62Dt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A908F1F00AC4;
	Fri, 31 Jul 2026 23:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785540696;
	bh=p6d/xjDFQciklIdxpG5mFvh4cg91K1ENRZy9Cg2dHE0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RAvl62Dt2iDr7xZHCEvYor4WeZ165k9fI+GWmJYVO8zWCPbnUzoDD0quDmBG95bUd
	 kUcHpLJJSgasNYkO/vuhsXKK+IHBdQdPedp6zQykg9oGeBHeLyp2zmBVzlItyWho78
	 gO1+CK0qZqQYLApJNxRGJwb+AeFMePZXiI5l6L8CdDH8TuyOKDXVYSAzgHXHCvC+h5
	 5448QHWo2gMVC8s1nkKudXbH+gl/3TNLLZX8lHkQKV5vZhWfvua3Q/v3/8YY9hRKFk
	 wwx5uyU+bhVdD0CHkvFCnWaBlsX6GdahmNUa6npKh/TXLaQUXcbdLIotIf59ju0fu7
	 8FwB6HDkTB56w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v1] vxcan: Support per-netns device
 unregistration.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260731231755.2474376-1-kuniyu@google.com>
References: <20260731231755.2474376-1-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 23:31:36 +0000
Message-Id: <20260731233136.A908F1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch calls a non-existent function `unregister_netdevice_queue=
_net()`, causing a build failure.
--

--- Patch [1]: [PATCH RESEND v1] vxcan: Support per-netns device unregistra=
tion. ---
commit aa743c4ffeab7ce1e07d36aa7e401187541f6f4f
Author: Kuniyuki Iwashima <kuniyu@google.com>

vxcan: Support per-netns device unregistration.

This commit modifies vxcan_dellink() to support concurrent per-netns device
unregistration by using xchg() to ensure each device is queued for
destruction only once. It drops the synchronous RTNL assumption for deleting
both the local and peer devices.

> diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
> index e882250180ef6..b7efed1226d88 100644
> --- a/drivers/net/can/vxcan.c
> +++ b/drivers/net/can/vxcan.c
[ ... ]
> @@ -281,24 +284,25 @@ static int vxcan_newlink(struct net_device *dev,
> =20
>  static void vxcan_dellink(struct net_device *dev, struct list_head *head)
>  {
[ ... ]
> -	if (peer) {
> -		priv =3D netdev_priv(peer);
> -		RCU_INIT_POINTER(priv->peer, NULL);
> -		unregister_netdevice_queue(peer, head);
> -	}
> +	priv =3D netdev_priv(peer);
> +	dev =3D unrcu_pointer(xchg(&priv->peer, NULL));
> +	if (dev)
> +		unregister_netdevice_queue_net(dev_net(dev), peer, head);

[Severity: Low]
Does unregister_netdevice_queue_net() exist in the source tree? It appears
this will cause a build failure due to an undefined function reference when
the driver is compiled.

> +
> +	netdev_put(peer, peer_tracker);
> +	netdev_put(dev, &priv->peer_tracker);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731231755.2474=
376-1-kuniyu@google.com?part=3D1
