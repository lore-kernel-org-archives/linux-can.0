Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32EF3C7E17
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 20:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629861; cv=none; b=ev2sckLwPKiloLZHiaYJ/KsXg0+QIYeiNOpSPBypNNMaZ4CMddN30rZr1kjpQ44nXun/YawHr4vHtMUTOSmjsXALvOPhi/yONuvlyVdUNw9IyKjh+7WJkTn7BUHdRZRh0zuGz9ZyiwCcYVB2P4rKNB04WY+IkmI762WR6R47vco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629861; c=relaxed/simple;
	bh=2MP+5swNFGvFxH8u60MjvIuDNPuKmoBZn+G8KCul3ak=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZRnd8IJomo6TUGoNTMVT2NhUGBWsKOrCGM1n9WgyON/FF0tgasOgjSYdiRE+D6Kjehbkp95B3nuxnwK7lPYxweuGPMZ7HrAV99n6Hkg3JoglouLqKzfv/AWRE2gdpnbsuLfWefIcsyNWHgxQ51YIM0tD/4vsMUYe5s6AVThBoeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbCWdAq2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbCWdAq2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC731F000E9;
	Thu,  9 Jul 2026 20:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783629858;
	bh=2VPZnLO9si6Pd4sUpp28OPmI3CqS7JIo4HR/tI++wrI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BbCWdAq24h6CZ3rZKQlyeSl3Ph2ghyh7BFod0xMCA323isuRRbuudYXnh0lerkMgn
	 SqJYLSC1mzJtCOfwTXOcrQU9qHcRdzpG5s82Cqyinme6mkuwObPvESdZ91bjO9oCR7
	 letZZtPom4jxUsu2Xc+Kyy64xA/tvJ8+YKjiJOHUeNJ5SlT07u3/RwWgqS/9HK35pH
	 M1hA2XHe8ch3cGK0yVl29R4IPYch+MGUYpo0QFP+HadM8Nyml/RnAyTllZ4qZ2sTyy
	 7sLnQ1MYCv11SYgnl/0NlOeOH5p5MkgEfyfHulazMDFYZhOyURIsZVtOHFmlVxEsIP
	 ug0I/VPgiLAHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 10/11] can: bcm: fix data race on
 rx_stamp/rx_ifindex in bcm_rx_handler()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org
In-Reply-To: <20260709-bcm_fixes-v12-10-61c06291bf1c@hartkopp.net>
References: <20260709-bcm_fixes-v12-0-61c06291bf1c@hartkopp.net>
 <20260709-bcm_fixes-v12-10-61c06291bf1c@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 20:44:17 +0000
Message-Id: <20260709204418.4BC731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Delayed or multiplexed frames report the timestamp and ifindex of =
newer unchanged or unmatched frames instead of the actual frame being deliv=
ered.
--

--- Patch [10]: [PATCH v12 10/11] can: bcm: fix data race on rx_stamp/rx_if=
index in bcm_rx_handler() ---
commit f0e124b25a2c7cb08e57d4a9731711a9b77bf578
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()

This commit fixes a data race by moving the assignments of op->rx_stamp and
op->rx_ifindex inside the bcm_rx_update_lock spinlock section. This ensures
concurrent writes on different CPUs do not tear the 64-bit timestamp.

Link: https://lore.kernel.org/linux-can/20260707145135.5BC831F00A3A@smtp.ke=
rnel.org/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index fbf1cbb7c99fe..10a883b50fc63 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -815,6 +810,14 @@ static void bcm_rx_handler(struct sk_buff *skb, void=
 *data)
>  			traffic_flags |=3D RX_OWN;
>  	}
> =20
> +	/* save rx timestamp and originator for recvfrom() under lock.
> +	 * For an op subscribed on all interfaces (ifindex =3D=3D 0)
> +	 * bcm_rx_handler() can run concurrently on different CPUs so
> +	 * the CAN content and the meta data must be bundled correctly.
> +	 */
> +	op->rx_stamp =3D skb->tstamp;
> +	op->rx_ifindex =3D skb->dev->ifindex;
> +

[Severity: High]
This is a pre-existing issue, but does unconditionally overwriting the
metadata here decouple the payload from its true origin?

If a frame matches the CAN ID but fails the MUX filter later in this
function (or has an unchanged payload when using a throttle timer), it is
ignored. However, the rx_stamp and rx_ifindex fields are still updated.

Later, when the throttle timer flushes the pending frame via
bcm_send_to_user(), could it deliver the pending payload using the corrupted
metadata of the ignored frame instead of the actual frame being sent?

>  	if (op->flags & RX_FILTER_ID) {
>  		/* the easiest case */
>  		bcm_rx_update_and_send(op, op->last_frames, rxframe,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-bcm_fixes-=
v12-0-61c06291bf1c@hartkopp.net?part=3D10
