Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0382A3D3CFB
	for <linux-can@vger.kernel.org>; Fri, 31 Jul 2026 08:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785487044; cv=none; b=LjDX7Yk17lnlNI1F0/FaXYJaaz9mLQqAwx9jYTzu2nQhaWU4evcLcFOUZsQJ3CFZcXOHCmP8OkRj8PqxVSl9Sma+F3mTQr1ycOYASL3LKlk0L+RniEipBJhWDVbMdnIeiFF9l3rXBduKRD2yzh0oHET2hZy+YgM7S7I7tcuYA3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785487044; c=relaxed/simple;
	bh=k/Q0miZJ73zJDQSr7B6mN3VgzEAEa8DoECZrad94zk0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UMbfombUuUUOWn+626hYrxISximOcvziQHiAO+j3aNA8JyuBhdPKO0oS4f7P6Ums2fgU9iRyqx44LUil11NON5GU01+l6CBZrVHYmdyMRS3cGdHdgtZHdQh/oDYDkS/2rMdVTdxbh2xtJPTmcYM7YViYQ+/iEV/cRTOiqQFVRTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtRxNl1o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtRxNl1o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC1C1F000E9;
	Fri, 31 Jul 2026 08:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785487041;
	bh=Djfvz1FMyGpFckZ0wkE8hyoKdDHW6GQ+/JBfAuo/lxc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HtRxNl1otBhXrnAMtuxINjbDWRu0Oyow9YoxF7+NV7HuT8fUuQFMoRNaVGpzH43gX
	 YqfstBo+g+hpKgpmdOHtqnT1zRGbPbvO05b7i/0cHudf2wWpSFmkM/0F/zZ2RieQzu
	 6Rjy0Z3C3bhkuiQ/exoUN2v9PVyKtHjxHTATvOI0tBFMCn9leahW/uXz2z/iZcut+j
	 BWF8pA1zmoiqiLBgF7D5tZ214Nez7J0+lcmXOHE1sFyrdP49QHIMuiwYf70KAXXcmn
	 a6h1rSu4sjuOkftchUm13eEOrrimJvpf5vod016ZdygEwJDkCajIHv3qlz5czCSrbU
	 RslxM3Cvn/ncA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] can: dev: can_put_echo_skb(): use
 dev_kfree_skb_any()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>
In-Reply-To: <tencent_3315CDBC0C4402D18844C03C62B01F7ED306@qq.com>
References: <20260731-master-v2-0-204d772f2e36@qq.com>
 <tencent_3315CDBC0C4402D18844C03C62B01F7ED306@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 08:37:21 +0000
Message-Id: <20260731083721.5AC1C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fails to make can_put_echo_skb() completely safe for har=
dware interrupt context because it overlooks the inline helper can_create_e=
cho_skb().
- [High] The out-of-bounds error path in can_put_echo_skb() leaks the SKB.
- [High] Unsafe kfree_skb() usage remains in CAN SKB allocation helpers whi=
ch are explicitly called from hardware interrupt handlers.
- [High] can_dev_dropped_skb() and can_dropped_invalid_skb() use kfree_skb(=
) instead of dev_kfree_skb_any(), risking execution in IRQ-disabled context=
s.
--

--- Patch [1]: [PATCH v2 1/2] can: dev: can_put_echo_skb(): use dev_kfree_s=
kb_any() ---
commit af16d148470d669cda96f722b1dffb79b817c3f9
Author: Cunhao Lu <1579567540@qq.com>

can: dev: can_put_echo_skb(): use dev_kfree_skb_any()

can_put_echo_skb() is a public helper used by CAN drivers, so its callers
do not have a guaranteed IRQ context. kfree_skb() cannot be called from
hardware interrupt context or with hardware interrupts disabled.

Use dev_kfree_skb_any() for the existing skb drop paths so that they are
safe regardless of the caller's IRQ context.

> diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
> index 95fcdc1026f80..d7b5a5d17ff22 100644
> --- a/drivers/net/can/dev/skb.c
> +++ b/drivers/net/can/dev/skb.c

