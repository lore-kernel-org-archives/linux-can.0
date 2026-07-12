Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F4D376BE0
	for <linux-can@vger.kernel.org>; Sun, 12 Jul 2026 21:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783892064; cv=none; b=MZvv29+D/+NBquIy1KGSjk0oASPSq/jjqsxWvKnc8RHuAZvAueEhgQ4UgDkheYGcsbLqylNvDp99gNzcRMRXuDHgv2O9p1pDkIb1ynCAcKD8Gpl1Qu2I9BL14EFGeZH5TpTYv590hkShpxxXq6DJE6nUnIEprnnwGjlmHv2Sw5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783892064; c=relaxed/simple;
	bh=691QnKVCikUEeOzK2iPober+r8rx1L+vF3+ElTFwI+Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=efzbYNA5Ack+mL5KcdUYNOnRepmWp/DNa1jFEoUKpeec4epNGwlBcJ7lapvuea8poyV2407pO73BZ163or3lh7YBZQyczxb5ftMWGhrUz/yggcoG4A/1b4YDfHMV0sGFKBpYgu0c/zg2W60TicfxFM6ql4rMsKDAzsJ2/UgG+Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5F4Wnev; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5F4Wnev"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1111F000E9;
	Sun, 12 Jul 2026 21:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783892063;
	bh=oZMBOvaH9k5qv9bXtn7fmBZR0CqLKKeItlVHzx3NEts=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J5F4WnevB07QH47IAopn1kazdsfpSym1xKXR1kPDUJpNH26FPV6GqglRrYbpJdxvQ
	 0Hr2D901kIq5hJqsUhTV7i8Ei1+nRloG5OZDPmrFlwwceae6lOKIZ1XLI+yhhZf0xg
	 GegLXoSRcaG2Q8PjagRw6BZLkJTA4C/ZmzhLzUV3soGNNKOD/9K/9Qd9HNdD4SEr3s
	 o0NMCoVEb8r7iYFouaX/IDZRox2RGQmutOr2IKezVSk1vTpbkpgSsF817R1e3EwO9L
	 THK6gFauMcJP0hZgQKrZ+GsKgOb37EDsE66UR4cCSkA3aqO1ICsnsVfVKArWVdXZH9
	 uMzBUacee77dA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] vxcan: Support per-netns device unregistration.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260712212113.181121-1-kuniyu@google.com>
References: <20260712212113.181121-1-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 21:34:22 +0000
Message-Id: <20260712213422.DB1111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch calls the undefined function `unregister_netdevice_queue_=
net()`, resulting in a compilation error.
--

--- Patch [1]: [PATCH v1] vxcan: Support per-netns device unregistration. -=
--
commit 882fcd31630d9ce6b0a57cc99738c2ad0579763f
Author: Kuniyuki Iwashima <kuniyu@google.com>

vxcan: Support per-netns device unregistration.

This commit updates vxcan_dellink() to unregister local and peer devices
safely across different namespaces by using xchg(). The change aims to
prevent double-queuing of device destruction when RTNL is removed.

> diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
> --- a/drivers/net/can/vxcan.c
> +++ b/drivers/net/can/vxcan.c

[ ... ]

> @@ -281,24 +284,25 @@ static int vxcan_newlink(struct net_device *dev,
> =20
>  static void vxcan_dellink(struct net_device *dev, struct list_head *head)
>  {

[ ... ]

>  	unregister_netdevice_queue(dev, head);
> =20
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
Is this missing a prerequisite patch? It appears that
unregister_netdevice_queue_net() is not defined anywhere in the kernel
tree, which leads to a compilation error when building vxcan.c.

> +
> +	netdev_put(peer, peer_tracker);
> +	netdev_put(dev, &priv->peer_tracker);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712212113.1811=
21-1-kuniyu@google.com?part=3D1
