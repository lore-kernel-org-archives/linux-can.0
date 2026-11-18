Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794995141;
	b=tNmzId/ebXOj+9uixHxf9FEJBfo55fM/6mibW6ZFNEDk5yr67ZE/HajoMSuMzlo/UAmH
	 wTLIhBBxaOk6r9oqY/HKYm6IWipahk4s4va7ehhMvBFJjjziWm9pjsZ+vChLAP8s4HQ7h
	 3Tpng4nsqzBlmqf23A14N5iYuUNkAKdvJbJmtU/u20XaFg2amUfPoDptoLo0ecdZ4J7U8
	 /7h3xsIV6KFqvyc7lv4HdSf6F7yw2oFLjmhS10Fbi+sp7JeaSdJIc1ahJm34oh1xygebI
	 qHXy/XHoG0OpaHvEVV5xp5ckZK3cOgZhl53efD3dDXnZKx2MvII/a83ZYORgQCnuktw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794995141;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=uCZjzvBXpQzyiqLUiaZTYDZ3Cj7C6PIF0m4jF7KKt8Q=;
	b=A69RnIXaO612zaruUoqlfVdKxzN/QyXvPu2qH7/NZuTg6mirYL950iQ3bCrGkn9fchpN
	 EHDjAa6HBt7vuQXhH0vQYi7zIe3Gh9IkfN6YBt1RexbhksWG3qgioG5M4v+AZ5wGlGdMq
	 czJOVdAK3KAOm1ihKjBpGY7Ug6JTe8lLrOW0w2/qnCN+JMpNMtqpuUqdD/Cu7MbjVJ9la
	 YapiovCz37HV3MgSPTOh8WVedQxX/g6HCXCJATIj++yyFudv1/EnMPuEIeEHwQ6gYjaLM
	 Zj9N5AnGL+lX8ctSezMgTj9R192q/0Hgc3/03qbLV7O0sdXbBhW/tFy4ewlwyKC67jQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=KDfBQ1wF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A53D606A320;
	Wed, 18 Nov 2026 09:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A53D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=KDfBQ1wF
Received: from pengutronix.de (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 9921220011E;
	Wed, 18 Nov 2026 10:45:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794995138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uCZjzvBXpQzyiqLUiaZTYDZ3Cj7C6PIF0m4jF7KKt8Q=;
	b=KDfBQ1wFEC7a950vAnPNfxVdNolhuN65j8nK8LfJdSZLvqFcKjPcxFHrqymcXi2rC5ltfu
	oNeOv1/x9HEfM8/8DoEwsl1lHZnkViEwPe5b3s4tRcnUjSHOO9zGXkNafoR31VJa3EG6o4
	MB2gnYEaE2Ks9LKlBSGfTA5PYL8WYXbUO0gwpaAnzONJW3o0QRHXLTqeYKKXsy6keX7PyH
	Gsi1qASQvqYefBlGyA3Ph6YElreXO7uqldIIPn+vjKLod5TAtg722MrvJdagS0leMDfnZv
	/uuIAmDSfzplfSbTjfbQzTkvvQfjvq99XnMyCD15HXFmYM5SOhnNZ76kVwiokw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794995138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uCZjzvBXpQzyiqLUiaZTYDZ3Cj7C6PIF0m4jF7KKt8Q=;
	b=AzfXhdXQSD6Zgpj9zVQX53Z+kVdgu0NOPZuk34EoXofb+kJaeBIxXQvzDk9FgZdEyqu8iY
	8ELVUUgFh7B1iR6HUV/aupTtcuoAE0mVjPSLH2ktHqIOnffnE1XP55YYKATtxP4yvqzSke
	FedZdBAy1HtudhaGnUJPehMzwW3VSaLlwDusgnNRijQFOyqwREewZp+hDsWbpjc4gJnDR2
	jeafcaE+IIFGIGNTSQMoGkve3q0tR436lYo0omVj11l8eNZiG+HCbxTVqYeRG8C4wG7Qf5
	vH+tA/bhHYVkF6aook4tiRvPtFKCmb+YMsat0CKTvYHiFguWMM42NcpOZ6BWww==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794995138; a=rsa-sha256;
	cv=none;
	b=UeSt+cFa1Qt5aq6QytD0IHBzKkH3pv2bDhZbS2ESAwVQFBlPltLk9aKGs/vRv2Ux7yGoHv
	iGRcNMH2dSs8wcGzhN4AF37QJ4MlHgGLiYpynxSlMn2hE4a6WAz2uB3QKYTNW+miN8X76K
	vZVVtLl0M7CwykdF4OdwMdnVqdnqGBIstUgdY9vwopxyxDSQkcMGckklRiLq0Kz2bmnl70
	XXjcMdBWdSKrvj+TujPid5LtguSh8q7/hDPCzj7ANyU1+3vicQlxGzbfXx8c2PePN7KWe4
	42kyp8StUAo5BlO3LxiQIXN11yC+5pJvlK3T9mXCzTHbFrCXtO9gSR8PBCxupQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Date: Wed, 18 Nov 2026 10:45:37 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	linux-can@vger.kernel.org, kernel@pengutronix.de, 
	=?utf-8?B?U3TDqXBoYW5l?= Grosjean <s.grosjean@peak-system.fr>
Subject: Re: [PATCH net-next 01/12] MAINTAINERS: add entry for PEAK-System
 CAN drivers
Message-ID: <20261118-vengeful-turquoise-sunfish-bd2f81-mkl@pengutronix.de>
References: <20261118092955.1283165-1-mkl@pengutronix.de>
 <20261118092955.1283165-2-mkl@pengutronix.de>
 <179499472297.3291.1921538258116208727@kernel.org>
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
	protocol="application/pgp-signature"; boundary="5ddab6moxsf2jjwx"
Content-Disposition: inline
In-Reply-To: <179499472297.3291.1921538258116208727@kernel.org>


--5ddab6moxsf2jjwx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 01/12] MAINTAINERS: add entry for PEAK-System
 CAN drivers
MIME-Version: 1.0

On 18.11.2026 09:38:42, netdev-bot+sinfo@kernel.org wrote:
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:

Patches #2...#5 fix error handling problems discovered by LLM, but have
not been seen in real world systems.

Patch #13 fixes a real problem, that can be seen in production system.
Certain CAN-FD related flags are not set.

All other patches are driver removal or cleanups.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--5ddab6moxsf2jjwx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCav1zvgAKCRDMOmT6rpmt
0kScAQCVnBh2ojLTGUXDjZWP46ZnoXgbeRVGwkAZitH4wHQR1AEAoFYJ1goHofaf
xkgwqPSBXKo9uyCx0/3YAwnynLSIjgU=
=IvQR
-----END PGP SIGNATURE-----

--5ddab6moxsf2jjwx--
