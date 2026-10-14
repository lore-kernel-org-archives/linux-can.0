Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3D34E4329
	for <linux-can@vger.kernel.org>; Wed, 14 Oct 2026 23:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792018858; cv=pass; b=jkzdlYZwnwfrTlZp+De3vnzr7ku/tu4p2dhieFpGC60labxurdZ0FacOCO1wyK+8LPXFkcwyShxJg2JhNjcbi4mm1vp3BtQqy3I0v2yLWYIV6afuDeYsYyOmARlOTaU/pwWQLIKmcNPBcwqdeZihohuA7tOtYplhvVos9FYsSJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792018858; c=relaxed/simple;
	bh=Q+5UteLDkO7Wj+PfavEvKd+yfPgEdHS25muJYiTZpBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHnFs0aJTYczDighDMGuQXMhkzXJg9kLohMiLdJNXulRgHzpPoq8URVrXz0tCrgS+2a2Aqg2HUgDzZ0DYj+zD+eZmWVdIdy+TIoEaI3M4NPn0J7aI1zhStbkcDDW7GcHn/xWDVE+VVOOSEKXqb7dVyxPK1Cie6X3qCzrSUUHDgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=NvzIFRtk; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="NvzIFRtk"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4F8D5201ADE;
	Thu, 15 Oct 2026 01:00:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792018846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KizdcPwZw2b0QZzwjL/B4CxzoIM/fk2OSZhzAxztoCs=;
	b=NvzIFRtk+N82K2OoZeXHn2PoxmVlBWG4j0qXAJYV5G+AxfmwLBNDSy1WD2IMz/0jfaZFCf
	WoJnncD6+zSwDi69sV9uzfpg2SI68+CcmzoF4+SfP1tA78KXlWx+P3vpkZT8ohAYdBQAQN
	eqDYAqA8CdbGQ8cTWdPk08dW4iNQ/xBcgI6mLmCLUH5WCsHOfa095teZoUt3ceICoepFr2
	IogqmTp5fO0zETG7qtWYgVLD9XgOi+PI/hOJcVieGRDKQKBusOwPIG7Kfax/imqwfMHABS
	3nEusiOTspkp9hCn93RpzIP/CswDaWx0sbUnEBb/OG239nwGB9yJI6TGJGEA2Q==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792018846; a=rsa-sha256;
	cv=none;
	b=T7g+Yho7N2IDXcolrdwZVQh+Jxh4GnbCAOWhayojOak4ZUgG5FU1Rs/hDCONTUK/rEl03Z
	l0wIkYuwOci3eF2XTMODI63BKXiH1vEzIgkv0fRkfX8g7wipmcDrreh13R1V0sObWYo8Qu
	J4487+KnXdrm6tvBISly1CWN8xJU8GNniPUm3SeWK9iWayatw98rs19RFmjhFSbeAKUzFa
	bjpD1gWiLPiGJXYn5yikqTTtF/uoc577b0WytP63vqG4B5hKvyczM1PNoKPknEV5xHT1u6
	zmocA4Tw7cXsTThcbr7EW4rCYjWg4KDzGpM0EsY6TwKXxiFAGuwTlDnn+UqGpw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792018846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KizdcPwZw2b0QZzwjL/B4CxzoIM/fk2OSZhzAxztoCs=;
	b=B6uNHPYEIBlt200KnaF3odbfkkxSLKbcDoXPWiU6IYU5U17SH3gJgGoJzMXHS1Kk+/c7XZ
	BKXB87yrXAcILeacAPhltkfsacpcWE+Q9d9ha4tTGn3sGNm/yTdslS2ozNZGG/yUP+cEW8
	k4xpGntYbie67MQZGbAf+kC37aVYbXrTAIG1DkLxgv1AVcJJasi8+hvNTyGjd0X3E57mqK
	4paQ+I81SRiJc76rFj2CpplhyTr3jMgZRWH4+5czCV6HTTiYEIS9Hm0LQBwrYBcYSoEdox
	9l+uY44tMNw4xDbdqSUOzT28ogm8qirDBM5lL0b92i6z1Lurg/4roBI2VR+0fA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xH7xm-005vcY-0e;
	Thu, 15 Oct 2026 01:00:46 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E6C445C4621;
	Wed, 14 Oct 2026 23:00:45 +0000 (UTC)
Date: Thu, 15 Oct 2026 01:00:45 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v2] can: bcm: prevent thrtimer UAF in rx path by checking
 RX_NO_AUTOTIMER
Message-ID: <20261014-hilarious-bold-jellyfish-f47b11-mkl@pengutronix.de>
References: <20260519113806.85456-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hpakqkmkmsrf7lal"
Content-Disposition: inline
In-Reply-To: <20260519113806.85456-1-socketcan@hartkopp.net>


--hpakqkmkmsrf7lal
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: bcm: prevent thrtimer UAF in rx path by checking
 RX_NO_AUTOTIMER
MIME-Version: 1.0

On 19.05.2026 13:38:05, Oliver Hartkopp wrote:
> From: Lee Jones <lee@kernel.org>
>
> Commit f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly
> synchronize_rcu()") removed the synchronize_rcu() call from
> bcm_delete_rx_op() and introduced the RX_NO_AUTOTIMER flag to prevent
> timers from being rearmed during deletion.  However, it only applied
> this check to op->timer via bcm_rx_starttimer().
>
> It missed the fact that op->thrtimer can also be rearmed by an
> in-flight bcm_rx_handler() (which runs as an RCU reader) via
> bcm_rx_update_and_send().  This allows op->thrtimer to be queued after
> bcm_remove_op() has already cancelled it, leading to a use-after-free
> when the timer fires on the deferred-freed struct bcm_op.
>
> Address the omission by checking the RX_NO_AUTOTIMER flag
> in bcm_rx_update_and_send() before starting op->thrtimer, effectively
> preventing it from being rearmed concurrently with teardown.
>
> [Hartkopp] Added the setting of RX_NO_AUTOTIMER also to bcm_release() bef=
ore
> removing the CAN filters following the bcm_delete_rx_op() approach.
>
> Additionally WRITE_ONCE()/READ_ONCE() macros have been introduced for
> the changes of RX_NO_AUTOTIMER at rx op removal time to prevent a
> potential code reordering of RX_NO_AUTOTIMER setting after CAN filter rem=
oval.
>
> Signed-off-by: Lee Jones <lee@kernel.org>
> Co-developed-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Fixes: f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly synchron=
ize_rcu()")
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

This patch is obsolete, right?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--hpakqkmkmsrf7lal
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatAJmwAKCRDMOmT6rpmt
0pdoAQC541gjyxhDT9DA7L+Ceqdz/yATaR4b7Zg2J7TARhyBSwD/Y/S2VuOE+80P
uRIUcojpRFU0jK5qDkrYQRRRvNIBDAo=
=h8sR
-----END PGP SIGNATURE-----

--hpakqkmkmsrf7lal--
