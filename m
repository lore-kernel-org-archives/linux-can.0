Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328743;
	b=Lu+DRAONJ53lb5857Eya+VJWcbTaGdsKl4ZA7q4IAnUc4gmtSv6JHU46kLLUWBr1oBTB
	 VpTOsk2LIgfZFGGxLIJxwumCvWbf4jUCKslnFRzoSXbvkAQEqsHHLVa9Zmzr2FzxYUtCt
	 CMDF6kMkCq3UB5WhAlIuiWkmCou3vUbdquGJQfZhpt5v/4YvVhbxL+JmM83Zq+DleZP4W
	 dxQyeX97U6zImynqoMTD93W9gctm/fHFf1Eojenhp7jcgzrrZ3l5lWQR5vJbUPt1ibtxE
	 4fHgJkNg5k3UrI5WbdWiqxyAQ4PxHyJfquo8bl6jjmIKnqRvnyVpwNnNmKUNZ+mmQeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328743;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vcw1cBvSEtlN2FqIjg6q7r4OQdob+cY/u8tWpdzXiGw=;
	b=jhGYLS6kpOrXdBfuoGCjjQRdUhXZI2wyqs4C66c0kms7F49e+DUbMcojKNRwE9JYmw3Y
	 07PAbKcBdzKVBNzNg2Wvg3FGkGVLXUta+wx7EPTsD6oE3hNF0SLYJrgFRiIB6SykoGJjY
	 4kYXgHKA+WjaiI+WUQmNk4lOxwIBj1/rRGG08EBQbIpj2uz2Fy1+t008TXkmSQwLjTH0y
	 l6ZvTrT2C4FVN2U3qpyfv4NjzAyPnMBtAfV75smDhTdZnTyYmjoKS8Zcnp6rzgtyS9Iaj
	 dcRqkYDlJ7HJAXEohfa9cP9kyQlTuldhx6MR8ub3GvT1x3JXRFrWAfIhebZJgzBnJTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BUxBERfL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F767606A201
	for <linux-can@vger.kernel.org>; Tue, 10 Nov 2026 16:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BUxBERfL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CAA1F0089F;
	Tue, 10 Nov 2026 16:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794328742;
	bh=vcw1cBvSEtlN2FqIjg6q7r4OQdob+cY/u8tWpdzXiGw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BUxBERfLY7IepspDbJNJ6v9ut9oDGOiazXDt46Nm7/q2PT+McKUa115ovyw/VoZaK
	 F19wD9Bv1M/X+8E0lUneHLIWqvt6oenXemMSyCC0fPXH9emaApr1QeXz0hEZLGN39Y
	 +eS8QhC4GhUeQjA57oKlht6h8/EDX2KDs1JrJDwGJCERG+GJIDlZsrltFe75k8xVcR
	 RyUqY7Sc6dKya6YO71pgSGjOA2i75F0AGoqs2pToeMvQweqIztxSn1IM35DCYl5wPG
	 /D7Kr/vCHJuiYvS2FETZufQLHZrWaIUZmI1MsmEhFtF9jRZwWrvw8hSKP4aCDJ1RUV
	 6XdVhx+6dOx8Q==
Message-ID: <sashiko-outbox-207397@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 2/3] can: j1939: fix possibility of
 hard-lockup/deadlock in j1939_ecu_timer_cancel()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>, linux-can@vger.kernel.org
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <f516220f-b922-4172-bf35-ce34d5f21b39@I-love.SAKURA.ne.jp>
References: <a1dd9760-7815-400a-a39c-a1a03cf8262e@I-love.SAKURA.ne.jp>
 <f516220f-b922-4172-bf35-ce34d5f21b39@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 16:39:00 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] can: j1939: j1939_ac_process() drops address claim when timer
  handler is running
--

commit 80762ad6fa3d1299e982ed85f13042798ab71255
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

can: j1939: fix possibility of hard-lockup/deadlock in j1939_ecu_timer_canc=
el()

This commit replaces hrtimer_cancel() with hrtimer_try_to_cancel() in
j1939_ecu_timer_cancel() and drops incoming address claim frames in
j1939_ac_process() when the address claim timer is currently executing.

> diff --git a/net/can/j1939/address-claim.c b/net/can/j1939/address-claim.c
> index ca4ad6cdd5cbf..89ba8c6fbe74d 100644
> --- a/net/can/j1939/address-claim.c
> +++ b/net/can/j1939/address-claim.c
> @@ -212,7 +212,8 @@ static void j1939_ac_process(struct j1939_priv *priv,=
 struct sk_buff *skb)
>  		goto out_unlock_bh;
> =20
>  	/* cancel pending (previous) address claim */
> -	j1939_ecu_timer_cancel(ecu);
> +	if (!j1939_ecu_timer_cancel(ecu))
> +		goto out_ecu_put;
> =20
>  	if (j1939_address_is_idle(skcb->addr.sa)) {
>  		j1939_ecu_unmap_locked(ecu);

[Severity: Medium]
Can jumping to out_ecu_put when j1939_ecu_timer_cancel() returns false
leave ecu->addr and priv->ents[] out of sync with the address claim
frame?

If a new address claim or J1939_IDLE_ADDR frame arrives for the same ECU
while j1939_ecu_timer_handler() is running on another CPU, the handler
can be spinning on write_lock_bh(&priv->lock):

CPU0                              CPU1
j1939_ac_process()
  write_lock_bh(&priv->lock)
                                  j1939_ecu_timer_handler()
                                    write_lock_bh(&priv->lock)
  j1939_ecu_timer_cancel(ecu)
    hrtimer_try_to_cancel() -> -1
  goto out_ecu_put;
  write_unlock_bh(&priv->lock)
                                    j1939_ecu_map_locked(ecu)
                                      <-- maps stale ecu->addr

Even if j1939_ecu_timer_handler() has already dropped priv->lock and is
returning, bailing out skips unmapping the old address, updating
ecu->addr, and starting the 250 ms timer for the new address.  For a
local ECU claiming a new address, j1939_ac_fixup() has already unmapped
the old address on TX, so dropping the echoed RX frame leaves the ECU
permanently unmapped and causes subsequent sendmsg() calls to fail with
-EADDRNOTAVAIL.

Since both j1939_ac_process() and j1939_ecu_timer_handler() serialize on
priv->lock, could timer cancellation be tracked under priv->lock so the
handler skips j1939_ecu_map_locked() when superseded instead of dropping
the frame?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/a1dd9760-7815-400a-=
a39c-a1a03cf8262e@I-love.SAKURA.ne.jp?part=3D2
