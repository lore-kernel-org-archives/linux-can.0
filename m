Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108318;
	b=UlfKSdvZwczXjKVWOBpQpAzgYEdqi2RbtprCWh4a2qyc7w7WUgQKw2DIXFikW+neUMXp
	 KGq710yV6And7cgUbh6MNbjq6u+I95o30W9TIK/FFBaK9G0Fv+oRMmRb/mpK6cDP4b0H0
	 muor4izSNfvaPWQU6JhLrIxoiOfGYV0gYt/SsZpUoZ2Hhb+fyUMUQ398T+nE6PJpjJbwp
	 Fyh1sqFUbrpYpPHdP6oRj9Y2uPMHqBDjc4OtExjpVhzh959OoxJqwqWLp1gsaVpMJbyRF
	 zR14LSvU6PPJ/MHv1ef8sK9IgTG+Dn+574fQe36pAHpbpJgE+WRVh5eT33qKWkq973g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108318;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pZ3byyuUWgxDT+HRb9SvPARIV5mZzPH2tkeaZBfCddA=;
	b=49WIaF82ZEdoP7t3udRIlPd4EL75Rh2MKXqb+uPkP8dcElk2bxzYDpac7C9t1tHFLaMi
	 jaUNuNgFWLkjeEMSGgVjo9GLcvAZZlG4yJ/tDBVi0zys23DAFGtEzWAeglHk2MRXYQUu0
	 U3KLot/JaZJ3FtMf2vq/bwcj1nqskrlvj7a9TTW/7rosMerBHO8mukY2TOuQ4tYQ7G07E
	 YGqW3oOX/kzv8U0qk9HQHqRbayut1/AyLB4HoNSOG8bNU+5JhFQSZZDqx67zwC4IfSnG9
	 eb4k4EE1Y7wyqBN2k1OaEVUgS8s18l/Ml/8RUl4erY2VzXUmyjuICWFMExBYxQs2hQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="d/IWNHTf";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78067606A32C
	for <linux-can@vger.kernel.org>; Thu, 19 Nov 2026 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d/IWNHTf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD49F1F000C4;
	Thu, 19 Nov 2026 17:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795108318;
	bh=pZ3byyuUWgxDT+HRb9SvPARIV5mZzPH2tkeaZBfCddA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d/IWNHTftwzV/i+0OVP63o9wlVhWZfX0ph4nNzXXEkKkvEJaVfnjo+a5+KQKG0oUW
	 YU7qklt7mwjCnHkrU1TjzaEq7/2InXBXW5Zx1pRlTsxIQgUblf7/ImmUWqZ/0oNzRD
	 doHnvH33lA+vhtdcWxSVfuENCLt6WDRkHhTDEhO5SU0WTaWXrPuNk/Wd5IDCeHbQGk
	 PmjWHbCPmt+VUk9vB27O8DE8xNr+U57AXSdsjKOd6D0P3WevHD5xlbdTtDEwLaWuuf
	 5UvcD7q7rgmr/wC/bbzsidaaY70fepZkRnpbycoMK8nrx4sCs4hR9HE/nwIkqLRR6o
	 zH5ePcWnTT62w==
Message-ID: <sashiko-outbox-223645@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: softing: lock card->fw.lock unconditionally in
 softing_card_shutdown()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261119170722.1524088-1-irogers@google.com>
References: <20261119170722.1524088-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 17:11:57 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] can: softing: TOCTOU race on card->fw.up in softing_startstop()
  [1]
--

commit ae72f0f8531d52de45e7b52fa1bdb8f595a10797
Author: Ian Rogers <irogers@google.com>

can: softing: lock card->fw.lock unconditionally in softing_card_shutdown()

This commit replaces mutex_lock_interruptible() with mutex_lock() in
softing_card_shutdown() so that device teardown always acquires
card->fw.lock before clearing card->fw.up and releasing resources.

> diff --git a/drivers/net/can/softing/softing_main.c b/drivers/net/can/sof=
ting/softing_main.c
> index 519ab3097f866..d3dfad4f5321c 100644
> --- a/drivers/net/can/softing/softing_main.c
> +++ b/drivers/net/can/softing/softing_main.c
> @@ -448,9 +448,7 @@ static void softing_card_shutdown(struct softing *car=
d)
>  {
>  	int fw_up =3D 0;
> =20
> -	if (mutex_lock_interruptible(&card->fw.lock)) {
> -		/* return -ERESTARTSYS */;
> -	}
> +	mutex_lock(&card->fw.lock);
>  	fw_up =3D card->fw.up;
>  	card->fw.up =3D 0;
> =20

[Severity: High]
This problem wasn't introduced by this patch, but can softing_startstop()
race with softing_card_shutdown() on card->fw.up [1]?

softing_pdev_remove() runs softing_card_shutdown() before unregistering
the netdevs, and softing_startstop() checks card->fw.up before taking
card->fw.lock without rechecking it under the lock:

drivers/net/can/softing/softing_fw.c:softing_startstop() {
	...
	if (!card->fw.up)
		return -EIO;

	ret =3D mutex_lock_interruptible(&card->fw.lock);
	if (ret)
		return ret;
	...
	softing_enable_irq(card, 0);
	ret =3D softing_reset_chip(card);
	...
}

CPU0                                    CPU1 (kworker / netdev)
softing_pdev_remove()                   softing_startstop()
                                          if (!card->fw.up) // sees 1
  softing_card_shutdown()
    mutex_lock(&card->fw.lock)
    card->fw.up =3D 0
    free_irq(card->irq.nr, card)
    card->pdat->reset(card->pdev, 1)
    mutex_unlock(&card->fw.lock)
                                          mutex_lock_interruptible(...)
                                          softing_reset_chip(card)
                                            <-- loops forever on reset card

When triggered from can_restart_work or a netdev call holding rtnl_lock,
softing_reset_chip() spins indefinitely waiting for softing_fct_cmd() to
succeed on the reset hardware, stalling device removal in
unregister_candev().  Checking card->fw.up after acquiring card->fw.lock
in softing_startstop() would close this race.

[1] https://sashiko.dev/#/bug/linux-f244dc22-af63-40f7-af90-ef6182f497c5

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119170722.1524=
088-1-irogers@google.com?part=3D1
