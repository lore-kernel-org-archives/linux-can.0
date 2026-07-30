Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852033B6352
	for <linux-can@vger.kernel.org>; Thu, 30 Jul 2026 15:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785424700; cv=none; b=WILq7IlGzZvdWveRE2FgH9yuZ1fQQCfJ/eK2WudzXzQTBpT/3XIqIdwWbDlaJcSFneXaeFDUFbmWF7BtcGt94o+MfgEjtOH4c7GQcdQuYHr2Eacf2b4ejXoAOsLvPH92C0Wh/7cEOX4amjdZFrWhs7DXVlWvwohYIpe9naYLMMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785424700; c=relaxed/simple;
	bh=FI+gkWK+xRk/tW3O6vNuWpr+eNNJnmO0NmfYd5wmfNU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vAWHPmsc15bvtzIpPN5up39B07Q7jVooNQ/GXNl0HI1ioeLaIqtCMynmOxPfNGHfp08eJohbGNDFkCSArY5pyLlBRwW5AbHhDm1Z1RjZtND4Ag06HduBn9+e5zB6Gx4BBwA9dt1UJL12mFphTK2qkVKSVUORwOQ7BBjxXZWWAeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNqLir1x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNqLir1x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBFF1F000E9;
	Thu, 30 Jul 2026 15:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785424699;
	bh=7JQdoQ6FAPYyxAihvYqLT6VIQWmwkYRH0q8PcUSLGsk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dNqLir1x74wmWxV0ahfkZt3sSV37KvMUSGgJk+guToT9hMMvH3wOuCdp8Rd1oH2hG
	 L/Bf+YF0C2tMizesOBjjwYyt4H69gnVe5Ay24bPL2wUX4hhZd2yWE2fxR1g0E+rKfz
	 UE8zdmYwVMXvrTsON579mvjolcezI74UC2VRnRs04sAtaeXo/X+yguGcHCbBuuztnf
	 SgVvqO/T3xjlfRBUixZRXnjW/WpyPdTbLRFqWLJIgachovsoKB+t7ETHuzL1VYccgL
	 dOIpXOQy4Kg28gJGwHQfI+yK6F6o4NnYmrWhJS+UWK/Tn3sgmioBmqxcaRVfjI0Uyb
	 unOv5Hi3T8x+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: dev: can_put_echo_skb(): free skb on invalid echo
 index
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: linux-can@vger.kernel.org, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <tencent_944DADCC4B42C8484EC01DA2B15F42132906@qq.com>
References: <tencent_944DADCC4B42C8484EC01DA2B15F42132906@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 15:18:18 +0000
Message-Id: <20260730151819.0FBFF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Context-unsafe SKB free in can_put_echo_skb()
--

--- Patch [1]: [PATCH] can: dev: can_put_echo_skb(): free skb on invalid ec=
ho index ---
commit ab12134887377b0b69b9ab5b16cf5eb0ddf3eb9e
Author: Cunhao Lu <1579567540@qq.com>

can: dev: can_put_echo_skb(): free skb on invalid echo index

This commit fixes a memory leak in can_put_echo_skb() by ensuring the skb is
freed when the echo index is out of bounds. It adds a kfree_skb() call to
the -EINVAL error path.

Cc: stable@vger.kernel.org

> diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
> index 95fcdc1026f80..44ebeba998370 100644
> --- a/drivers/net/can/dev/skb.c
> +++ b/drivers/net/can/dev/skb.c
> @@ -54,6 +54,7 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_de=
vice *dev,
>  	if (idx >=3D priv->echo_skb_max) {
>  		netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of b=
ounds (%u/max %u)\n",
>  			   __func__, idx, priv->echo_skb_max);
> +		kfree_skb(skb);

[Severity: High]
This is a pre-existing issue in the surrounding code, but does adding anoth=
er
kfree_skb() here introduce an unsafe free context?

Since can_put_echo_skb() is commonly called from the ndo_start_xmit path of
CAN drivers while holding an irqsave spinlock (such as in
peak_canfd_start_xmit()), hardware interrupts may be disabled.

Calling kfree_skb() with interrupts disabled can be unsafe because SKB
destructors like sock_wfree() might assume they are in process or softirq
context, potentially leading to lockups or warnings.

Would it be safer to use dev_kfree_skb_any() here, and possibly update the
other pre-existing kfree_skb() and consume_skb() calls in this function as
well?

>  		return -EINVAL;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_944DADCC4B4=
2C8484EC01DA2B15F42132906@qq.com?part=3D1
