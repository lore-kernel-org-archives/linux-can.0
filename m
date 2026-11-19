Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795080751;
	b=BK9FRb4MGIGM88A3FcOyE477yi+RNDbhmqalWsZ/q/wSlttaqRZzqw+4B7pAIzQ0H+aM
	 Q1sGq4t55Nqt09ZzQ9dtdkSMRJtie5ikOuaCxY4d8PCwn7dC4PCgqTT5nVOOYg3y0YVM5
	 q2bz6OlqWKtSeWlhIzdVUfpOeat6y4Tn/Jb7G0D355Gf1aqWDKuIFaMdSXh3LsxfUWNcq
	 4gSGOu9q3x7K1Dspg4I13DvL/LNYbU1lQZo4KLMtXJX9sHqy5za95HNbMIpGrFGeVP6G1
	 czYVx1hmpwEtwjbaVr2nBmJ2DQ03iEu7tKu2xuq1PpHeHn0OEAcx0vT9VQ+UTfDXu3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795080751;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+l6ugOT49my9F60+EAuKD1hhJCIHjwr+0ltB1+cpP0c=;
	b=bN46hZ9KKCN7Z0Y/BAErmv9yQvN19HoIqOkGZwHzVLK9C6k+kcNiIFRoty/faHR2SEng
	 8bIXtLBvjFelD1Tl6n9I8n4veb8SSNRdUAeRgoj1Q+ppZXx5OFR1+vPKAtMX+Rotgly+T
	 B+I1vRyJtMKeoo/SUYoDo3CKNdsjBfSgvl6RYhPpwP1bCMoIuuJAKKvF36e9ZjQ0v3RC8
	 MsluMVe2RowpCJc+9lFBOJh67AgX2R792ZLxPNGkQpftES1jayNbLWnQ3y+E2PmkNVK79
	 6sMoVdx4lU7rztjppnIbmiPL4iKdBZs+vUTNI2hwI2jfCaFTWKs/yCCKqKq82nnofTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Icq6WYnj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB7D606A320
	for <linux-can@vger.kernel.org>; Thu, 19 Nov 2026 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Icq6WYnj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8E01F000C4;
	Thu, 19 Nov 2026 09:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795080750;
	bh=+l6ugOT49my9F60+EAuKD1hhJCIHjwr+0ltB1+cpP0c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Icq6WYnj/mCQYVv1CBJL5z/0Pm/LL1Bi6Vl8mAEBmTDdd/uXrk1oBkBfS4crNO64v
	 JeO2qwLJsklG/1Tq0sRIxgqIBFTkB7pEcrhqznqxIewd2NZu9ixCnoONQdisqd74SF
	 1K5gb5u8gi+WGBkMpICMu9k7TJXlE4D1TgzwiHuI2SzYnBvjNCzUg0OwvCDVM6xsnp
	 QSqdU3D209Kn4dWYRYcHQzi50GMhTiNggajTP1Jwe0TN58H4rjfpoKAvC5qpoTYNk0
	 hwGuEwaq2Tq3+qBaOjzxvKqFZSp5g0G9UkYxO2Cpjsv+0vVyyR3+UWmN1TKEFbMKSy
	 ui/XQeu8FslCA==
Message-ID: <sashiko-outbox-222848@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 06/12] can: sun4i_can: don't discard the IRQ
 lookup error in probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261118092955.1283165-7-mkl@pengutronix.de>
References: <20261118092955.1283165-1-mkl@pengutronix.de>
 <20261118092955.1283165-7-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 09:32:27 +0000
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
- [Medium] can: sun4i_can: clk leak in sun4ican_probe() on IRQ deferral
  and log mismatch
--

commit d88cf8d3dd8506848b42acf7070c915117b36839
Author: Chaosheng Qu <chaosheng.qu.linux@gmail.com>

can: sun4i_can: don't discard the IRQ lookup error in probe

This commit propagates the negative errno from platform_get_irq() in
sun4ican_probe() instead of overwriting it with -ENODEV so that deferred
probing can succeed once the interrupt controller is available.

Link: https://patch.msgid.link/2a7cb6e4e1b494efd4da512abbf307c19d9d1467.179=
2118040.git.chaosheng.qu.linux@gmail.com

> diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
> index af52285d5a4e0..80be48d0593db 100644
> --- a/drivers/net/can/sun4i_can.c
> +++ b/drivers/net/can/sun4i_can.c
> @@ -853,7 +853,7 @@ static int sun4ican_probe(struct platform_device *pde=
v)
> =20
>  	irq =3D platform_get_irq(pdev, 0);
>  	if (irq < 0) {
> -		err =3D -ENODEV;
> +		err =3D irq;
>  		goto exit;
>  	}

[Severity: Medium]
Does returning -EPROBE_DEFER via goto exit leak clk on each deferred probe
attempt?

sun4ican_probe() acquires clk earlier via unmanaged of_clk_get(np, 0), and
the exit label returns err without calling clk_put(clk):

drivers/net/can/sun4i_can.c:sun4ican_probe() {
	...
	clk =3D of_clk_get(np, 0);
	if (IS_ERR(clk)) {
		dev_err(&pdev->dev, "unable to request clock\n");
		err =3D -ENODEV;
		goto exit;
	}
	...
exit_free:
	free_candev(dev);
exit:
	return err;
}

Also, the commit message quotes this error path as jumping to
exit_put_clk, which does not exist in sun4ican_probe().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118092955.1283=
165-1-mkl@pengutronix.de?part=3D6
