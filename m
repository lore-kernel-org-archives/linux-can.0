Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF0630D3ED
	for <linux-can@vger.kernel.org>; Fri,  9 Oct 2026 12:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548463; cv=pass; b=ttzzrllwD7y6izSVoqBp42E5/idoxp2+wbzR9CpygbuyrG9tuj3rReDKOefK4txL5wGFYvvZypvsuZLGKkx5XPJ2U1g2ZdPzSS0m2/91TNjgYMLI0XE9c0ntwg1VZd4ZY8jIC75vYvrzkYJyxzJsH1hyYkUGJ2uYMRiG5Gezqz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548463; c=relaxed/simple;
	bh=Gb+o8tm0UdWyk62Wq8HI3UzYyKYe9uVEtAj+LQE5dtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4FL34GiRlh3G1K4oMzN80k/v+JJzXSOMABKDYqNnXWpSvjBWmPKZYuo07MXW77cNrnnZyqcLmOFgE6lC2ZjrpqrAjARhYPfpmQl3L0/BHSp/qDcrxFMdRom2gtVQyqn6LuEPPPaer1kGFrqibbcgEYo8DUgGgTn7C7JDUcHqpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=J3b/2aK/; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="J3b/2aK/"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3538C2007F9;
	Fri, 09 Oct 2026 14:20:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791548452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DZmHr88pP3RpJCGH6yMonyEuTnsQ2bFE3qHul7nXcSk=;
	b=J3b/2aK/ozizjA9K7mL4CEeMN1atIul8cDlw4KG93N1SHoOcyTCXxi+7YONnMh536NnbUM
	bFl8vG9igvHlh9B/kLCCTABYo1bH3gcWzdqK5AKErG2tk51zTEhZg4zgbIvEoWZ2Ap6AoD
	yTmO4kT/JqY8nbglvM0YXTPRC1+OmnMowZEf1leRjle5ZYPIABaxJufAEsNnZM/tVlUqTx
	28DVsDiK0PjBG3dajyPbsn++lfAV+8E/EXT3t0OCGkupD+iTY/fd7F2i8MKECBnqd6NXTV
	tvVbmCwyb9X/ls9kGQmXQacG9mHTmiZm5Y2k6bjdg/IvpIm75Oa4U+LtJRzYLQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791548452; a=rsa-sha256;
	cv=none;
	b=OfOA7S/S6f5DItQyhHwzo4AXS66+/+l8IkwYCvWNXkZRXB1ZI4cTGwOKtCJJBXquLXGCXi
	q+M/56intJXb15ETtol5W47Mw/mUO2jm2Rg7dpGKhYPgDgfX3jC43iS6HzA3/BjxTM4v92
	O4sV0J0o4VZyA4E4kk956CZQxhmVMgg/WTF4a4N/o9ESBsgwwxvbvwonpmRnE2P+TSHJ/X
	GL9TqfYlX2RDY1bxireWRdCszF44mmfoZxAWhV6BxPjdgALVto0/50N0IJcHafrNranHD1
	TbDCLa2EtRTmSJwQ1MJ6lIV7xThQavbVqdMF0yjhF/cQYnMiEqMJAa6b4+Zulw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791548452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DZmHr88pP3RpJCGH6yMonyEuTnsQ2bFE3qHul7nXcSk=;
	b=bnI26ETsshzYwAsUiBT27znqpHld7FLmBGcNuX5J47lMZuLzIRG7oFTdmmtT1ffvdkVT7d
	6fHVwNhCXTYy5020bj2BBN2vZAqQQLhX7jFY8H7TfQie1W76rqUwUeubHOaT02D7BR3Mpj
	ipr9Sk8DrJ3VP14I0+AWM3KpB3eF4/zXbFNz5pWoUXtFN5uAInNYP8FWerg5dLPqf8rvqZ
	8XgQKv32v+GiaQgXZJsHlavSNgZgYoVDNpV5LR3HkuVm4JJh/KjdRlmrjoBk6HlVhVIwM9
	Uthi7A2jYrzvONOOEx2DlbXffP+tKWOwwA4/c3KbA4Ld4ekob8ug0JH3Sdzjgw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xF9am-0052m0-0N;
	Fri, 09 Oct 2026 14:20:52 +0200
Received: from pengutronix.de (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C463C5BD75E;
	Fri, 09 Oct 2026 12:20:51 +0000 (UTC)
Date: Fri, 9 Oct 2026 14:20:51 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, stable@kernel.org, 
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH] can: convert unreliable ARPHRD_CAN type checks to robust
 can_get_ml_priv()
Message-ID: <20261009-urban-essential-bison-ff6141-mkl@pengutronix.de>
References: <20261009121115.61012-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oag4vs6j2f7kezju"
Content-Disposition: inline
In-Reply-To: <20261009121115.61012-1-socketcan@hartkopp.net>


--oag4vs6j2f7kezju
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: convert unreliable ARPHRD_CAN type checks to robust
 can_get_ml_priv()
MIME-Version: 1.0

On 09.10.2026 14:11:15, Oliver Hartkopp wrote:
> Commit 4e096a18867a ("net: introduce CAN specific pointer in the struct
> net_device") introduced an explicit way to assign the midlayer private
> pointer (dev->ml_priv) to named users like ML_PRIV_CAN.
>
> With this extension the CAN device specific ml_priv assignment became a
> robust indicator to identify a valid CAN device, when can_get_ml_priv()
> returns a valid pointer.
>
> This has been used directly by the referenced commit in the CAN specific
> j1939 and proc code but not in the other parts of the CAN subsystem.
>
> With the TUN/TAP driver a device's ARPHRD type can be controlled by
> userspace independently of its midlayer private data (ml_priv). The
> TUNSETLINK ioctl allows a down TUN/TAP device to overwrite its hardware
> type to become ARPHRD_CAN while dev->ml_priv remains NULL (uninitialized).
>
> Instead of checking dev->type being the unreliable ARPHRD_CAN value conve=
rt
> the missing "valid CAN devices" checks to can_get_ml_priv().
>
> Fixes: 4e096a18867a ("net: introduce CAN specific pointer in the struct n=
et_device")
> Cc: stable@kernel.org
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Applied to linux-can-next.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--oag4vs6j2f7kezju
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCasjcIAAKCRDMOmT6rpmt
0tDBAP0VbjqnTksQNzhek/p/ik9O1VjulK8pbyIV9WrlqH6gtAD/RqENoOwh3qxt
6Hr8P2sQxjE+8YKR7GuFxlFrMDb9Kwk=
=5lqK
-----END PGP SIGNATURE-----

--oag4vs6j2f7kezju--
