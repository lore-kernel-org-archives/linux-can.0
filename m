Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795170627;
	b=hhuneD8N0bvuW2ZPiIPSlXCDCEV5BWmVeqJ8nG5Q3kC7rSgyUafoD/f0o6npPeoeqX0z
	 9jPld/ns4yt3mBuz2EqFDS/x9J4PH9EG3Zg4j7BsiR7RdLsGHHXDUg6kJiHinkQGF9Fhx
	 luQdN0FvJMbfP9lY/nCA9layXfqPcCuMpG3WhZ3A/S/tD4NCDOWmuhUIj1UEOD3244av/
	 jayjaflCWB+UQXYkn9y06XAj8buZMck1lT69H7I/WkQSD47s+XAK/AsARVsRD7O8X/HMY
	 AOFcufSomoUAtZ6SKgy738Azs13dWPRNP+MHncOC3JXLEC71hXRfZsOuaGDusUZ5T8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170627;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=w5tca6uYV/tF6AU+N7PJZsWuzLgfoBFWD33ydkE7QFQ=;
	b=WmQHp0uj3LPcrMa+P/5rMG7YrWkvsS2dWwgA6tFIrJwjSJfquMQfmw7m92mzGVSrywiC
	 6lB+WuLT1mnD7r1WqAS2uGtTkDt2BcFzd99FbI9IhCLhudtNXV0cIM7Tttgxa9f/ps9sT
	 DIkKmBLK/0s0PdPbtEI/3ebAiwPdZoayA5lihMjAdldQR8LTmSwn9GClLiY3JEP5CeQcy
	 okyQYy7lcNCei9B5CEQmGsv06Lzi3GmzAQx8HA4AsMtbOKwj3Dfv6i9Rw4748EeujC/P5
	 CClXpZwNAV9FcsgQhPykJ5Bfg4+1GhJxrqffrTRS3Lga0g5q61ydDpvETTMxfIZsyRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=fdugpQBd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9248D606A330;
	Fri, 20 Nov 2026 10:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9248D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=fdugpQBd
Received: from pengutronix.de (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id EF9DC201862;
	Fri, 20 Nov 2026 11:30:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795170622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w5tca6uYV/tF6AU+N7PJZsWuzLgfoBFWD33ydkE7QFQ=;
	b=fdugpQBdJ68OQGhKWuaC9zk1RYHUMyMet/koXW80S26dFbZ+1q+fyUN/dsr6EGeODbgBNr
	w5Qt7jmLSsgl2IkXBOwyjxrY4v9yG4xPAI0iRi7joNNI3gbPllZDvV7BDqYNTPrsJJ17oM
	xyXM3TahvG5Z/5oUf27HVP+6reKcoOCYfnesQW0qR2409Dsdc6gWw8U361mO/sBsXjOBvQ
	rYAgO91wPclBoer5KTFa6AUWPrhHuR3wE3Tq2mscRR3vwRPdtJse1SCzGJK8zw6KIb81uO
	8uv8V1SRBXxSCMmpji8AHaBBUtfwRPv/6d9+yJ/6MuLefgWhynjWDPClhHF1uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795170622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w5tca6uYV/tF6AU+N7PJZsWuzLgfoBFWD33ydkE7QFQ=;
	b=MKC6bgE3HRlQgVmgxfxW2PyOU9/j4B7d5bSrtCQuMwnhKp2RNq1PrIiX6LFKaghwTSI8nh
	2nHAjLeh60zWV6tixxK/Um3wNfU+EkK5XLo3UTvoDezFiKH94fsg8Z+L4nxjhJD1EMRHWV
	VjjvDlkqjn05KgCO8ZBnhxxLeGEz/p4CA8LZu/nHfkG6MluP6LD8lIfnVFwZ/r75o9dkJj
	YGX3zE3kVcn4wD+XxbTiqNP98F+htYVEaGd9FJwlddeU6RHNaApFYiiEsWrnwtvYvFJYC+
	OVBSSLb/+A5F1kASmnJm8phx5qUM+TDSlTbi+JT1uSuLS/CKSSbHIQsd/xBs4g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795170622; a=rsa-sha256;
	cv=none;
	b=dlZ+UwjHZoc0ZKJw6cHU5OruclL6V7v56dyJXRbG+8M+C7iULc4aMOjc2CDDO51nuE2G11
	uTKn9wuBytVKjZfPXcIJr14aCTT/MGCUslk4WWZaYRBNJxWRy0C7O6azFPDdd43OtIJuX/
	y8jKjqsPxSuXRG1KyQOx0TqrevHwFjlVzWqKKZkqgGmEIUiYgnj7yuNV/dCPhVGFwOP4td
	4yX9fHm0NkPcnfXWy1710rVSBhG6vrhaS2JAxQH7IpqNLNNCNHdQbtZu4GmCXXMWaHl5K0
	DmbvRFxzIGNPEm4VOGKyLBPZ6jaIyqLBj8dcl/gIEd4GZy3EiyH81vr+AZ4YlA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Date: Fri, 20 Nov 2026 11:30:21 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: o.rempel@pengutronix.de, robin@protonic.nl, socketcan@hartkopp.net, 
	shuah@kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, fmaurer@redhat.com, 
	mailhol@kernel.org, alexander.hoelzl@gmx.net, quchaosheng000406@163.com, 
	penguin-kernel@i-love.sakura.ne.jp, kuba@kernel.org
Subject: Re: [PATCH can-next v4 7/9] selftests: can: add J1939 TP/ETP
 multi-frame tests against CAN_RAW
Message-ID: <20261120-practical-labrador-from-pluto-e9dfc0-mkl@pengutronix.de>
References: <20261118-j1939-selftests-v4-7-756768d32ff2@pengutronix.de>
 <179513247817.3132.9443006972128193443@kernel.org>
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
	protocol="application/pgp-signature"; boundary="3gl2bbrxycry6rq5"
Content-Disposition: inline
In-Reply-To: <179513247817.3132.9443006972128193443@kernel.org>


--3gl2bbrxycry6rq5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v4 7/9] selftests: can: add J1939 TP/ETP
 multi-frame tests against CAN_RAW
MIME-Version: 1.0

On 19.11.2026 23:54:38, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [Medium] The commit message argues that test_j1939_multi.sh can stay in
>   the default TEST_PROGS run (not TEST_PROGS_EXTENDED or XFAIL) because=
=E2=80=A6
> - [Low] In j1939_helpers.h, errqueue_empty_ok() is documented as "Is the
>   error queue of s still empty after J1939_NEG_RECV_TIMEOUT_MS?".

pw-bot: cr

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3gl2bbrxycry6rq5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCawAhOgAKCRDMOmT6rpmt
0hXhAP9AfMOW4stG2a5pAC9ie+m7nqylgX/YjMdUwoI4l5VLfQEAvslxe2kOp3fR
+KXzREsEwD+h+P6bjdpkMmx352HqAgk=
=rZKo
-----END PGP SIGNATURE-----

--3gl2bbrxycry6rq5--
