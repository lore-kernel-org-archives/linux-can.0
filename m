Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3FB2E03F1
	for <linux-can@vger.kernel.org>; Wed, 28 Jan 2026 10:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769595909; cv=none; b=BXnZaStpZI1CgBo4No7K6Y8mGVsA+v0B8JCnqaNUJKng3mrEy7tZN4ZLY4k/pfhQu/gK8IESu8vNB7yjLhAtRTyUjY0CGyUWo/f6OBk9MgYXyzzT4waqE6ARoNT8oyoAStzjf6TPS607qTiX+IQzh0sgRND7IFRaLT0qvjSYGhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769595909; c=relaxed/simple;
	bh=hKabK5zv/WRe1rJMY92DSIPnBMkSOQwD5707+hG28nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwruErpX8esXp7Di3VXRrU00aS9WqZxRI9SCMYfROkCy1pRS1d9Nj5G9bC9J+tgVLB/RK4r4FvoyurQNk7FXr1u73ggaWXpxMRoMTqZO6gVV/t/3ihMYk7jI7VN47/pMmpr9o3gwZec1u1Rw0uqgNfykhjJhXCtCxveTdcN/G8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vl2jR-0006Na-Sx; Wed, 28 Jan 2026 11:25:05 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vl2jS-002ts6-0U;
	Wed, 28 Jan 2026 11:25:05 +0100
Received: from pengutronix.de (p54b15bf8.dip0.t-ipconnect.de [84.177.91.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3527A4DA106;
	Wed, 28 Jan 2026 10:25:05 +0000 (UTC)
Date: Wed, 28 Jan 2026 11:25:04 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, 
	syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com
Subject: Re: [PATCH] can: bcm: disable bh when updating filter and timer
 values
Message-ID: <20260128-festive-reindeer-of-vitality-5f0f7f-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260126161711.2374-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jmt2otsxj7zwxkfe"
Content-Disposition: inline
In-Reply-To: <20260126161711.2374-1-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--jmt2otsxj7zwxkfe
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: bcm: disable bh when updating filter and timer
 values
MIME-Version: 1.0

On 26.01.2026 17:17:11, Oliver Hartkopp wrote:
> KCSAN detected a simultaneous access to timer values that can be
> overwritten in bcm_rx_setup when updating timer and filter content.
> This caused no functional issues in the past as the new values might
> show up at any time without losing its intended functionality.

> Btw. the KCSAN report can be easily resolved by protecting the
> 'lockless' data updates with local_bh_[dis|en]able().

What's the exact problem we have here?

Simultaneous access or modification (which one?) of op->frames,
op->last_frames, op->nframes, op->flags from the timer and
bcm_rx_setup()?

How does disabling the bh on the local CPU only solve the problem? What
happens if the timer is currently running?

Also see patch c2aba69d0c36 ("can: bcm: add locking for bcm_op runtime
updates") and the related discussion.

regards,
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--jmt2otsxj7zwxkfe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAml54/0ACgkQDHRl3/mQ
kZwd0wf+OWNFlCcUfMOX6IhG63/MqfYFu+lFdX4kPBJAnhQ4dlaSMXcIJ3lqktDn
qJWPNVMA2xNI2sVXcyd464hbtiltOH+e/jtbsOHO3k7w6Oy9+6oeq2mG+TOT6Rzn
YU6iuY6QnHpDNeioOciM/W4Pfe7IK2h13zKrP64RcQSVfO+o7ZosXaMXtPUsAr2P
W7N1ZJT0hhdiycHkXFbAxvO48ROgaT9JeQtOZ4+W/72tlVYMwYXoWuSTM0gEgsrD
EI7uqh9Ph38OWYmdDUglwAwy0zBUJsZJIvQJPnXdocTyiSnT1o+VoPqWC+KnTpnE
iGZO5o67uOw0D9LJhHcJqVWgP6WcVg==
=FnXK
-----END PGP SIGNATURE-----

--jmt2otsxj7zwxkfe--
