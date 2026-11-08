Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794126199;
	b=0lZPE+03wXka7mmStNO/x1XfQVBWFgnln4QP++ZAkfbzgo58G57N0qT7HGgOdjzHNEna
	 +EFg2f3Z8hfoTnbu8v7TU/FHSM4dybr9r/B+Ci3Dg7epYCP9AY07qA1blZ5DNAj3W/sQs
	 T5KWuA9DPVFAq/WyrjnvaBpOuN2ZA0aJDKmpiMQ5qZ4rOzNOzhbgRE3eDB0aatNOyUuZk
	 3RY6Gr/qmoT0skpBmsL/lemIzbqM3Umh5Z3PItEJdRvATQblzX28Xtm/jIXbohbZiUysy
	 aOpjMspYcpCTGN5Ts6rtL6Tsf1Dddb7GUEljTOWVKCEYusd3lDap4A1N0XrpvkJqHDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794126199;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Sent-From:X-URL:X-Accept-Language:
	 X-Accept-Content-Type;
	bh=IxdL5BpGocD2sGutsCvyx2OcVwvkEo9eSftKOMEkBbA=;
	b=ykBA+54K8vkz6bcW7E/pLUKIklnOkvSfhcO56jvc3jwLTieLPciYBFi1b7ZXbCo4rNUz
	 lzNSL2d4CjH7GmE/GeVc5AckI30WS/Td9qWF8l+MXExiIPYbvyn+Oyld/D+9ap25h+2qY
	 2MOvhYmsiZYzmIZqJ9FRVs3LGm4t4iDuJeLIYJPq7DuvqBW6/i/39s2lhohrmB1z1YEJm
	 jV3Xt7qvAyl/KuoDGhPFPvmLuMFyqlp9gK6F6a1RP4gp4LPCHw/TEjPnW+zil62spyK8q
	 tGEV/40KhOMHoU4gCz9isOe0ewdM63GjkLRFrdR0sR5HXsBwaCmCFbX9Yrt2v8JsajQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=dH7bEAKR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD5F606A321
	for <linux-can@vger.kernel.org>; Sun,  8 Nov 2026 08:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FD5F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=dH7bEAKR
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 7CFF82006B6;
	Sun, 08 Nov 2026 09:23:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794126195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IxdL5BpGocD2sGutsCvyx2OcVwvkEo9eSftKOMEkBbA=;
	b=dH7bEAKRmFIWt+ubYaLL4QUEbG3qfv4A9r69EfGeVHf9LPiMhgFYHcl4MensagtS9rR5P3
	EDMORORuYuHEBxm+BGj4xNvl+VBG4y5OZlz33vSkstV04OpOWrs4qKSH47QoEOpKgxQG9X
	Smy+xwzeNTpfcNzMjhh52PRdov59MG3LQK2NZGgX8dBBpOppaBsre3ks6m6+T+5CBlDa7f
	Xoe/tJIyazB5k9pMunNs1VrcgBtmkZn3QW3Gvgl6hlCRkPE9GLvLeMBJnn5w7VdSKs04X9
	owUmbWgwonGzdMN0xP0Sk9t2qY58PFnqfWSoo+jl4dcpncoQM3dyd3wj5rtDbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794126195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IxdL5BpGocD2sGutsCvyx2OcVwvkEo9eSftKOMEkBbA=;
	b=T8dPimE5f/x/47QdBnfDOd+2oIQbm4pDfYK/AUs5s2aZa6VjnaVBicovR+dbDcYJYKiKMk
	TCD8j1gdBtQjGoPpPEmgNBz/nZ2Sc5IUcFp0qly6kiHTeqQsnyIK5vFsbT73Xufe5/wrUl
	xvxpMzQGj7mzEg1QWLsyD9nqhkL25pjr7Lk1Yfd6r/3OcqlqWnBHEAeXnVHHsrNc0rd3rI
	EfoIcbzPFtOoZ0Uuk4DccRtLTkcjBsHQqTpCfJARa+TVD+DoKu02OYWurOV1VhKZ5IAxmU
	reDSoTyTwaONK2uUGUKsfFu5RUJZwKamU5wRiCeAB8gY2GKazN44qrWtvwiQUQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794126195; a=rsa-sha256;
	cv=none;
	b=CjHEsnOyIDeIoLPXzzn8u19TLAbZXw0dxGsLOR4qwWR5RkpqdwLcBasDLoX45PBbCbJwj6
	0709V2RXlY8C0s35VFoIFsdPkNfCEzDyRtHql0kSyBO+uoYu6i8rgo/Bu+DrVpXegnqOxL
	1ebosM+0PBtyDilbn3h4aUltm9pVYPVU/08kP9RHzD38xYyLv+PEx6l/FtzgaYTjH/ePKa
	F5id8C4EcpATWfKKDnugk9lkj/HnGaHHIRdMKDY5Yq0f95lxERxeM1IiyRBIaebqYnQ+pY
	DHaEvmIqseBJvfELsHjM+v8ZBKHqRRd206r8X9JzXgc5QnxYu6HpGVZ241el5A==
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xPyBH-003AIu-1P;
	Sun, 08 Nov 2026 09:23:15 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xPyBH-00000006JVa-1PoY;
	Sun, 08 Nov 2026 09:23:15 +0100
