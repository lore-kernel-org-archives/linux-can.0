Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793084988;
	b=IS50CK9bhyEfsQlfrNFTzNgG+mkPkW6PGTC4izX/HPgdoUoECy4tAe0bo8TiX2Gs0YpY
	 gYLlnVPXrw+ouyZsBLKMOwyxE5ouuwOeHIaQ9bdBjL/am6KaTxfcNqtoF6A/6yEG7ATmv
	 FV6/ZfiOcoJ1zugydJ/bOeOGO4Tfb5YteT7wcKrm7LaikyyYlzAaav3vr1618coccbJxe
	 knmFkazGXh1FwBNJCHn5xjwTCu9ABw0pK9yNrLi8BABxBA4rr59yWisjT3LhTRLzIxjdC
	 KZdno5UeuvFOuM+l6Hc9IteWjXf9KZs1qev/j4mWloyYThBqKtYH/qIolOy6iLxyedg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084988;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=SaEodcO3nIPEzJo0wn93K6IKt2epHat9bxFOrPGVx2U=;
	b=NqIJsjMmaHW/L/TbMbqErqDoCB7Au1sRyZjdXtIoJYIui8Fwlqqr/o5EvRSws4JNrth6
	 J5wdssKwHtGJxB8uyx9yr68s6c2No3jSEfYoBR8QdBPh+OF6AiVdYi9O7SOOM88EfqK+T
	 0jUGw72IW+x9Ekzo9hGp8CHOXHQvtijNk8nbKkPMiEM9XlFuqNb4U/si03Sw8NSDTxo5g
	 lzJl3QouAMaaorZfi+60/G8wtyKhhsiGrkoJEJ99Lzmfn4Sz8qgjRrMDXiwK17XZWjxWL
	 23f1P+yMwDxt1+W35ZbEKt3DLHwfijPoAckYVolXVLuMLlLS8Rj/6YikDCJMGN+Mkrw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=O5uFjv9L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C232E606A31A
	for <linux-can@vger.kernel.org>; Tue, 27 Oct 2026 07:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C232E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=O5uFjv9L
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 927E8201F0D;
	Tue, 27 Oct 2026 08:09:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793084984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SaEodcO3nIPEzJo0wn93K6IKt2epHat9bxFOrPGVx2U=;
	b=O5uFjv9LOl4BbNEvCfIULvZAnPknpmVcJe06SXjqoMsQhY8iAc3/qaXpEQ3TZd2eqf9yv9
	Kr4Q9E9XBjKsHvYeuLsxd/7IgtpTvOf3qbA4GTVlbw4KbGpLk3RLN4SzEAvKXa5s5BkXNf
	upvMpNS7W0Ir71nSFgrSepd0GtdDIT5q2hy0Dq+pBOF8eQtczZUv6+8BiuvI/Xfp/W3T4y
	hLqa/nz9ylD4BPfnZMo46pL+9JuL9bY6C4kexWv9QmgE7h83/kUTHPU+ecRFwrpv4Hx/Ou
	OGxWWCbvLHNeGBKrjLZbPMB7VBGLpkzKWKw8kHsyhzjJi04hMZQkardLXDFg4w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793084984; a=rsa-sha256;
	cv=none;
	b=S8aND0qKMMZ+BWz7WAYjmefoGTnhoIxMEN6BgxcFmTxgNwW2Je3VTAy/ox1k7tVYSR3iVP
	IgTb5qjst25EzJWjIqzaIvLrX/209dLzBZyJyqCXKayHVXQO0aynT10x4mjpi0BpJijQ4x
	D6Yaf6K0NvQxzjoheCJUxKL33/TAe2O+2LRy682a0EHII60g1oHE0H6rfJwGItcDPVifAr
	v3LMz/c3D+8ahiA/NbdVbKL5XKiBE7v6DZWEf227BXRuULisFq/iLvfm1BCXV+hOW2w9M+
	FiihNmd2nshDV8OW97grlJtUfhQjIilfEwDeMBQ+HLoPw2Ad+qKCPPkNWj3EmA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793084984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SaEodcO3nIPEzJo0wn93K6IKt2epHat9bxFOrPGVx2U=;
	b=FJQmq4qGiDCh00QHzc5ONs4gXPi/o8wGTNzZby096M9oW9dQq3whUrlIUlThYfIeTqYT+r
	ImI4zphxVPHTzSE7rF7sUc+DLVCgmNa/j9qPFI/DE1Zy0nDig1vfM/pPAk+rPLNKORQeCI
	gvon1qSuafRdh7bDsKE+ahY6PkvAxa7Opu7esKTQMCi/MWdqTFOy3rmlsxfIjvFgSRQ8WB
	g8t4HWzb/rWMAPFRWnYylOAmN8JCIEBEtGqw63I5dyFWy/57Rz/9S4zgNgmgiqffywzkxm
	3zqaAXX21pIwGsK+70knzwIsq/yp4I2fIHGTN3VRt3aN8eThYUvaark+mMy7EA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xLbJY-001Ock-1d;
	Tue, 27 Oct 2026 08:09:44 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3A13B5D78D1;
	Tue, 27 Oct 2026 07:09:44 +0000 (UTC)
