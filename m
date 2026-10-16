Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626F93B5820;
	Fri, 16 Oct 2026 08:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792140173; cv=pass; b=YOkBd+inQTdvTMgmyAS5OpstrVGmCbEwXOg6pdZAo+5p0s7Mzup772VIA/D7y2CmKHjExhKpWHRjkzP5STZXofYRiRbp7z6rGqUG4HaEUJ6523zb+gCfOXJ2XYxwXJx0FWAgBnlUcrqOn2+dpkMS64tSI/9vkL9xfwEROfQ025s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792140173; c=relaxed/simple;
	bh=2ot9xwMfDVL6qCue7UJ8KB8GkkrXIWmfeL3NirAlb9Y=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=fnUcAVLPzfl0EOugjgKXGLxPLmvD1zdNFAaDTDQXkSnIK+rgu2GMx8akQDwSvMsLnyFR8S29vWXkz66FSIO9suRNiBDVuNU+XswJGPDtJ9rO3Bj6HVNuJJuLrahmpMw++8f7ETubERzXEVznm6I71gpsFrAhNloSq9YlUk54YUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=esJoF/Mn; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="esJoF/Mn"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 100592007F9;
	Fri, 16 Oct 2026 10:42:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792140168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vWznGaYZLYIhQHVFt1q76zV8ZoAZF4MamyVCcsrJ0Yw=;
	b=esJoF/MnONiyp6hJx7xmg5e0GxRrerppIy6kuiIqOiLtAeP1HPAgm6CP3YMtqaaJ9MEoxb
	AsluNDoJISbdlFu/HNwU0lSAnYqbMSXGDAHGujhNi9aA3lVWPkXFfRlkOFszZJmRlUXaFR
	pgBgMQTvB6y8EDnBg4uLdNXBa8lKBIrqjWanaWFayk7sI7OzUNmr8aOmMbdKRLs0m4Z3d8
	0UpSXBrUPuhYbhwkNUjTml3C/RVU3RQPFIbp10FHED0Zs8jizBhRmvMqYGBIjT1d9A5jWP
	rl7shFxLMJtTXrzhTSMl6E0GFOwHNshSN9PXnb8VgMfNw4/J03SRzNbnJwfPuw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792140168; a=rsa-sha256;
	cv=none;
	b=RnykvqnOu2PacdVLIbmbMACNcEkNoZ8LUUVfL/IbtScoM2RkZ9l30exBH5NZg34mImgKZ6
	AhS8Sf6n+I4lFc3aEgJwMfJdO0KKcQJ9ArlELCfBpvy/Zie2M1nrxQMJnUkYqdRWQ3CTTm
	/u/N1lY7OtvmX0KtYa1WjihecrPUnVKfhxc3o17aoAYpYaaUlFkPO+tRsXWr1rrcU6HAau
	m3OhtdfuGwXTvwPww4FMcVNJqaq9GXP0YOWKA03a33GkZyEFaWQzyroPD4FtVXomDnWKym
	9uCRH4XGD23u3wntFnspqHntZeXJkASUbvn6OROJ75QJzMbYbsE+WqmyIJfTrw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792140168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vWznGaYZLYIhQHVFt1q76zV8ZoAZF4MamyVCcsrJ0Yw=;
	b=WSg5artA9TaJtaD41eY2VvwpDkrowW3r3ypFKfIidhkgbNTgCwW4kyFGBJspaOyzcDpmog
	eUdcAYZXLoNi0iYNZvgafPoPGcX0BnIBmC/WFOEqdZ4W3KXQ6eQlkC8n8uiXrlJ+9Vaxgu
	yuRbufsLSADqwI58QmzWZEpRX/FbCR8YLuzSB0MyMMH5cIuwkMzjWl7az82QL28Gvt9yfk
	KHLybzZkWxvf1MLeHz/D5zCoec8dp0JhOFD/FgzpiAzo/GCmSY2n0dfGGZ5ksl7425JK4H
	6Q3/S76ONBQGn6X6sRRTVJRaZ7YTZ7+GtagaC5qd6lxT+yyQ3qDKjsXFEY6WBw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHdWZ-0069rP-36;
	Fri, 16 Oct 2026 10:42:47 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id ACBA05C5E25;
	Fri, 16 Oct 2026 08:42:47 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next 03/37] can: replace ARPHRD_CAN type checks
 with can_get_ml_priv()
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: mkl@pengutronix.de, netdev@vger.kernel.org, davem@davemloft.net, 
 kuba@kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de, 
 socketcan@hartkopp.net, kurt.van.dijck@eia.be
