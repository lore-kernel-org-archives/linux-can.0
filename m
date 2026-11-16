Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855070;
	b=O0tMo8aO/EYWncLntWCAWLHkLFp5+ymDQlI2gSQIeGTqNwO4GagF50RhT3nqzqyDMs/2
	 s1aJUNx3GMcJbqKCW1cJNh2UUcU0NwHTWduBfXmfDrdZ/3gdR1bPJ7qQj2yjbiVHxBHr9
	 Tsj9qDHmHxTeLWLXscSrv8YlpsBk+5Ta3zeRofmRVJWFzs81uhkfEpwPpQZIX9FkUQm0i
	 xeg/5gWNBUtZGF8++Fadknq0sdW4iewaISil8ZUHRR8CNVmQgxRonPmHPQgLhftEgu2vs
	 mg+scLL2gaRGrglHVtAZU43lNVFxGQbgnTLn1JYRz+XTjVUPMaXIaHrahaBFG22d/+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855070;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=kAm4pyJJSQgs4jqnD8Vo6GSExMQ/Bql7AGxDevjLYOM=;
	b=LlKW9g+LQLEqMQ0xdfgNvi3cCDJ1XFhZm8I1+Nk3ZbGjspo6Si/tCuAefC8k1R4/bgfJ
	 r9MGMKnGvdMXwA9t4OYoVCsjWN/UTKpLmaF79Nm0n/D9HH0ojEM7qujW8WJ9n8x2u7BCK
	 Zi7ISdGF6bpm4CRDOicUavrjVI+V8NpEO4QxoQHLmqBAk+YOrxAtw5pj+BvySGeQBV3Ne
	 86rUdckg1LFjsxkoaQKtppWqaMdpRKwrB7Ss0zgG/JmIgx2gR4yFqXMnOVEwbtLGJxXnn
	 vvaSjhHVDN58JpBOPLutM6Q1CO8zhVrt4oUCTTIyQF5gTXWXd7HxcP8Dg8DTK+HhAeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DhAd2meG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D59606A31C
	for <linux-can@vger.kernel.org>; Mon, 16 Nov 2026 18:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DhAd2meG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB04D1F000C4;
	Mon, 16 Nov 2026 18:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794855070;
	bh=kAm4pyJJSQgs4jqnD8Vo6GSExMQ/Bql7AGxDevjLYOM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DhAd2meGMPPlLnmmN/WH8WQ6o8QtuwEJkZkxENSd6W/nYTrRO1uUIaGHmmp5v4PQU
	 JYgjn98DIw5/u6KPvn/KXWvl4aBBm0iX2B02xz7xIoDA/U21+6O0ElLxBREc0+MmN3
	 U0msn0vj9CbiTbY7FobLZLLZ4lTzs87LGtmvRe55qIESX5boNY2a98Zn+YKm9pHjT9
	 DRspDUpdQ+zOu2t9UXH4dC/uq6rRXiWTeQ6Y+xz0y+l9wzLwjFocRvJkNHY9LXwnr7
	 yb87ffzwfUFQuiqCKdqrUw+g7qjW1q34MGz+Ao7fw+loxu/02iABZujOsBdNizE5tI
	 /EFjO5lQQdVeA==
Subject: Re: [PATCH v13 5/6] can: j1939: fix "struct j1939_ecu" refcount leak
From: netdev-bot+sashiko@kernel.org
To: penguin-kernel@I-love.SAKURA.ne.jp
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 robin@protonic.nl, kernel@pengutronix.de, socketcan@hartkopp.net,
 kuba@kernel.org
Date: Mon, 16 Nov 2026 18:51:09 +0000
Message-ID: <179485506949.3132.11506849570102968027@kernel.org>
In-Reply-To: <8b40dfe5-2b1c-4f42-998f-0d0e82ec2246@I-love.SAKURA.ne.jp>
References: <8b40dfe5-2b1c-4f42-998f-0d0e82ec2246@I-love.SAKURA.ne.jp>
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

- [Low] The commit message only describes the bus.c changes: (1)
  j1939_ecu_timer_start() no longer re-arms, and (2)…

--

can: j1939: fix "struct j1939_ecu" refcount leak

This patch fixes an ECU refcount leak reported by syzbot. The leak happens
when j1939_ecu_map_locked() runs from j1939_ecu_timer_handler() after
j1939_ecu_unmap_all() has already completed. A new helper,
j1939_ecu_verify_get(), refuses to take an ECU reference once the netdev is
no longer registered or rx_kref has dropped to zero. The helper is used in
both j1939_ecu_timer_start() and j1939_ecu_map_locked().

Closes: https://syzkaller.appspot.com/bug?extid=e2af46126e0644cbebdd

> diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
> index 50a598ef5fd4a..6e22ec5e88f5a 100644
> --- a/net/can/j1939/socket.c
> +++ b/net/can/j1939/socket.c
> @@ -484,7 +484,15 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr_unsized *uaddr, in
>  			goto out_release_sock;
>  		}
>
> -		if (ndev->reg_state != NETREG_REGISTERED) {
> +		/* Do nothing and fail early if netdev is no longer registered.
> +		 * This check is racy but we don't need to recheck after j1939_jsk_add()
> +		 * is called, for either j1939_sk_netdev_event_unregister() from
> +		 * j1939_netdev_notify(NETDEV_UNREGISTER) (which is retried by
> +		 * netdev_wait_allrefs_any() as long as priv->rx_kref held by
> +		 * j1939_netdev_start() is preventing j1939_priv_set(priv->ndev, NULL)
> +		 * from being called) or j1939_sk_release() will take care of this race.
> +		 */
> +		if (READ_ONCE(ndev->reg_state) != NETREG_REGISTERED) {

[Severity: Low]
This isn't a bug, but the commit message doesn't mention this
j1939_sk_bind() hunk. It only describes the bus.c changes:

  Fix this problem by

    (1) preventing ecu->ac_timer from re-arming in j1939_ecu_timer_start()
    (2) making j1939_ecu_map_locked() no-op

This hunk adds READ_ONCE() and a comment explaining why the bind-time
reg_state check doesn't need a recheck. As far as I can tell it doesn't
change behaviour, and it isn't part of the ECU refcount leak fix. Since the
patch is tagged for stable, could the commit message cover this change, or
could it go in a separate patch?

The READ_ONCE() annotation is also applied inconsistently. A similar
lockless read in j1939_session_activate() in net/can/j1939/transport.c is
left as is:

	} else if (priv->ndev->reg_state != NETREG_REGISTERED) {
		ret = -ENODEV;

>  			dev_put(ndev);
>  			ret = -ENODEV;
>  			goto out_release_sock;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/7cc08b0f-290e-464b-ab13-0a5ce3c57f4f%40I-love.SAKURA.ne.jp
