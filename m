Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE5F442B0A
	for <linux-can@vger.kernel.org>; Thu, 27 Aug 2026 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787832653; cv=none; b=lRZWLw0mOgv1oesH+CKJh9DqlW4Y2dSSWCrwueVNtKwLeKFRfSHN/9a5hY+HIeKNYH/k3cMRXYRLvxbNUCC79uJF3Z4Bxsxfpcp6p+1SgAdU47hD1COhQoV/gxmYa9F1GY6tnNCVorpNMK0oK0GH0Z9ZWlYJQ2gjAf/tjJVBe1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787832653; c=relaxed/simple;
	bh=oJGIDzSm5Q52MgJbSI5dJXBCRTIqXfKkOjqmId/Y6n0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u0GHo6mEYVjHSPPmSJN6Fu4z0P8DSI4FW9tIY1HvAnxkwz/ZZKyedM4qLgMTp6O5geMuHSdjsE5p69nd6fu3nG1+jsc2/S5X9xawkIcnVndy31dn3JtBurCziL5ftCtU87TqQ33YbYX9wIJnxP7nzxu+dRN2FtBnvF7xkK6j0bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGY5eqF3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGY5eqF3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68D91F00A3A;
	Thu, 27 Aug 2026 12:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787832652;
	bh=lhM5Ybx7JgLBlqEahhAb5E2YUvCldULwQ7pjC0HO9i8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kGY5eqF38cURAZ5Q/yJ/fG9M6WQNixVKwjTFlSkpAmYwwxlFDjwrM+wTNbDQWu5H9
	 LQ7IJbhr24aGTA4edQK23bT+TMXbTQi2iMlrZ2Cne4Vtzi9Wd33FBUQS5PpfsKnuM1
	 66ZxpwkwJtYZs6DYp4QDQL1NYtO19yVzHljzPgIoWlnK1raWNJn3dRDJ99SUMpdIww
	 SajKUesa5uV/njeVdHVwevFEcP5iKm8wuvMYMKAykx6vYEo6N1VSK8HB/ZJJsIWUJ2
	 PA2dQVE5mZp1BEWiul/L7f4hV+3FWXsPKBtyHnuyII5XAY2uJMGmEsKr2JeJ3149gf
	 Jny3ekUU3bVmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 08/14] can: skb: make echo skb freeing safe in any
 IRQ context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260826121036.2706424-9-mkl@pengutronix.de>
References: <20260826121036.2706424-1-mkl@pengutronix.de>
 <20260826121036.2706424-9-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 12:10:51 +0000
Message-Id: <20260827121051.A68D91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unsafe kfree_skb() call in SKB validation drop paths from hardirq =
disabled context.
--

commit e51772559e06a8eadc0f2ac2b7cdadfcaeb3e18b
Author: Cunhao Lu <1579567540@qq.com>

can: skb: make echo skb freeing safe in any IRQ context

can_put_echo_skb() can be called with hardware interrupts disabled. Its
direct drop paths use kfree_skb(), while can_create_echo_skb() uses
kfree_skb() when cloning fails and consume_skb() after a successful clone.
None of these helpers is safe in every IRQ context.

Link: https://patch.msgid.link/tencent_E84809CF236D0137885E7E4E4D58340B3208=
@qq.com

> diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
> index 4f7a189de265d..0ed8057a3cb2c 100644
> --- a/drivers/net/can/dev/skb.c
> +++ b/drivers/net/can/dev/skb.c
> @@ -63,7 +63,7 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_de=
vice *dev,
>  	    (skb->protocol !=3D htons(ETH_P_CAN) &&
>  	     skb->protocol !=3D htons(ETH_P_CANFD) &&
>  	     skb->protocol !=3D htons(ETH_P_CANXL))) {
> -		kfree_skb(skb);
> +		dev_kfree_skb_any(skb);
>  		return 0;
>  	}
> =20
> @@ -91,7 +91,7 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_de=
vice *dev,
>  	} else {
>  		/* locking problem with netif_stop_queue() ?? */
>  		netdev_err(dev, "%s: BUG! echo_skb %d is occupied!\n", __func__, idx);
> -		kfree_skb(skb);
> +		dev_kfree_skb_any(skb);
>  		return -EBUSY;
>  	}
> =20
> diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
> index a70a029670711..78c5870e2f9a2 100644
> --- a/include/linux/can/skb.h
> +++ b/include/linux/can/skb.h
> @@ -76,12 +76,12 @@ static inline struct sk_buff *can_create_echo_skb(str=
uct sk_buff *skb)
> =20
>  	nskb =3D skb_clone(skb, GFP_ATOMIC);
>  	if (unlikely(!nskb)) {
> -		kfree_skb(skb);
> +		dev_kfree_skb_any(skb);
>  		return NULL;
>  	}
> =20
>  	can_skb_set_owner(nskb, skb->sk);
> -	consume_skb(skb);
> +	dev_consume_skb_any(skb);
>  	return nskb;
>  }

[Severity: High]
This is a pre-existing issue, but since this patch fixes context violations
in can_put_echo_skb() (which is called from ndo_start_xmit with hardirqs
disabled, e.g. via netpoll), does it make sense to fix the identical
violations in the adjacent CAN drop paths?

When a CAN driver's ndo_start_xmit rejects an invalid packet, it calls
can_dev_dropped_skb(), which still uses the IRQ-unsafe kfree_skb():

include/linux/can/dev.h:can_dev_dropped_skb() {
    ...
invalid_skb:
	kfree_skb(skb);
	dev->stats.tx_dropped++;
	return true;
}

Similarly, can_dropped_invalid_skb() drops invalid SKBs using kfree_skb(),
which can trigger a kernel oops or context warning if called when hardirqs
are disabled:

drivers/net/can/dev/skb.c:can_dropped_invalid_skb() {
    ...
inval_skb:
	kfree_skb(skb);
	dev->stats.tx_dropped++;
	return true;
}

Can these pre-existing drop paths also be updated to use dev_kfree_skb_any()
to prevent crashes when malformed packets are transmitted while netpoll is
active?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826121036.2706=
424-1-mkl@pengutronix.de?part=3D8