Date: Sun, 8 Nov 2026 09:23:15 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: sashiko-reviews@lists.linux.dev, linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [PATCH 3/3] can: enable memcg accounting for user triggered
 allocations
Message-ID: <avAxc4PqfptAXTy_@pengutronix.de>
References: <20261107-can-bcmlock-memcg-v1-0-482d9f5be1fd@hartkopp.net>
 <20261107-can-bcmlock-memcg-v1-3-482d9f5be1fd@hartkopp.net>
 <sashiko-outbox-202902@kernel.org>
 <86c9e6d5-911b-4329-81b7-bb611a9f333a@hartkopp.net>
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
In-Reply-To: <86c9e6d5-911b-4329-81b7-bb611a9f333a@hartkopp.net>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Sat, Nov 07, 2026 at 02:35:20PM +0100, Oliver Hartkopp wrote:
> 
> 
> On 07.11.26 14:14, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found no new issues
> > in this patch, but noticed 1 related pre-existing issue it does not
> > introduce:
> > - [Medium] can: j1939: non-zero setsockopt return value in
> >    j1939_sk_setsockopt_flag() [1]
> > --
> > 
> > commit b3ee6688711331e68a7e275f9b72d5b3fa8b7ee5
> > Author: Oliver Hartkopp <socketcan@hartkopp.net>
> > 
> > can: enable memcg accounting for user triggered allocations
> > 
> > This commit enables memcg accounting via GFP_KERNEL_ACCOUNT and
> > SLAB_ACCOUNT for user-triggered allocations in the CAN core, BCM, ISOTP,
> > J1939, and RAW socket protocols.
> > 
> > Link: https://lore.kernel.org/linux-can/350df96b-5f69-490e-b39e-ed6e9bca4754@hartkopp.net/
> > 
> > > diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
> > > index 50a598ef5fd4a..c832465876049 100644
> > > --- a/net/can/j1939/socket.c
> > > +++ b/net/can/j1939/socket.c
> > > @@ -716,9 +716,14 @@ static int j1939_sk_setsockopt(struct socket *sock, int level, int optname,
> > >   				return -EINVAL;
> > >   			count = optlen / sizeof(*filters);
> > > -			filters = memdup_sockptr(optval, optlen);
> > > -			if (IS_ERR(filters))
> > > -				return PTR_ERR(filters);
> > > +			filters = kmalloc(optlen, GFP_KERNEL_ACCOUNT);
> > > +			if (!filters)
> > > +				return -ENOMEM;
> > > +
> > > +			if (copy_from_sockptr(filters, optval, optlen)) {
> > > +				kfree(filters);
> > > +				return -EFAULT;
> > > +			}
> > >   			for (f = filters, c = count; c; f++, c--) {
> > >   				f->name &= f->name_mask;
> > 
> > [Severity: Medium]
> > This problem wasn't introduced by this patch, but should
> > j1939_sk_setsockopt_flag() return 0 instead of tmp [1]?
> 
> This might be a can-next topic and has nothing to do with this patch.
> 
> @Oleksij: Would you like to take this suggestion?

Ack, on my todo.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