[Severity: High]
This isn't a bug introduced by this patch, but does the out-of-bounds error
path in can_put_echo_skb() leak the SKB?

If the bounds check fails, the function logs a BUG and returns without=20
freeing the skb:

drivers/net/can/dev/skb.c:can_put_echo_skb() {
    if (idx >=3D priv->echo_skb_max) {
        netdev_err(dev, "%s: BUG! ...\n", __func__, idx, priv->echo_skb_max=
);
        return -EINVAL;
    }
    ...
}

Many CAN driver callers assume can_put_echo_skb() takes ownership of the skb
and frees it on error. Does this lead to a memory leak when the bounds check
fails?

> @@ -62,7 +62,7 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_de=
vice *dev,
>  	    (skb->protocol !=3D htons(ETH_P_CAN) &&
>  	     skb->protocol !=3D htons(ETH_P_CANFD) &&
>  	     skb->protocol !=3D htons(ETH_P_CANXL))) {
> -		kfree_skb(skb);
> +		dev_kfree_skb_any(skb);
>  		return 0;
>  	}
> =20

[Severity: High]
This is a pre-existing issue, but does this patch fail to make=20
can_put_echo_skb() completely safe for hardware interrupt context?

While dev_kfree_skb_any() is now used in the direct drop paths, the main=20
execution path calls the inline helper can_create_echo_skb():

drivers/net/can/dev/skb.c:can_put_echo_skb() {
    ...
    if (!priv->echo_skb[idx]) {
        skb =3D can_create_echo_skb(skb);
    ...
}

can_create_echo_skb() continues to invoke kfree_skb() on allocation failure
and consume_skb() on success:

include/linux/can/skb.h:can_create_echo_skb() {
    ...
    kfree_skb(skb);
    ...
    consume_skb(skb);
    ...
}

Since both are unsafe to call from hardirq context or with interrupts
disabled, does this defeat the purpose of the patch?

> @@ -90,7 +90,7 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_de=
vice *dev,
>  	} else {
>  		/* locking problem with netif_stop_queue() ?? */
>  		netdev_err(dev, "%s: BUG! echo_skb %d is occupied!\n", __func__, idx);
> -		kfree_skb(skb);
> +		dev_kfree_skb_any(skb);
>  		return -EBUSY;
>  	}
> =20

[Severity: High]
This is a pre-existing issue, but do can_dev_dropped_skb() and=20
can_dropped_invalid_skb() still risk execution in IRQ-disabled contexts?

These functions are called in the exact same ndo_start_xmit paths, right
before can_put_echo_skb(), and they still invoke kfree_skb() on their drop
paths:

include/linux/can/dev.h:can_dev_dropped_skb() {
    ...
invalid_skb:
    kfree_skb(skb);
    dev->stats.tx_dropped++;
    return true;
}

drivers/net/can/dev/skb.c:can_dropped_invalid_skb() {
    ...
inval_skb:
    kfree_skb(skb);
    dev->stats.tx_dropped++;
    return true;
}

This leaves the system vulnerable to the same crashes this patch attempts to
resolve.

[Severity: High]
This isn't a bug introduced by this patch, but do unsafe kfree_skb() calls
remain in CAN SKB allocation helpers that run in hardware interrupt handler=
s?

CAN drivers use alloc_can_skb(), alloc_canfd_skb(), and alloc_canxl_skb() i=
n=20
their RX paths, which often run in hardirq context. If memory allocation for
the CAN SKB extension fails in can_skb_ext_add(), these helpers drop the
allocated SKB using kfree_skb():

drivers/net/can/dev/skb.c:alloc_can_skb() {
    ...
    if (!csx) {
        kfree_skb(skb);
        goto out_error_cc;
    }
    ...
}

Calling kfree_skb() in hardirq context is strictly forbidden and can trigger
warnings or panics. Should these also be updated to use dev_kfree_skb_any()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-master-v2-=
0-204d772f2e36@qq.com?part=3D1
