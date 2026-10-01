Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F4C49B5D3;
	Thu,  1 Oct 2026 15:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869105; cv=pass; b=oV1CkX2ghXrBcwzNp97srifIXSJU3t8+qJY4B0Nvzoka1d+/tkwMorjXrLqVU0QnuWEIgpDLLIIJ54LBuBflsWDqwooMiDla6l0GOjb0eNcc1CnZrR0IAWpqsYjTHHCItIBSPLFMjRQIosMywIjOicY9jyrqYaxPk6WT60C9ALI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869105; c=relaxed/simple;
	bh=pJWHtU/zhBgjGEyDZSwAapUCExaO8klARDS6iUdnfgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYl03/7IQIHHm0CNqhQwfn7QXnOxLsEKpL+B0/uMddzT0zXyw3cxb1ZHbx9kT+lXM/8b9uMdkullMW9/3hiGkEIwwe2xih3OzcXVLiWr/H1DiJOObMndDaF5AWxl+0Jg8RaWkHV2JNHhn8tIMmTqUFzSUKkeS7YUx+4yZXuyE7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=PDaGqgak; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="PDaGqgak"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id CE59C200758;
	Thu, 01 Oct 2026 17:38:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790869097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tXqdWFoXLMetl8BsO4yrnWpSA1oP/vgBWWdOUdIKKEQ=;
	b=PDaGqgak9byYPZ1bRXZtbzfuxR4tAnUOzW6QM1+yu/OtTekxqhGsRDT/lnSYySxxACMI56
	CoYkGwPUiO+GcZIkMcoFUx41sNjQRGgPTKHp01TkmGXSO+YRfDhqbsw56pgrnFu0PRAejS
	YQ9ZacXHMWydZn5ufOtk0+m3RdOnYEJZ/cJINF9ePWxM3CC6Qd8ecS9n8SoEz2W3ILLFxc
	QoZDo0yk9dy/eDg1KZDJRznDHxUZDtJtdKBf4pI12HnmPyUZRUNndDFY7shFqFTuSC+Kft
	A+tVzQ+6lXtzoH5URMWOetL1Jucxh5LU6CTqlBd8V5iw97LGMd2NL40HytGm4g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790869097; a=rsa-sha256;
	cv=none;
	b=B0TU2m95895ETnv5Ic0TXDwYhFww4wsCNe9AztQHBE8i6P39t1S8y2hjLNj0bkeuk6vDyi
	+HfurNgm2ictPFVmtJOnZraOCYols/ARqyz9CgfIrlRv8OirE3N7i7rW3LY+W6YWMkWUbX
	clXUJFL5UhFlzPrldGowID2HD4bgLQsBu3KVTB5OxriKKCG38PXhXKmXAKlcAJSmt8oSw9
	8pAS7mwZ/hDTNVWrI/VDuayv7t4R8pmuPWZzcIi/AnQmzzmnWHPMz7KFXBEVRpVVXCeyJ3
	XJplE/c32x11x7aiOjFqlgcltVG0aZg4ELzbd3dK12wM/UIzWNjBSExwcCIpSg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790869097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tXqdWFoXLMetl8BsO4yrnWpSA1oP/vgBWWdOUdIKKEQ=;
	b=aS3u1dvYddgLIteD1zycSZVOvXLwvDCkdV5VcS5Uhbqwykv7byIPJawYukaYf49OyDAmB5
	tQwnQkbk7mDMv9u8mG9c3Q9XhhFJu+CapOj4z6ohEO/mrOz02Kc2TV0p8w2JULpQXd6W0E
	KIBv0eHYwdTzVNhqm0lLCMHukB8zFtNNapsmzXi2t2K7O36KydctFDBFOVLf/G/61TrYlX
	wcpASPvouZS6zgKvH0QBFz8pgx5ubQRXULRxDAvtpEgBbRRTt4Iv0kiUTdDzEXKZFdWZFv
	o/ha/+XuMk3U9+4M+7PFFMXVS3sE+Qy4yHNcvaMkpAV2gg68hK+un/AaAdxAyg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xCIrR-003kYv-2O;
	Thu, 01 Oct 2026 17:38:17 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7BF735B79D1;
	Thu, 01 Oct 2026 15:38:17 +0000 (UTC)
Date: Thu, 1 Oct 2026 17:38:17 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, ore@pengutronix.de, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	linux-can@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH net 0/16] pull-request: can 2026-09-29
Message-ID: <20261001-portable-mastodon-of-dignity-380136-mkl@pengutronix.de>
References: <20260929210700.1183036-1-mkl@pengutronix.de>
 <9956662e-6001-413d-864d-d8d048a93819@redhat.com>
 <cb83d0dc-58a4-4262-99a0-1e4478630ba0@hartkopp.net>
 <19ab3d46-f326-4f08-a161-d31ae272a9d8@redhat.com>
 <e4a05f3a-7206-4fe4-b04f-bf2a9f1fb926@hartkopp.net>
 <20261001-fascinating-clam-of-plenty-5307a0-mkl@pengutronix.de>
 <20261001082552.514c54fd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pxi7htpguxqdgnok"
Content-Disposition: inline
In-Reply-To: <20261001082552.514c54fd@kernel.org>


--pxi7htpguxqdgnok
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 0/16] pull-request: can 2026-09-29
MIME-Version: 1.0

On 01.10.2026 08:25:52, Jakub Kicinski wrote:
> > Don't know Oleksij has done the sashiko.dev integraton.
>
> Let me try to plug you into netdev-ai one for now.

Thanks, do you need anything from us?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--pxi7htpguxqdgnok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCar5+ZwAKCRDMOmT6rpmt
0q0xAQDBiNzZ8k2gchghBxeY9p9+iWI+BG8pRhbN4wKdiY2s9gD9EMTaLCAGet0s
3PPiTmg5vX5vgbt0lYyi1Kerw6qfbg8=
=izie
-----END PGP SIGNATURE-----

--pxi7htpguxqdgnok--
