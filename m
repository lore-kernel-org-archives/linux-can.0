Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2BA374A05
	for <linux-can@vger.kernel.org>; Sat, 10 Oct 2026 13:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791639843; cv=none; b=am/dCs/RIxxU48HyOqRhqIdVubopALaMxY2hrxkDtZTgM5cS0cWKIcpHDRLemvf3dOSWh4FILID0ukft/MHJXFjaM3EmGGAznZ9Y7zvdHNQ+b2G9OdBs7RbsAd+bk7ijaT3c6Pe+iTAsgJ+AFAW+2fEh75xGrjnO8lpSbBYzNoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791639843; c=relaxed/simple;
	bh=Z7ZVjvVq5jgYuJH2JbZqTjqHQLkqeNEgq7g+J+yJh1M=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=MMZkzEJek7XSfin95FSCtz0neN0gWYAHvownzveEgxI5KbAykKHC1JQ5lFg5Rvku4C/0ACtOONdC0dbCamJqhgbI+nthsVCDroTCexUWLJ5HZqwXE3xJ5bfw04d0q/E4BskCM5aWcZgbWMjcxaUGUWZ0EP2bACl+JqqOXmoqJgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lw7FT6Tu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lw7FT6Tu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695F81F000FF;
	Sat, 10 Oct 2026 13:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791639841;
	bh=MoEsPUt6WvyI5aXp5L43HojhGRb95bcBYLE4i8aHE70=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lw7FT6TuOifk+h14083VZA7kjaEnT8AkZTC1VjWe8kozshydrHM1Qk41B8V8cE3o2
	 DrsPpnwExIPFwbUFcwWo9hqzY5M0W2Y87KTW4e2CIXi7cZLtCi1eL2gavSZ3SbeVxI
	 syO4N5cYePEx6WcGMqSEIWHsIixfLV2O6ePjpCIVXul1ahjVLQKy7QqZxf0jx984zZ
	 aIrnOloDrP90DtKhAIYTZv8h6wsAK6oCJldw5R/OCynGqGk64seIHf+A7PdcyZv3y6
	 JmPJdsGFc5f6SmYFSYhQ5Y1ligXYBSHqWsGYz06jpfbvY8IAZQMcpx44ooJskXXm8V
	 wj4lyk2CK0dzw==
Message-ID: <sashiko-outbox-166619@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 29/37] can: f81604: f81604_close(): fix
 use-after-free on disconnect
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20261009134323.64064-30-mkl@pengutronix.de>
References: <20261009134323.64064-1-mkl@pengutronix.de>
 <20261009134323.64064-30-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 13:44:00 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] can: f81604: TOCTOU double-free in echo_skb array during f81604_cl=
ose()
--

commit 169687a41025adccdc4855da35895fe6f761e8b9
Author: Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>

can: f81604: f81604_close(): fix use-after-free on disconnect

This commit fixes a use-after-free by unregistering URBs before cancelling
the clear_reg_work in f81604_close().

Link: https://patch.msgid.link/20260901-f81604-fix-v1-1-c55b5178f9f8@fintek=
.com.tw

> diff --git a/drivers/net/can/usb/f81604.c b/drivers/net/can/usb/f81604.c
> index 4c147b9d6d690..bb155b8769245 100644
> --- a/drivers/net/can/usb/f81604.c
> +++ b/drivers/net/can/usb/f81604.c
> @@ -1075,10 +1075,10 @@ static int f81604_close(struct net_device *netdev)
>  	f81604_set_reset_mode(priv);
> =20
>  	netif_stop_queue(netdev);
> -	cancel_work_sync(&priv->clear_reg_work);
>  	close_candev(netdev);
> =20
>  	f81604_unregister_urbs(priv);

[Severity: High]
Can this ordering cause a double-free if an URB completion handler runs
concurrently with close_candev()?

When f81604_close() invokes close_candev() before unregistering in-flight
URBs, close_candev() calls can_flush_echo_skb() which iterates over
priv->echo_skb[] to free pending skbs locklessly:

drivers/net/can/dev/skb.c:can_flush_echo_skb() {
	...
	if (priv->echo_skb[i]) {
		kfree_skb(priv->echo_skb[i]);
		priv->echo_skb[i] =3D NULL;
	...
}

Concurrently, an active URB completion can trigger f81604_handle_tx() and
invoke can_get_echo_skb(). Because __can_get_echo_skb() also tests the skb
pointer locklessly:

drivers/net/can/dev/skb.c:__can_get_echo_skb() {
	...
	if (priv->echo_skb[idx]) {
		struct sk_buff *skb =3D priv->echo_skb[idx];
		...
		priv->echo_skb[idx] =3D NULL;
		...
		dev_consume_skb_any(skb);
	...
}

If both threads observe a non-NULL pointer for the same index, could this
result in the same skb being freed twice?

> +	cancel_work_sync(&priv->clear_reg_work);
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009134323.6406=
4-1-mkl@pengutronix.de?part=3D29
