Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126702F7EE0;
	Thu,  1 Oct 2026 10:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790852164; cv=pass; b=DUx0IrxIgEIRQhmPT9oI2VLESPdNtCoWtZPiACi7l6rR9peZn3yus5Lax4kr7xwa+DRBGbaGGc+9JXiKhYlwIba/g47WCFe2Yb2IaiLqeugnJKqDiRsB15DX0wjv986qufziqFLNNQ7L9ENYmDeD7p7q8Yr3lXsKBnHNtq5FwcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790852164; c=relaxed/simple;
	bh=/CuYZ/OApqKrSPfTMj2lSt1zO962PjI7FYedEztP9lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWUX9rrdgdpc9FLJoyMzDF8p7cgwZGIYAXXVY85i/1sPAi+AA8z3zQBoxLlBjpEpWD1lXWolCE++0wBzFDif/vTwgx4B9aHNAJaee0Uqm7HlLQ3r1fw4tvX5z83Z5sMUINw2uDRVH6vO2C2qP2n7RkRXsWLqyjGITVpXuMKzn9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=g6ooKicS; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="g6ooKicS"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 169E4200757;
	Thu, 01 Oct 2026 12:56:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790852160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U1WdUP4ykiBmfuhYvkcZwDU8ne2dgi6BheJJ/ejdDPc=;
	b=g6ooKicSUE9TRgTa1rIeUZ8pq3opXeOiztyL8tDGW0b6F0U2H6YG1kIS53dWB8rryvo+Gx
	wFN8Bubv38j7BiEIDwDcon4s3mpT4JITRNndFjViDeTBXAg0qDUrWViOV5pJ+Uanci05G3
	RhxTOWaeg0iaB/VYJzTymnZYAdlt/uQnlKSwkGvKzUX5J3ihV3Nm0dTFuwE0KiiQX6ANGq
	qY9UKzTiilcx0KFJVXM+4T35u5LvJ1UKWEANyTbDxElZkPwxdzedvaXbr/7IqdrZPQeCnh
	b2ZP9oupBsI7Wr97Bl/CdTsmCWwpqGeqVeg6bytY41DzRZPO5H9Xk2qp1mYURw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790852160; a=rsa-sha256;
	cv=none;
	b=cA4zrIPRJl5FV6IxnZjNfPsWuAqeoQaLNv3lFD/C1QGQD+gjD1oSyBBPMHwk6gZyEYzqZH
	gWszMduVh5IgOs/ogDEjoYU9GD3qZgow/70LYVMhtv4JrdGbdGGQXJVKK/daQMkws8WgZP
	ELBP1PXcSaYFnFbn727bx/szfx6m4zVYq4BEB78/ARhxRsl6Lz8ICsXk50Kaj9qIL9fGxk
	zT57Bl3G6QMJBqi3pbkpfU/2qCoyg2tlLlw+elS4BIpLPnHBzj8281qH8i2Ynkng6u1GU6
	FCaUqtbICUYo/NsGNaTYkpPCWJ9l4v9zM88UMtcWLBQPStaVF79FTT+XJW4XEA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790852160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U1WdUP4ykiBmfuhYvkcZwDU8ne2dgi6BheJJ/ejdDPc=;
	b=EljLXF4/reyt0nsqCOFWJblZt2Gcp5ILYtMxuSBXV9SDic1gme8aV+odHJEreb8LP38kWC
	CeAECaNt+LFbKTn7oFX9mTH7F3tNY9IpDA51MakJ8VY/m/m+aCMqr4j3wgjMr2WlhwtgRX
	VRpNED2rENLmyj+8Ucz2rwsomqy6RbAK7idC/sC+jxDY8Tbc3Y/GtXScYBGDcuNTYSOrrt
	izbR/oiNIoWPBUmfkxBrQbx+sI7jyIOpuQkDe0teTlgMLrzePltgXUiV0oqf/4G8jgiZaW
	lRmcs3TBWh4pJVL970rwbPfCKIYLofqMJnAhH1ZJv5adU62ioy/YTKKZnwkRjw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xCESF-003iDe-38;
	Thu, 01 Oct 2026 12:56:00 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A98D65B75ED;
	Thu, 01 Oct 2026 10:55:59 +0000 (UTC)
Date: Thu, 1 Oct 2026 12:55:59 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, ore@pengutronix.de
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH net 0/16] pull-request: can 2026-09-29
Message-ID: <20261001-fascinating-clam-of-plenty-5307a0-mkl@pengutronix.de>
References: <20260929210700.1183036-1-mkl@pengutronix.de>
 <9956662e-6001-413d-864d-d8d048a93819@redhat.com>
 <cb83d0dc-58a4-4262-99a0-1e4478630ba0@hartkopp.net>
 <19ab3d46-f326-4f08-a161-d31ae272a9d8@redhat.com>
 <e4a05f3a-7206-4fe4-b04f-bf2a9f1fb926@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ee4mapimosi2i57c"
Content-Disposition: inline
In-Reply-To: <e4a05f3a-7206-4fe4-b04f-bf2a9f1fb926@hartkopp.net>


--ee4mapimosi2i57c
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 0/16] pull-request: can 2026-09-29
MIME-Version: 1.0

On 01.10.2026 12:28:48, Oliver Hartkopp wrote:
> Ok. The review on Linux-CAN ML was done with
>
> gemini/gemini-3.1-pro-preview
>
> https://sashiko.dev/#/patchset/20260929163424.16382-1-socketcan%40hartkop=
p.net
>
> While the PR netdev review was done by
>
> bedrock/us.anthropic.claude-opus-5-5
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929210700.118303=
6-1-mkl%40pengutronix.de
>
> @Marc: Can we switch on Linux-CAN Patchwork to Claude Opus too?

Don't know Oleksij has done the sashiko.dev integraton.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ee4mapimosi2i57c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCar48PQAKCRDMOmT6rpmt
0sZ3AP9Fneeg+DxBzl7UYBggzxyXoYw1Gi4ve3cpRnD5UQdKYAEAjT1gWlSEKTh8
kF8Gyfufox3gKenRWwCTxS80+6CTcwk=
=acrm
-----END PGP SIGNATURE-----

--ee4mapimosi2i57c--
