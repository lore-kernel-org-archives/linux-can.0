Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795776959;
	b=tQVnJVvFwJZt/h7wufCRP7EbqpzK54ZXkc505bXU0PWwCQgkdtx7D+7uHV6u9V7kz4/q
	 MoRH81B+gNbp/T51mMYLBHQte113riowLKwihpv/xHw7X3c5igIRPlhwnAB1idy1ONnjy
	 4yJen0l+i9yTDVdr1iauKE3VzfVMTwQ8qmR7Dng/+Ua71X36E8Z72tdvQNLXWgN0Tl1VA
	 ZZ8J7D9Seytzel5mEIB7cmLqjZ0WJOHQYrdRM03IRZJCraCWwhgxDny5Nrscnl7f/Zt/T
	 BpqJgLnPc/EhU4my3jHGS+Uqfb3OVtSjYGry+/4KBAMtUFKBO5ltWByrDKnD0JKLQRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795776959;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=3G+xvhsCWDrqUO09GyJxaXVyPj46MnnpxjVWQl8ShkE=;
	b=5R0cGqg67cqN1CGjyLbBC+ND2xTrMb1veAVxbHowfY6+SQfCib7ulQ3ZUi6tdjCropiz
	 IJFARTuNvq18Xce/jzP+VQTTxiU/ZYOEKOorO6GFqPUKBiyq5Pfk3DQMMEWDhLLWkP+5U
	 XFEomRXc7a8IdlxwrRroKtzpDE+LLXydN6SceDskhBTRYL8DDwpCy67rVh6U1r8OofBsr
	 ACZ34HEHCw2wIoFuMcuhkVuZFpp/U8IgFuESIYOfkCP+g1X3myoAaG8DU6bAnQ9UlVRB7
	 SqAlt/IZG//ge/3Xrzuk0Mnt9PmhST5zO5xTzAO1YOLAoltE++JtidFALLIxgW4nYyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="VvFgNG1/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C09606A31C
	for <linux-can@vger.kernel.org>; Fri, 27 Nov 2026 10:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6C09606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=VvFgNG1/
Received: from ptx.office.stw.pengutronix.de (ptx.office.stw.4.pengutronix.de [10.9.0.3])
	(Authenticated sender: relay-from-ptx.office.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D6522205A87;
	Fri, 27 Nov 2026 11:55:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795776956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3G+xvhsCWDrqUO09GyJxaXVyPj46MnnpxjVWQl8ShkE=;
	b=VvFgNG1/Pomlu8xhfS4CK9R3lEINiJylAhAifz90XB3UEq8tOlkmGZ6vwuhuePhL5bUjCP
	wlsmCDZSsmCaln1DMzGQjuRNoS3JkFISRqfvJdz+Z5E9hhIVRfUNieNw0qk2qhP6ouX6Q3
	wmZuT1X39B36yBFzR0PT/oKAQLAjMFtNqMbYZRIiEabE5ITd3867XEuPLoK8iGdFrh43fI
	PPVg39HovnPhM7W/GS/PlV+fTzg18sVhsnPu2JbKY+F4vUXtOLjV3Qepcaqv69EDCqXZrD
	48lm6uqCTRsm8vbmUjKV7f+rymymgAHFV+4AOUH4I+2BsYwq+ukTf873gYfZ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795776956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3G+xvhsCWDrqUO09GyJxaXVyPj46MnnpxjVWQl8ShkE=;
	b=RNZfHEc3om661NoCOyz+hetW0GsGpSdBbJ+ftWlop1VsuNLdu++slV7N0zVZzPRXzFZqxP
	s6tINIFap9aRU4JkNqHdf4sSEcWWIEAZLBdZ1jJ4OGLR90Kf9aGAcuHjVV/sBTzRZHvm9g
	ZqtiwjgDGoT39QckHziOIV2zl76bs/cViD8IMOJSqzomKK9cesISkhhFIaevuNDQkGrYnK
	phjcA3s2ZaTCGdDIjddx745CNFW/g9jHju/OiTHPGgSHCcwPnL3in58jzrgmX5qwtBuvzh
	Wd2Omgvoi/551EFPrY6u/0gWhCwSpOieaMiAbYtEh32h58yMMaOcqXzObqQJXA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-ptx.office.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795776956; a=rsa-sha256;
	cv=none;
	b=UA88/EaPMzCousbX4QrV+iCU76ssuG9Ub9zhUIx01J92whO730vwbV3Q/kXPa87pXXV77b
	pi0B+OT1/ZStCmUkr0dGTHATw5xITBiayDkE8S+h152RgsjSu0eAF2FHFZpeJeeP2GZ0Vs
	kNAly5GnO8FG8tT8MvIauNcyrZLf5GB6279OC7dMgTua+8lfFtz1EOPBCbKMWa2MXBD5Y9
	AMthkJXITzcmbC7LHkCS1rWDu2JQ7QkfrVznYNxt89WJfwq0U9DvWuNBXvNtKS6wJwFB/r
	jANYa31ZLw6FDh8eTUwc7i2mHEiGIzEmM86vCrX3OHyF+Hf4+CdWqWWeZVUAGA==
Received: by ptx.office.stw.pengutronix.de (Postfix, from userid 1058)
	id BF5E01BF4EE; Fri, 27 Nov 2026 11:55:56 +0100 (CET)
Date: Fri, 27 Nov 2026 11:55:56 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: sashiko-reviews@lists.linux.dev, Patrick Dahlke <me@patrickdahlke.com>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Vincent Mailhol <mailhol@kernel.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH can] can: j1939: don't drop the last ECU reference
 without priv->lock