Date: Tue, 27 Oct 2026 08:09:43 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH v3.2] can: j1939: fix j1939_ecu refcount leak
Message-ID: <20261027-silver-mackerel-of-symmetry-5b5b66-mkl@pengutronix.de>
References: <7df4f6c6-b53f-42d6-9725-e60b763d01f6@I-love.SAKURA.ne.jp>
 <3958917c-1484-41e8-8d62-99575edbf980@I-love.SAKURA.ne.jp>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hlgcc3xl7y6ap5zi"
Content-Disposition: inline
In-Reply-To: <3958917c-1484-41e8-8d62-99575edbf980@I-love.SAKURA.ne.jp>


--hlgcc3xl7y6ap5zi
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3.2] can: j1939: fix j1939_ecu refcount leak
MIME-Version: 1.0

Hello Tetsuo Handa,

please _always_ send CAN related patches to the CAN mailing list.

Don't invent a private patch numbering system, only use integers for the
revision of your patches. After v3 follow v4, the next one will be v5.

On 27.10.2026 09:22:49, Tetsuo Handa wrote:
> syzbot is reporting "struct j1939_ecu" refcount leak, for
>
>   j1939_ecu_get(ecu);
>   priv->ents[ecu->addr] =3D ecu;
>
> in j1939_ecu_map_locked() from j1939_ecu_timer_handler() can succeed
> even after
>
>   priv->ents[ecu->addr] =3D NULL;
>   j1939_ecu_put(ecu);
>
> in j1939_ecu_unmap_locked() from j1939_ecu_unmap_all() from
> __j1939_rx_release() from j1939_netdev_stop() has completed.
> Fix this race condition by canceling address claim timers from
> j1939_ecu_unmap_all().
>
> gpt-6-astra, opus-5-5, opus-5 and sashiko-gemini are reporting that
> above-mentioned change alone cannot fully close the race condition.
> Fix remaining race condition by allow getting a ref on an ECU only when
> three conditions (a netdev which is associated with j1939_priv is still
> registered, rx_kref which is associated with j1939_priv is still alive,
> kref which is associated with j1939_ecu is still alive) are met.
>
> sashiko-gemini is reporting that there is a possibility of list corruption
> in __j1939_ecu_release(), for not all callers are calling j1939_ecu_put()
> with priv->lock held for write. Fix this problem by deferring release ste=
ps
> to RCU context where we can unconditionally hold priv->lock for write.
> By deferring to RCU context, readers might find ECUs which have already
> reached __j1939_ecu_release(). Therefore, allow getting a ref on an ECU
> only when above-mentioned three conditions are met.
>
> gpt-6-astra, opus-5-5, opus-5 and sonnet-5 are reporting that there is
> a possibility of deadlock between j1939_ecu_timer_handler() and
> j1939_ecu_timer_cancel(), for the former holds priv->lock while the latter
> calls hrtimer_cancel() (which synchronously waits for the former to
> complete) with priv->lock already held. Fix this problem by using
> hrtimer_try_to_cancel() with "release priv->lock, call hrtimer_cancel(),
> hold priv->lock again and restart from the beginning" fallback.
>
> Reported-by: syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3De2af46126e0644cbebdd
> Link: https://lkml.kernel.org/r/179202402875.794844.18141702206663586949.=
b4-review@b4
> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> Assisted-by: Gemini-Pro
> Assisted-by: gpt-6-astra
> Assisted-by: opus-5-5
> Assisted-by: opus-5
> Assisted-by: sashiko-gemini
> Assisted-by: sonnet-5

Since commit 1e035297ffda ("docs: remove Assisted-by references") the
Assisted-by: tags are obsolete. Please remove them in your next
iteration.

> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

regards,
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--hlgcc3xl7y6ap5zi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCauBONAAKCRDMOmT6rpmt
0qdWAQCWfDtFjYT2Zr6MctSRMY0GvUfrUJUiPu4wHw7golBEiwD/R2NOBZMYWyRH
RMlWZap1qmgWpnV5Lr3RZA2DWUfKJgo=
=qHeA
-----END PGP SIGNATURE-----

--hlgcc3xl7y6ap5zi--
