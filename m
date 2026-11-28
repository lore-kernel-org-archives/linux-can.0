Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795861226;
	b=Ve43fES4fLzFFnmQE6t5HeJovLsZJ8P/xEtqtY9NVgW0gY4wojJvRtZx+5DovIrVu4rS
	 9FeqD/E+0qYN2f8+Sbebr02yviBVfedn1xIn2fxN1tUJ0hmKgx3DDIPEIam997MpbNSXg
	 6tp41GYtM5qdihlG9B89vQnVF2Lq6Gfn18MHJVK9OOxa9+1vk1guvmsZAruHdwsQhJ4hY
	 1utUnYc2i8AEDWs/9TbTOpG//+oQ1fC6IPdFDG8pvMpIeRBy83oykyH/zeFrpzYJ/W6u+
	 42brLa/zNcNyifhcNUaeobRyYHD91tnbqMBzqDfvFRCIX8Hm6vwXAZi0ex9Z/c+rVDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795861226;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=DY2By64z1rGbcNSAjr7Xt8E7LHn0GyI5Vt7INsDVf4w=;
	b=MAjiImEom+PL750NmvaxsM5AU5nqaCW8IbA0n4iwycLq2EwV87QsGHQcZ1cU5QwZd5Tg
	 Venb+o9Zx80yYUDkEhcGERf+KyFqaxphUbLAgptz59FIUNI0SfKZSuZXujNtlSvNWAnUO
	 CCNOtl9oa1wHHPbFI89KMDS7FXQCpJG0t+2Ende+emqCRweq6b2Y8BO/tECpGwqI1kZa0
	 vzAPrN0Rd2Dx9iSlru2U/vLek+fSVOUcWEeEDjxixyHRgnO+TqZ8RiGginuX+bEwNKs6A
	 lTFyGzmw1G6f4Qlva5qI/isSDSb9kKO+A5wD7yZ7eZKWiAttgi0YymZq5gdCslPTGAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=of0tj3Vt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC76606A31C
	for <linux-can@vger.kernel.org>; Sat, 28 Nov 2026 10:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=of0tj3Vt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E961F000C1;
	Sat, 28 Nov 2026 10:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795861226;
	bh=DY2By64z1rGbcNSAjr7Xt8E7LHn0GyI5Vt7INsDVf4w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=of0tj3VtMyAeMBlFEfztVB9/3ZEDbihWilW6f8A7Y7f/HzpguHCu4WnmheHYgrLbN
	 7ep46DgDAVM997j6OH+jI56CbejlKm8fNMEI/UkFjwxbwyMfHI6Uf6WvxgN7lH7QU3
	 NAuKk8xAyR1JvwEoxCpWi3yNXAba8EXKOhw0SQtISN9VjaVLEPjsZlgjo9XI9HKSq1
	 tP5Z6a+ZAEwVi4Bm6+5L+xaIAuo3branhsa1ClOP3n3HgXyb3/5VjJt9Xo9zeBzdNh
	 2DpDQ2OJqgmZ1X6cwaD1brb/jLelGRw+H0l1Q4OsPsQst3YNRvFSR7ZkeN/7qXIHc7
	 CrAsa1vDhj16A==
Subject: Re: [PATCH can-next 20/22] can: isotp: change return type of
 functions to void
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, sashiko-bot@kernel.org,
 zihanx@nebusec.ai, o.rempel@pengutronix.de, yewentian395@gmail.com,
 kuba@kernel.org
Date: Sat, 28 Nov 2026 10:20:25 +0000
Message-ID: <179586122519.3131.613240735251481383@kernel.org>
In-Reply-To: <20261126-getsockopt-memcg-isotp-v1-20-681ef8d8c2c9@hartkopp.net>
References: <20261126-getsockopt-memcg-isotp-v1-20-681ef8d8c2c9@hartkopp.net>
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

- [Low] Commit "can: isotp: change return type of functions to void"
  turns five functions into void functions: isotp_send_fc(),…

--

can: isotp: change return type of functions to void

This commit changes isotp_send_fc(), isotp_rcv_fc(), isotp_rcv_sf(),
isotp_rcv_ff() and isotp_rcv_cf() in net/can/isotp.c from int to void.
None of their callers ever used the return values.

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 31acff7c33aa5..a9182588aeb77 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c

[ ... ]

> @@ -357,7 +357,8 @@ static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
>  	hrtimer_start(&so->rxtimer,
>  		      ktime_set(ISOTP_FC_TIMEOUT, so->frame_txtime),
>  		      HRTIMER_MODE_REL_SOFT);
> -	return 0;
> +
> +	return;
>  }

[Severity: Low]
This isn't a bug, but could the trailing return 0 be dropped here rather
than turned into a blank line plus return?

A bare return as the last statement of a void function has no effect.
checkpatch.pl also warns about it under RETURN_VOID ("void function return
statements are not generally useful").

The same pattern appears at the end of isotp_rcv_fc(), isotp_rcv_sf(),
isotp_rcv_ff() and isotp_rcv_cf(). The early returns inside these
functions are fine as they are.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9%40hartkopp.net
