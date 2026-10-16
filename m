Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E88466AEF
	for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 12:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792152915; cv=pass; b=o76iMaQ1quDBkOqnA+ovQmua6kg4oDwjjSATy6pEfqOMbv/gPFBMIuB1WLw4rWgKZ5aNw/kgDTd37f3Ing0jjyVI+n7ie01vARN8P6xDP9qV6PwP09BPn5uH1d+oq41ycVZPBwAPE/V+AIrnXpx8uxdDSQiSA5fTEqamvWLZ+2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792152915; c=relaxed/simple;
	bh=IMcCGJZgqQmkmXW4kDDR77x/Ch0Xv/eEUtva+e899ac=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=mAgELzjdSTyOTpQLcJ7+cz7IPzuQpaOWXwx+Jl/E7UetcieFMfIWsPHTtfJoJnEkXzVoaOZMKBVidTNuAi7H0QGLU+SCqPajfPJRzPWM4PINBZJoQA8AS0XJ4fE/3gGoVNM6vGCqNfu92Si8O6M/WqibRpGup4jhTz0mmRddrfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Qkd7XmDn; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Qkd7XmDn"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 8AD07201260;
	Fri, 16 Oct 2026 14:15:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792152904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Werbc4zFTy+P0b8VusJPTvqKs2xzl+rdPJLironlip4=;
	b=Qkd7XmDnrdETLuEYsphBHPTa1xlvbJKDha5iRuXoDaWWZKDOku1zDuCId5tn371ZwtXZb1
	9d/CUlRx4V7N3X8V4XGY6HioVRnNs4iZ1d0/447imOk0qNYUPfZq4YQPHbmI8l1efrKRsu
	BWcU7AYyYya1HImkHsqFK9+l6VbJibK39qJw3e1UaVdwuAo9mWIl2yOC5sjTOOxaQd4LWh
	HdhLumsDWOf9nqY+5F5mhsgsNJLQYSY74CbvJ3R4asvvHDwOkFBtVhF0Z2jq+NFJMlzoNS
	ixiaP85zxs4BJ++/J2jcORId4RXExea1cHNlBX69/WITm6t2RfCZ1sKJjtRBeg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792152904; a=rsa-sha256;
	cv=none;
	b=Oo8E7NwSCPdJ8N7fc40IZ+QhrMN9E35PnW3aWpK8/nqZJ75py+b+wzlHXbhqoyOzDmBxYQ
	x1CpaB7zedv4u3o4w9rY9jzNteYDpuxugyQ1iIfzttSamodi+RaiOcyCT8AA5kUP8LuN5P
	LaUg1gexrvuGD671jxJoeQcZinulhY/UJ590EM1xUY4CpgomAGaazj6BmeHxLUncA2NL9w
	Q5XBSF/F1D836cB60D7kb+Cfb/C/rNFqKTi/87WGT/10V3U1dC5msf3yYHleyPm3ZAIaLA
	nzNLp86RJW3Z1eyUMfaQ2kTV/F4Gd9MAdba8ikA6J3eez+TS5sFewyc7NXkbPQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792152904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Werbc4zFTy+P0b8VusJPTvqKs2xzl+rdPJLironlip4=;
	b=drWMSXYU9kR2ZGeGzL5zT3SSAYARAI8Zk9XkD7bR4WEdNcbVhB4pox/zbFgYXOidXVBFx2
	eaXhRouQD11sAuFS17oXkEi0ksIjC+qj3hX9qCuw2zqdmKK6IyfuFqRUVlw8EqTiBNvev4
	GUGruCiWgj0NYYfR4rJhCCOYF06qwc3mxdBOiUXTgUFIYwgioE2ZrOQjsZNz2yYWGlNflD
	VoqpvzYzsJCLsTg6nbAG06+t3prDXFNGGD5XQj8deaOBgP4J/fr+ihEHtovXEZXjJKQ0h9
	vsSFInxq7p23jaE8HZFgVVT2HNQ1C2ig4b5/gfFvX874AoyT4KshnwdrYat3OQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHgq0-006BNF-1P;
	Fri, 16 Oct 2026 14:15:04 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2C5365C6148;
	Fri, 16 Oct 2026 12:15:04 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH can-next v2] can: replace ARPHRD_CAN type checks with
 can_get_ml_priv()
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: sashiko-reviews@lists.linux.dev, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
In-Reply-To: <e71563e4-2d8d-4302-a9d1-b0dc34fea3a1@hartkopp.net>
References: <20261016093525.327367-1-socketcan@hartkopp.net>
 <sashiko-outbox-174104@kernel.org>
 <e71563e4-2d8d-4302-a9d1-b0dc34fea3a1@hartkopp.net>
Date: Fri, 16 Oct 2026 14:15:00 +0200
Message-Id: <179215290023.1285626.1847782701765808982.b4-reply@b4>
X-Mailer: b4 0.17-dev-6be7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1812; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=IMcCGJZgqQmkmXW4kDDR77x/Ch0Xv/eEUtva+e899ac=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi6JOpSflc3MDqm++6Xb+9f9lYeYIznfdt3wUDp0Y62W
 GbtGp3NHaUsDGJcDLJiiixLf5xQFAh0KO19mTAJZg4rE8gQBi5OAZhIzQqGf0pTu6oyZl/YVueX
 nfHBt+2R360tfukVLHv7DvSqJqxY8pWR4VHwKb3mB58nCn71dlynuv2GkM5dr5WR6lc73b0sVkt
 O5wcA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

On 2026-10-16 12:02 +0200, Oliver Hartkopp wrote:
> > [Severity: Medium]
> > A few lines lower in isotp_bind(), the return values of can_rx_register()
> > are ignored:
> >
> > 	if (isotp_register_rxid(so))
> > 		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
> > 				isotp_rcv, sk, "isotp", sk);
> >
> > 	/* no consecutive frame echo skb in flight */
> > 	WRITE_ONCE(so->cfecho, 0);
> >
> > 	/* register for echo skb's */
> > 	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
> > 			isotp_rcv_echo, sk, "isotpe", sk);
> >
> > If can_rx_register() fails (for example, returning -ENOMEM due to a failed
> > kmem_cache_alloc()), bind() will succeed but the socket is not fully
> > registered to receive CAN frames. This leads to a silent failure where
> > user-space believes the socket is successfully bound, but no traffic will
> > ever be received.
> >
> > Could this regression be prevented by checking the return values and
> > propagating the error appropriately, or cleaning up any partial
> > registrations?
> >
> When this patch is applied isotp_bind() can only fail with -ENOMEM and
> nothing breaks. The socket just becomes unusable. And if we have -ENOMEM
> we have a big problem anyway.
>

Please run "b4 prep --check" before sending patches:


I've taken the patch and fixed the checkpatch warning, but I suspect the
netdev sashiko will complain about the missing error handling, too.

> If I would provide such a patch the proc pointer removal patch would
> break next.

I think this is not an argument for sashiko :/

> I have ~20 patches for isotp and its CAN XL support. I will add the
> isotp_bind() error handling there when these current (can-next) fixes
> are in mainline.

regards,
Marc

-- 
Marc Kleine-Budde <mkl@pengutronix.de>
