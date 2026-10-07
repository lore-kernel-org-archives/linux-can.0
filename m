Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8DC44BC90;
	Wed,  7 Oct 2026 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791379248; cv=pass; b=hDa20DmSWWNSZjs0HYcC4b+VSJvw8qD/6xbCs+V8rts8bynSA3Bkr66xQe7DCtfA21giJSBK+wNMLeUtsJm+7YGzrX3MnN6oJoMMlIzJMsyPTomoSw6Ry+dPwZ9oRAV1/6mXgYDGPBYxd9BjLNY4p80o7/d/Sao/6DzDot6BWQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791379248; c=relaxed/simple;
	bh=44owMY168fuT1j6n81hB027nG02TC2f0ZAQMRI0mBgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=po7HRuYvGe6CNxJAlEz0wYAkphfVOi0clUrzrMPO8Cyg+F6n8Rv1R2Rjwow9/u4rOpmP5vI9m6vgNKnil5e9Hhp1vIupamK9XH7m9I9XLzyfQwa27D0CaWsiRKxwHMyDVMq760HVr+jMyqtk/roZJ5Bq0WiUKX5vpO2+7gPAqx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=CHAuXh44; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="CHAuXh44"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id AD61C201CE0;
	Wed, 07 Oct 2026 15:20:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791379228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bRxlxDvgWahl6AUZVEjz3a0mEJ8uQvHL6BYbwOeghSY=;
	b=CHAuXh44zJ9pcO2zF/ugLsQEExsKqgwOZ7lMzeoipCPyHFeBZuQp4cxChvqNV7uOuNRI1r
	3+U5/gb273WGSi0qCRxLW6Mv7Du47RjJ2oMh3OKhOedAnlN2em6VleW1gHpm0mnVJSn9TX
	sIL8kXP16OTwsG113BIu1PmJ88ogVqHGVetho6uy/VsYytHoDkyAlrAtnDPzR+mLf9aKYC
	YYW/6rkpcgWLIcChuZ3U5iCwnJkvsGPNTuxxyN7DWeD7efJRfz/RWNIbQC6EzRr+gqczm4
	5/jAAcYYNplZ7hwoA8HnvcAzwhrM9zRi1Gi/5VwiiNkPyqrpL8etw+j8Xl7ReQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791379228; a=rsa-sha256;
	cv=none;
	b=b1Fs7r2DZaGx2SM7JK/GZyZm5MyNF8arpeqW4ymcu4nuGTecEbxAxwdzpHqSrGKB0Xyb1p
	3XRVCv3sIqSyONLLowq0ba9FNQb/hPdWSrwu4eXr6Px5fE+MtBJXS0Ib2YNXvUP8uevYKd
	wBxmyb57GXXr+P4zEt12SBmDb0SPoV7hsZ1Huyg2yh3c/NgCcdMbbMlUyrpv7LgHXcN0Un
	53UlubCC/jKA60oIMg4eeKgchq9+T2EMxmmoDa7RKI9RylyYtIqwqBmvGVAry9/Pjiu+fs
	ENolNwJ25MtskjKLyhSDsUw7otR6u5eC0aHp3WM13DWzuc5DZ+k1TaliJSF8Dw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791379228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bRxlxDvgWahl6AUZVEjz3a0mEJ8uQvHL6BYbwOeghSY=;
	b=XAhFVzYRLEcO8YrnIxagZPaoenySJ5SLh26MgsftOYRW9Wo2HoyElNF/k88O05k5qKc0+4
	QCKHug4e6arU3YQcjzSii6vT4zpzKWJjdLC2pUB2Pv1XeKM8ZfSjvB9WRxOM5nHbog2Tx0
	YcTuKQulJKBSutapixIgM4CaMEy38rZH/qBr/kiVxNzO+wPTWNU+TXMuheF52XttiH1AyP
	Y/i1EUOrREROQYmoqnjxSLy27w+TChS0+1pWKKomtF+UbiFaGKylgC9K31XrYWj0agOUy6
	S6dBUErRYq54YvTeT4xkjg+BbYqAnvq9BQHHYLsI33NpTyHTitvpLt5SJSXpkQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xERZM-004iw5-1y;
	Wed, 07 Oct 2026 15:20:28 +0200
