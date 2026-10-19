Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792433244;
	b=wI7aDgfM1s/wKo0C5ECwobIJL2jmMQgUWhjK9tQuDzzDQwu0UiFqf7UldlryYHHlevkG
	 Q61DikSIloEdY5UN2/bwbTznsifSw/moPOCUYqsR8XkaimVBgLChVzJ0ZABq47flNVNZK
	 jm4C8ed2z06vbVITTEMsuwC689AtuzmE8bqSqDOnam8i+KCRjXVpVvA4yGBYWIlnqndfA
	 k/J5LNJMYwReRmQ7ki/fb5yvq19pp3EDO8bgE/hV4iMSZkXRbKIxQ1dJunwutCfqFuyqM
	 vZ6WGVdRoeDVqP+K721RcGI4D0Np192ySx5F1Rr3A6DR4yiR8Aznqm1/0Ei1FxpZlqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792433244;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=IB3xUUyKbqELjxloNd+JcVn0oTontexbT3Cn8vM2LjQ=;
	b=mUvGesB/VmsI3DNrUIBJeybqtFUg0Icn6UfMleqduOIwaNB9LkfHDtZSv6SJ4HVA0p2K
	 wPLWRQUqgs1ZZhgiGAAfJ1iV0xRU6nKhZZ2kJm9j2q97O5WqOGK3JHuavyDcRd+gB5A8z
	 L10bnayfK4i59iiiLUWFIbq0NM0oR7VtqxZn0cu4MqUgfBsEkexeKqt1QrZI3OGdP/54J
	 TQn14R4cKxZi7UNFVyeS0nThYapwKu9zVc2kOu+IY05iKkP4EZAiGmE+fsePQhDvoYLkJ
	 r2tNpl5bVU01hDdAnDJF7DqV7C9+fF2RVyq5TI9RpQsUHNKaHf63Rleu2stCNhhtTTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JAad/sKM";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73233606A319;
	Mon, 19 Oct 2026 18:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JAad/sKM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD2C1F000C5;
	Mon, 19 Oct 2026 18:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792433244;
	bh=IB3xUUyKbqELjxloNd+JcVn0oTontexbT3Cn8vM2LjQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JAad/sKMZwY0nAHOUY4+74kUncLF7zD6lFl1+q5PQP9fnTAjbo8Z9sprqqzIOMVJB
	 W2qUdqty8b1/MaxeufyI2ndc/ZAWhejP00YOScwHYB37nhHdFDcyLnY6coNlk+aJ9T
	 fd13WaVt11iPa+R7gCxdEXaKwMJLunGH0vmuLI+AtmmLXKGiGkD7zCVDP7bNKE2979
	 4thgFE2lOPCtdT1UBaQhuxkUT/xaEmGFjw4eGntiNn0aNKZNUhMLTsLDJxev/1PNXv
	 t84oIk5b5oj2Q9ILN1lfjBGi5wrSW5Lh4VsDevusVvqqRddxKygHsOwlZ9xmqDvD/L
	 FuJdql0afoA6w==
Subject: Re: [PATCH net-next 10/12] can: skb: make echo skb freeing safe in
 any IRQ context
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de
Date: Mon, 19 Oct 2026 18:07:23 +0000
Message-ID: <179243324322.3135.6343395816383334540@kernel.org>
In-Reply-To: <20261018164417.1540449-11-mkl@pengutronix.de>
References: <20261018164417.1540449-11-mkl@pengutronix.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This patch changes can_create_echo_skb() in
  include/linux/can/skb.h to release the original skb with…

--

can: skb: make echo skb freeing safe in any IRQ context

The commit converts the drop paths in can_put_echo_skb(),
can_dropped_invalid_skb() and can_dev_dropped_skb() from kfree_skb() to
dev_kfree_skb_any(). It also makes can_create_echo_skb() release the
original skb with dev_consume_skb_any() instead of consume_skb(). This
makes the release safe when the caller has hardware interrupts disabled.

Link: https://patch.msgid.link/tencent_E84809CF236D0137885E7E4E4D58340B3208@qq.com

> diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
> index 5d27843862fca..87ace09c0d8bd 100644
> --- a/include/linux/can/skb.h
> +++ b/include/linux/can/skb.h
> @@ -78,12 +78,12 @@ static inline struct sk_buff *can_create_echo_skb(struct sk_buff *skb)
>  
>  	nskb = skb_clone(skb, GFP_ATOMIC);
>  	if (unlikely(!nskb)) {
> -		kfree_skb(skb);
> +		dev_kfree_skb_any(skb);
>  		return NULL;
>  	}
>  
>  	can_skb_set_owner(nskb, skb->sk);
> -	consume_skb(skb);
> +	dev_consume_skb_any(skb);

[Severity: Low]
This isn't a bug, but should the comment in virtio_can_start_xmit() in
drivers/net/can/virtio_can.c be updated as well? It still names
consume_skb():

drivers/net/can/virtio_can.c:virtio_can_start_xmit() {
    ...
	if (unlikely(err)) {
		/*
		 * can_put_echo_skb() already consumed skb via consume_skb(),
		 * so returning NETDEV_TX_BUSY would cause the stack to requeue
		 * a freed pointer. Drop the frame and return OK instead.
		 */
    ...
}

The ownership point in the comment still holds, because the original skb
is still released. After this change, though, the release goes through
dev_consume_skb_any(). That either defers the free through
dev_kfree_skb_irq_reason() or calls kfree_skb_reason(skb, SKB_CONSUMED).

>  	return nskb;
>  }
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018164417.1540449-2-mkl%40pengutronix.de
