Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33F53BB101
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 20:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629352; cv=none; b=mGH2zkRod3mtneaVlbnEH6kY5venVctcNA/qH2zduLca5Ry5ZJFXWYY6IaXiB34vGnzj7irklZgaQjIWCddJuiSI/hS7C22PwKcH5tTZhNWGMDoHLUjyPbfw2qnL3Q8QzNgY+AAGlcBuN4JuPcyzWCuva7OWYB9SAY/4eR1P0+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629352; c=relaxed/simple;
	bh=ar6lHWqPRy5SxT2IjSZ5Iqdk1C7YYIQkt9cezq62+ho=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GWEMmciofWq6Sv8ou46qW9mQMXOf3tZzWlBxRIqSIWQIPWydOyJjJD9YMNT8dxogXnpiGf7mf15q0HvGlZjPceiLB9yWz9wDAw9esoyQYPBUxmoHeOxftkJ83F7b3qRf7AX6RkvlJONR6I+FXf9tirf0rMCQBZUpuq+BdzJGRXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2hE2X1L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2hE2X1L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1331F000E9;
	Thu,  9 Jul 2026 20:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783629351;
	bh=KcmmsTDfv3D6VwfU1NsR0rJ++VkLMbwyIpfvQsxBQ0A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B2hE2X1L7O+hMnchcfxg7Y33fooAkKJCH/HLKhoo5PuMmNZ4UO6+nuKUY9EEgjPra
	 GvhqMJR1fOqgCJC/GB+saZbjYqLl8A6Std36kk1zRZ80xMePAHGJ0zbHoHVCvOtILj
	 VdUU2z+6PBo3RX0SrQYACeaBFUCbjEUWViH/Ann6/XdIUi/RjcBPeWWDzJ9WVO4Li1
	 Chmqh6VQYjIxDvZZrUq5gdAnTJWmmhKR5/D3RPpQwI/gwjRrOf5Jfeuoy5PPtYjPFb
	 HUvMTINRzlhDF3kPxirOBaY2QsuFNUolkvQaD7RGWTpXTdq1ldC9u5A3vF/1aqsAVx
	 HOXyA7pDjLb9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 04/11] can: bcm: fix CAN frame rx/tx statistics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260709-bcm_fixes-v12-4-61c06291bf1c@hartkopp.net>
References: <20260709-bcm_fixes-v12-0-61c06291bf1c@hartkopp.net>
 <20260709-bcm_fixes-v12-4-61c06291bf1c@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 20:35:50 +0000
Message-Id: <20260709203551.1A1331F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unsynchronized modification of rx_stamp and rx_ifindex allows conc=
urrent frames to corrupt each other's metadata.
--

--- Patch [4]: [PATCH v12 04/11] can: bcm: fix CAN frame rx/tx statistics -=
--
commit f0713957841f9a5510dbab52a7bc1b9ca16a367e
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix CAN frame rx/tx statistics

This commit addresses a KCSAN-detected data race in bcm_rx_handler() by
converting rx/tx statistics to atomic operations. It also simplifies
overflow handling and resolves a race condition where frames_filtered
could become larger than frames_abs.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -748,24 +767,30 @@ static void bcm_rx_handler(struct sk_buff *skb, voi=
d *data)
>  	op->rx_stamp =3D skb->tstamp;
>  	/* save originator for recvfrom() */
>  	op->rx_ifindex =3D skb->dev->ifindex;

[Severity: High]
This is a pre-existing issue, but does this unsynchronized modification
allow concurrent frames to corrupt each other's metadata?

When a wildcard (ANYDEV) CAN BCM receive operation is configured,
multiple interfaces might receive matching packets simultaneously. Because
op->rx_stamp and op->rx_ifindex are updated outside of
bcm_rx_update_lock, could different CPUs concurrently overwrite these
fields?

If so, this might result in userspace receiving packets with mismatched
timestamps and source interface indices, potentially causing logic errors
in routing or packet processing.

> -	/* update statistics */
> -	op->frames_abs++;
> =20
> -	/* snapshot the flag under lock: op->flags/op->frames may be updated
> -	 * concurrently by bcm_rx_setup().
> -	 */
> +	/* op->flags/op->frames may be updated concurrently by bcm_rx_setup() */
>  	spin_lock_bh(&op->bcm_rx_update_lock);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-bcm_fixes-=
v12-0-61c06291bf1c@hartkopp.net?part=3D4
