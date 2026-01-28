Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF16330BF62;
	Wed, 28 Jan 2026 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616770; cv=none; b=qGh43+9KxHgWlyCHNCXwn4JbEZVsMRNZPzWo8CzVyDSE+PZDQD9YBIWT+pqRGbzDCnlgKslvEmygQx9zhPhzv+fp58anVhxaZZIXOEoyWDR+a1tfPTSany5cVFeuaHXY2KfgtXxP2InJnN7c4D4z7U+Ed54WxEoOX2+l9+Sus8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616770; c=relaxed/simple;
	bh=RY3qAsVcNZgpoiISW6qqyX22sBbpspvcb2T1OfaTkac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BOsI88Vg40c87m5LBMkRBbyjQM4JYZBhm3d9CdFv8y/Cgs6ITKf51cuzY3xu+wc1Y+BBZ68aO1+ROd7sPtnEhAQ/PJmOsgZra5mdRG0F0GkoyvYhUGybEwJAPwkWpFHEtUu3iN5B3qK0ESfdSQpiDZdDVV0eT2mqoZ8Zc39Juag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuYeKPP5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuYeKPP5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBB0C4CEF1;
	Wed, 28 Jan 2026 16:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769616770;
	bh=RY3qAsVcNZgpoiISW6qqyX22sBbpspvcb2T1OfaTkac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XuYeKPP5MISQ0E0m1nR1aAmezIUro+y/rIaZpL804TuLqHC2zMvr2BtS6T/LzHaMx
	 QO6f6CIB9ddOrKPNnt3YDlRTd3R1FpNvNd5D+FQ0O2Ov8h01rS0YzM7sRFZmMzQL6i
	 5I81sl7piFSE+YRUz9vuYtFCDe7VIPuv1rMBC6M0HKHmRkE/3VCJysa3no4e3ODuty
	 fr2HrsokqreDaqk/2XUy6dNmdDU//nqK73RSn8Zyh5tNzP1VSprDHnmvdZ8pePUBeV
	 3PTW7K6DuVxDbD9OAmOlJw2o44bpYa+3leXpLtuq7GzTj6cVVFZSiOjveNx12g7F6w
	 71dYSjIDMclyA==
From: Jakub Kicinski <kuba@kernel.org>
To: mkl@pengutronix.de
Cc: Jakub Kicinski <kuba@kernel.org>,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kernel@pengutronix.de,
	mailhol@kernel.org,
	socketcan@hartkopp.net,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	robin@protonic.nl,
	o.rempel@pengutronix.de
Subject: Re: [can-next,v2,6/6] can: gw: use can_gw_hops instead of sk_buff::csum_start
Date: Wed, 28 Jan 2026 08:12:48 -0800
Message-ID: <20260128161248.40799-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128-can-skb-ext-v2-6-fe64aa152c8a@pengutronix.de>
References: <20260128-can-skb-ext-v2-6-fe64aa152c8a@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
can: gw: use can_gw_hops instead of sk_buff::csum_start

This patch moves the hop counter storage from skb->csum_start to the CAN
skb extension field can_skb_ext::can_gw_hops.

> diff --git a/net/can/gw.c b/net/can/gw.c
> index ad89a1913b34..2c134c9e5159 100644
> --- a/net/can/gw.c
> +++ b/net/can/gw.c

[ ... ]

> @@ -480,19 +480,8 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
>  	/* Do not handle CAN frames routed more than 'max_hops' times.
>  	 * In general we should never catch this delimiter which is intended
>  	 * to cover a misconfiguration protection (e.g. circular CAN routes).
> -	 *
> -	 * The Controller Area Network controllers only accept CAN frames with
> -	 * correct CRCs - which are not visible in the controller registers.
> -	 * According to skbuff.h documentation the csum_start element for IP
> -	 * checksums is undefined/unused when ip_summed == CHECKSUM_UNNECESSARY.
> -	 * Only CAN skbs can be processed here which already have this property.
>  	 */
> -
> -#define cgw_hops(skb) ((skb)->csum_start)
> -
> -	BUG_ON(skb->ip_summed != CHECKSUM_UNNECESSARY);
> -
> -	if (cgw_hops(skb) >= max_hops) {
> +	if (csx->can_gw_hops >= max_hops) {
            ^^^^^^^^^^^^^^^^
Is csx->can_gw_hops initialized to zero for fresh CAN frames?

The old code used skb->csum_start which was zeroed by skbuff_clear() during
skb allocation. The new code reads from can_skb_ext::can_gw_hops, but looking
at alloc_can_skb() in drivers/net/can/dev/skb.c, only can_iif is initialized:

    csx = can_skb_ext_add(skb);
    ...
    csx->can_iif = dev->ifindex;

The skb extension memory comes from kmem_cache_alloc() without __GFP_ZERO in
__skb_ext_alloc(), so can_gw_hops will contain garbage from the slab.

With default max_hops=1, if the garbage value is >= 1 (probability ~99.6%),
the frame will be dropped at this check before any routing occurs.

Should alloc_can_skb(), alloc_canfd_skb(), and alloc_canxl_skb() initialize
csx->can_gw_hops = 0?

>  		/* indicate deleted frames due to misconfiguration */
>  		gwj->deleted_frames++;
>  		return;

[ ... ]
-- 
pw-bot: cr