In-Reply-To: <179211822219.434549.7841003426566715206@kernel.org>
References: <20261015015336.816543-4-mkl@pengutronix.de>
 <179211822219.434549.7841003426566715206@kernel.org>
Date: Fri, 16 Oct 2026 10:42:44 +0200
Message-Id: <179214016466.1225518.8931119252169589153.b4-reply@b4>
X-Mailer: b4 0.17-dev-6be7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2772; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=2ot9xwMfDVL6qCue7UJ8KB8GkkrXIWmfeL3NirAlb9Y=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi6+LjlZ5cy/yQ18clCVpefMinnTon59vWks3HzJq/oI
 N/k8OwzHaUsDGJcDLJiiixLf5xQFAh0KO19mTAJZg4rE8gQBi5OAZjI7ShGhtOMfrdanhbltHKc
 cFqwe1pX7bXa8Lab4j/unD4T915s5yRGhoXXVz43a3Xon95f2Xv+hV+pr0VJwdvlQbPvtKSfF8w
 7zw8A
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

On 2026-10-16 02:37 +0000, netdev-bot+sashiko@kernel.org wrote:
> can: replace ARPHRD_CAN type checks with can_get_ml_priv()
>
> This patch replaces the remaining dev->type == ARPHRD_CAN checks in
> af_can, bcm, gw, isotp and raw with can_get_ml_priv(). The goal is to
> keep TUN/TAP devices that were retyped to ARPHRD_CAN via TUNSETLINK away
> from CAN code that dereferences a NULL dev->ml_priv.
>
> Link: https://patch.msgid.link/20261012164802.94113-1-socketcan@hartkopp.net
>
> > The TUNSETLINK ioctl allows a down TUN/TAP device to set its hardware
> > type to ARPHRD_CAN while dev->ml_priv remains NULL. Such a repurposed
> > netdevice passes the ARPHRD_CAN checks and triggers a NULL pointer
> > dereference when CAN filters are created and when they are removed,
> > e.g. by the CAN protocols' netdevice notifier handlers.
>
> [Severity: Low]
> Is the "when CAN filters are created" part accurate for this tree?
>
> Before this patch, can_rx_register() already rejected such a device:
>
> net/can/af_can.c:can_rx_register() {
>     ...
> 	if (dev && (dev->type != ARPHRD_CAN || !can_get_ml_priv(dev)))
> 		return -ENODEV;
>     ...
> }
>
> can_rcv(), canfd_rcv() and canxl_rcv() also already tested
> !can_get_ml_priv(dev). That makes those four af_can.c hunks look like
> simplifications that don't change behavior. This holds for kernels
> that already carry commit 8aa59e3559494.

The anslysis looks correct to me. Oliver, can you re-spin this patch
with an updated description?

pw-bot: cr

> [ ... 26 lines skipped ... ]

> The code change itself looks complete. No ARPHRD_CAN checks remain in
> net/can/ after this patch.
>
> > diff --git a/net/can/isotp.c b/net/can/isotp.c
> > index f5dc9d04bd68..6c28802c0605 100644
> > --- a/net/can/isotp.c
> > +++ b/net/can/isotp.c
>
> [ ... ]
>
> > @@ -1610,7 +1611,7 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
> >  		err = -ENODEV;
> >  		goto out;
> >  	}
> > -	if (dev->type != ARPHRD_CAN) {
> > +	if (!can_get_ml_priv(dev)) {
> >  		err = -ENODEV;
> >  		goto out_put_dev;
> >  	}
>
> [Severity: Medium]
> This issue was not introduced by this patch. Further down in
> isotp_bind(), the return values of both can_rx_register() calls are
> thrown away, and the socket is marked bound anyway:
>
> 	if (isotp_register_rxid(so))
> 		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
> 				isotp_rcv, sk, "isotp", sk);
> 	...
> 	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
> 			isotp_rcv_echo, sk, "isotpe", sk);
>
> 	/* switch to new settings */
> 	...
> 	so->bound = 1;

Oliver, can you add error handling for can_rx_register() to isotp?

-- 
Marc Kleine-Budde <mkl@pengutronix.de>