Received: from pengutronix.de (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 311C25BBAC6;
	Wed, 07 Oct 2026 13:20:28 +0000 (UTC)
Date: Wed, 7 Oct 2026 15:20:27 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Yogesh Gaur <yogeshgaur.83@gmail.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+937a3a1fbfbc99d6fcaf@syzkaller.appspotmail.com
Subject: Re: [PATCH] can: vcan: use per-CPU device stats
Message-ID: <20261007-rustling-congenial-kraken-8bbdb1-mkl@pengutronix.de>
References: <20261007113611.2082-1-yogeshgaur.83@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5jn7bctdt4riangw"
Content-Disposition: inline
In-Reply-To: <20261007113611.2082-1-yogeshgaur.83@gmail.com>


--5jn7bctdt4riangw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: vcan: use per-CPU device stats
MIME-Version: 1.0

On 07.10.2026 17:06:11, Yogesh Gaur wrote:
> vcan_tx() and vcan_rx() update dev->stats with plain increments and
> rely on the tx queue lock to serialise them.  That only holds for a
> single tx queue.  vcan does not implement get_num_tx_queues(), so
> rtnl_create_link() honours IFLA_NUM_TX_QUEUES and a vcan device can be
> created with several queues, each with its own xmit lock.  Two CPUs
> transmitting on different queues then update the same counters
> concurrently and lose increments:
>
>   BUG: KCSAN: data-race in vcan_tx / vcan_tx
>   read-write to 0xffff88811aad8228 of 8 bytes by interrupt on cpu 1:
>    vcan_tx+0x325/0x5d0 drivers/net/can/vcan.c:110
>    dev_hard_start_xmit+0x10c/0x380 net/core/dev.c:3969
>    __dev_queue_xmit+0xbfd/0x1ec0 net/core/dev.c:4958
>    can_send+0x584/0x720 net/can/af_can.c:279
>    bcm_can_tx+0x3ba/0x5b0 net/can/bcm.c:367
>   read-write to 0xffff88811aad8228 of 8 bytes by interrupt on cpu 0:
>    vcan_tx+0x325/0x5d0 drivers/net/can/vcan.c:110
>   value changed: 0x00000000000025ef -> 0x00000000000025f0
>
> Switch the packet and byte counters to the core's per-CPU dstats.
> The core allocates them for NETDEV_PCPU_STAT_DSTATS and folds them
> together with dev->stats in dev_get_stats(), so tx_dropped from
> can_dropped_invalid_skb() is still reported.
>
> Reported-by: syzbot+937a3a1fbfbc99d6fcaf@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D937a3a1fbfbc99d6fcaf
> Assisted-by: LLM
> Signed-off-by: Yogesh Gaur <yogeshgaur.83@gmail.com>

So far all drivers use the classic stats, and the CAN dev helper code
(in drivers/net/can/dev) also modifies these fields. A quick search
shows these places:

drivers/net/can/dev/rx-offload.c:48:     struct net_device_stats *stats =3D=
 &dev->stats;
drivers/net/can/dev/rx-offload.c:162:            offload->dev->stats.rx_dro=
pped++;
drivers/net/can/dev/rx-offload.c:163:            offload->dev->stats.rx_fif=
o_errors++;
drivers/net/can/dev/rx-offload.c:249:    struct net_device_stats *stats =3D=
 &dev->stats;
drivers/net/can/dev/rx-offload.c:289:    struct net_device_stats *stats =3D=
 &dev->stats;
drivers/net/can/dev/skb.c:29:    struct net_device_stats *stats =3D &dev->s=
tats;
drivers/net/can/dev/skb.c:402:   dev->stats.tx_dropped++;

Can you modify the code to update the dstats if they are active?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--5jn7bctdt4riangw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCasZHGQAKCRDMOmT6rpmt
0qZ5AQCi/q9WzXKRwxK0E21TYqyQe5NJ2OYeU1FUM0wL1e2goAEA2BAOJSQEi1nK
XXGqasAYVjqGJkPge5C8ADTbraxE/QQ=
=+GYo
-----END PGP SIGNATURE-----

--5jn7bctdt4riangw--
