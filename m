Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794378784;
	b=CS4TTYZpGXjiVaA29XBY0V2V+qJ5NfbwJEt9OUdQxSwLuUvbk6BcNHawGSnFF4yP323x
	 VOUh0z4pcMzrSF5s6ns9+YOLzuPlvZwiE6mt3oEQGw1MQCtLFyChhOn8lDkc2bk8DnSCc
	 jdqK2D6vKkZ8UcvW9sftz3xYJc+sXMyoQ9CpfMPM+xUvynNAccpEgVV9gd2f+84uJqHyb
	 g6tX2lE2AujNP/cfB4KSrIpmioOQvHKdoHUq+1AGq+8YHPsxKTQPB1qUJbdeat1eZZBMC
	 33s+JOtRXlgI2yhDnjwB05nd8yTYv1LIMMftZ1LJa8H0GGPRmJqS44P7Csv1Xbo1+BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794378784;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PM8DzaE9feM9UiVT9RNTcf77AiMkN7ELEScMqdL8P78=;
	b=fbKdSl3IgO00p/AlenkvcnULamsh0UpL0+BRZ3AL5AAk8uAOEsJSPol8C68pA8x6Oyzi
	 yb6FCWjR6T7cLZH0ZWA7+7X/zmldNj2AxxujZHsfsW3xP/1J5ErhNihMEOyQ9V1mNrJK5
	 rxLfCMWPFxrh+mzQbv32Kgr2u7EmyQ3bh0pa9f65hGqKsbEUZpQcrCCjyr99jCnnn/diy
	 NYujSCu3R3mNhe3dsawH1bDQWuc7aDElixft/Fd+sKW3/3ZdL7tzJ1/GDGddBl/npZGrl
	 eml3cV88ifXvZuZhQyuJXtJehiGiSJOigJLm8e4bST0vfkHpc9szqIJtx0+zP+CdBYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AC3sqa55;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EA5606A31C
	for <linux-can@vger.kernel.org>; Wed, 11 Nov 2026 06:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AC3sqa55
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF391F00A05;
	Wed, 11 Nov 2026 06:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794378783;
	bh=PM8DzaE9feM9UiVT9RNTcf77AiMkN7ELEScMqdL8P78=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AC3sqa55s1/9dHfodf2ql5Qm+TJh0Dg5qXC9cP5fTuhr/lLu/1pCOD0B1B848zuUt
	 7An6uXMv/gUUOFMkJV09E2XhpiSRWzQlhl3pxfNTaSon5hTR85xkr8xZ5JvkI3VWfl
	 qFfm4s2gwzFxloGuSTI0AHpLJ/fquged1uQ8kTrGkzoS+x+2VgxX+CNVeYKK/b3M9j
	 a7aYLwMkSYYIYVrILbWt8oensGb6CLCu41N5IzvdgXwoEWByANPYtPaozIvQlDX+ba
	 4djyCOrY4bOw1BZTwzA7OX3rITCboxJ0qyOnENZzpmdmcJll3xzRO0/8laRllMy37y
	 FcRBECSvOmRAA==
Message-ID: <sashiko-outbox-208446@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: gw: avoid losing statistics updates on concurrent
 receive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhu Jun" <zhujun2@cmss.chinamobile.com>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261111062907.16857-1-zhujun2@cmss.chinamobile.com>
References: <20261111062907.16857-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:33:03 +0000
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
- [High] can: data race modifying shared SKB in can_send() [1]
--

commit 10078742ee4a6687a5a77083fa056c99b8f26a52
Author: Zhu Jun <zhujun2@cmss.chinamobile.com>

can: gw: avoid losing statistics updates on concurrent receive

This commit converts the frame statistics counters in struct cgw_job to
atomic_t so concurrent receive paths and netlink dumps do not race on
counter updates.

> diff --git a/net/can/gw.c b/net/can/gw.c
> index 8a5327d8a00e8..a5233b4606dad 100644
> --- a/net/can/gw.c
> +++ b/net/can/gw.c

[ ... ]

> @@ -510,7 +511,7 @@ static void can_can_gw_rcv(struct sk_buff *skb, void =
*data)
>  		nskb =3D skb_clone(skb, GFP_ATOMIC);
> =20
>  	if (!nskb) {
> -		gwj->dropped_frames++;
> +		atomic_inc(&gwj->dropped_frames);
>  		return;
>  	}

[ ... ]

> @@ -571,9 +572,9 @@ static void can_can_gw_rcv(struct sk_buff *skb, void =
*data)
> =20
>  	/* send to netdevice */
>  	if (can_send(nskb, gwj->flags & CGW_FLAGS_CAN_ECHO))
> -		gwj->dropped_frames++;
> +		atomic_inc(&gwj->dropped_frames);
>  	else
> -		gwj->handled_frames++;
> +		atomic_inc(&gwj->handled_frames);
>  }

[Severity: High]
This problem wasn't introduced by this patch, but can routing an unmodified
CAN FD frame cause a data race [1] on the shared skb payload in
can_send()?

When no modification functions are configured (!mod->modfunc[0]),
can_can_gw_rcv() duplicates the incoming skb with skb_clone(), which shares
skb->data with the original skb, and passes nskb to can_send():

net/can/af_can.c:can_send() {
	...
	} else if (can_is_canfd_skb(skb)) {
		struct canfd_frame *cfd =3D (struct canfd_frame *)skb->data;

		skb->protocol =3D htons(ETH_P_CANFD);

		/* set CAN FD flag for CAN FD frames by default */
		cfd->flags |=3D CANFD_FDF;
	...
}

can_send() modifies cfd->flags in place on the shared buffer while other
receivers (such as raw sockets or packet sniffers) may be reading the
original skb concurrently, causing a data race and corrupting the flags for
concurrent readers.

[1] https://sashiko.dev/#/bug/linux-89b38ada-4acb-4bf7-afe0-3d8d244ba058

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111062907.1685=
7-1-zhujun2@cmss.chinamobile.com?part=3D1