Message-ID: <awlhvDKawNFb96WV@pengutronix.de>
References: <20261015-j1939-ecu-release-lock-v1-1-39dcb8a0f2f9@patrickdahlke.com>
 <sashiko-outbox-172364@kernel.org>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-172364@kernel.org>

Hi Patrick,

thank you for the patch and the careful testing, and sorry for the
long silence.

On Thu, Oct 15, 2026 at 06:47:20AM +0000, sashiko-bot@kernel.org wrote:
> > diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> > index cdc3c0a719379..ec8ee0f980fb4 100644
> > --- a/net/can/j1939/bus.c
> > +++ b/net/can/j1939/bus.c
> > @@ -19,6 +19,11 @@ static void __j1939_ecu_release(struct kref *kref)
> >  	struct j1939_ecu *ecu = container_of(kref, struct j1939_ecu, kref);
> >  	struct j1939_priv *priv = ecu->priv;
> >
> > +	/* priv->ecus is protected by priv->lock, so the last reference
> > +	 * must only be dropped with priv->lock held for writing.
> > +	 */
> > +	lockdep_assert_held_write(&priv->lock);
> > +
> >  	list_del(&ecu->list);
> >  	netdev_put(priv->ndev, &ecu->priv_dev_tracker);
> >  	kfree(ecu);
> >  	j1939_priv_put(priv);
> >  }
>
> [Severity: High]
> Does enforcing this pattern cause a use-after-free of priv->lock?
>
> If j1939_priv_put() drops the last reference to priv, it will free
> priv while
> priv->lock is still held by the caller of j1939_ecu_put().
[...]
> Can this use-after-free be avoided by taking an explicit reference to
> priv
> before dropping the ECU, or deferring j1939_priv_put() outside the
> lock?

This looks valid to me. Tetsuo is already working on that part in his
series:
https://lore.kernel.org/all/98c16a74-5ea7-476e-ab36-c98fb77b6be4@I-love.SAKURA.ne.jp/

Tetsuo, for your information: if I read it right, this patch addresses
the same list corruption as "Problem 3" in your v15 1/3, in a different
way.

Regards,
Oleksij
