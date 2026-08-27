Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09473F1048;
	Thu, 27 Aug 2026 19:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787859850; cv=none; b=Q/sfvcHIUzmarPiolE/GHqXr1ut/vK0Y1i/7+TUpN0LTJ4uHtPqWNkcqukql/JfYnZCDDbV7Yl8mc3p7Mj8cyz19d4aZWbs98Ru889k5tH/QNA5B+2N9sGqnoqgZN/01a2uDvu6cDGGxRT5AWJwSadXnumSFrZNgMKGbgdp0dgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787859850; c=relaxed/simple;
	bh=n32Qlo4L45srtPya355Y6fLhtB+KRyjW284H9D4TYC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFDVWbNNupSNH1bt88T++J5ZSj9dUbF0JxOGEZall53dukwxnIjLHEwX1OHetsq7TwuXWYTB+x8mQ2eMfueSYlWYM0yltyi/Ruu5LEPw31m5ePUR4wDm+Mexp9Hf+obFGBso3sTbUERrEe+BbADyaT2UWN2xDEmPhb5pr2JfsEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWEOKx18; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWEOKx18"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4877D1F000E9;
	Thu, 27 Aug 2026 19:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787859848;
	bh=tDItCvpQjvDZXrWuwzycSQXkJDT+b5MMWRd5CiXGxCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fWEOKx18u1F111jB5OHX8dVWV989vbt13UOSUxzbybaGLvAKeBGmeyNNR2cuS9ZV3
	 UG+DaNU7+PHEbkQr0tbxsB1gEkKbPamOJbrXMesziVqMKfkboYfUtEGC4aMzNAkkWL
	 GhzUwBsAfEMtCompaeQgR56xJ0tIE3mO9dfG2NZRFX/aVnf+zlBSwdDRVbF9nmc2NY
	 ts1UGq/8qr6gWJXGVNF3u9Dr/ZUJ0jWLQbJ5qUUl4QKDs5S7xQ3acKM6pdQzW8OC3A
	 5Jc2On6oxAzGevMWSQATfAiRhh6ZBDa0Au7I3wbwDbLl47Qt9DYhHCNKpcd8caU5EU
	 RRmtDXOk4426g==
From: Jakub Kicinski <kuba@kernel.org>
To: mkl@pengutronix.de
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	blbllhy@gmail.com,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu
Subject: Re: [PATCH net 03/14] can: bittiming: fix divide-by-zero in can_calc_bittiming()
Date: Thu, 27 Aug 2026 12:44:07 -0700
Message-ID: <20260827194407.4023691-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826121036.2706424-4-mkl@pengutronix.de>
References: <20260826121036.2706424-4-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
can: bittiming: fix divide-by-zero in can_calc_bittiming()

can_calc_bittiming() computed the prescaler as priv->clock.freq /
(tsegall * bt->bitrate), where the product is a 32 bit multiplication that
wraps to zero for large userspace supplied bitrates. The fix computes the
product with mul_u32_u32() and divides with div64_u64().

Link: https://patch.msgid.link/20260803091426.29050-2-ssureshmsd7@gmail.com

> diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
> index 42498e9d3f38d..4809f5e0c96e9 100644
> --- a/drivers/net/can/dev/calc_bittiming.c
> +++ b/drivers/net/can/dev/calc_bittiming.c
> @@ -119,8 +119,12 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
>  	     tseg >= (btc->tseg1_min + btc->tseg2_min) * 2; tseg--) {
>  		tsegall = CAN_SYNC_SEG + tseg / 2;
>  
> -		/* Compute all possible tseg choices (tseg=tseg1+tseg2) */
> -		brp = priv->clock.freq / (tsegall * bt->bitrate) + tseg % 2;
> +		/* Compute all possible tseg choices (tseg=tseg1+tseg2).
> +		 * A 32 bit tsegall * bt->bitrate can wrap to zero for large
> +		 * userspace bitrates, so compute the product in 64 bit.
> +		 */
> +		brp = div64_u64(priv->clock.freq,
> +				mul_u32_u32(tsegall, bt->bitrate)) + tseg % 2;
>  
>  		/* choose brp step which is possible in system */
>  		brp = (brp / btc->brp_inc) * btc->brp_inc;

[Severity: High]

This is a pre-existing issue and not something introduced by this patch, but
can the same input class the commit message describes still end in a divide
error two statements later?

With the 64 bit product, a bitrate large enough that clock.freq is smaller
than tsegall * bt->bitrate now yields brp == 0 for even tseg (tseg % 2 == 0)
instead of faulting in the patched expression. The only thing that stops
brp == 0 from reaching the next division is the range guard:

drivers/net/can/dev/calc_bittiming.c:can_calc_bittiming() {
	...
	brp = (brp / btc->brp_inc) * btc->brp_inc;
	if (brp < btc->brp_min || brp > btc->brp_max)
		continue;

	bitrate = priv->clock.freq / (brp * tsegall);
	...
}

so it relies on btc->brp_min being at least 1, and the first of those two
statements relies on btc->brp_inc being non-zero.

Are those two fields validated anywhere in the core? The only core
validator of struct can_bittiming_const, can_bittiming_const_valid() in
drivers/net/can/dev/dev.c called from register_candev(), only rejects a
zero sjw_max:

drivers/net/can/dev/dev.c:can_bittiming_const_valid() {
	if (!btc)
		return true;

	if (!btc->sjw_max)
		return false;

	return true;
}

All statically initialised in-tree constants use brp_min = 1 and
brp_inc >= 1, but gs_make_candev() in drivers/net/can/usb/gs_usb.c fills
the struct from a device reply without any range check:

	dev->bt_const.brp_min = le32_to_cpu(bt_const.brp_min);
	dev->bt_const.brp_max = le32_to_cpu(bt_const.brp_max);
	dev->bt_const.brp_inc = le32_to_cpu(bt_const.brp_inc);

and the identical copy of bt_const_extended.dbrp_* into
dev->data_bt_const for the CAN FD data const. Both are then handed to
can_calc_bittiming() through can_changelink() -> can_get_bittiming(),
which is entered when bt->bitrate is set and bt->tq is 0.

For a device reporting brp_inc == 0, does brp / btc->brp_inc fault on the
first loop iteration for any bitrate? And for a device reporting
brp_min == 0 with a small fclk_can, does the freq / (brp * tsegall)
division fault with brp == 0 for the same wrapping-class bitrate this
patch targets?

Since can_changelink() runs with rtnl_lock held, would the resulting oops
leave rtnl_lock held permanently? Would it make sense to extend
can_bittiming_const_valid() to also reject brp_inc == 0 and brp_min == 0,
or to add a brp check before those divisions?
