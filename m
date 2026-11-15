Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794737934;
	b=NF4ZGXQfthKttJcv/Wvb7ZRZDS9gYj5ZbRu2RsmShcvZPrK6cF8EoRVRNRzbXe7Mbze1
	 1deHCX0TxKzyrnRRojYqiM0SKJ3IMfTPaeyqFUiCx9Hj0yQPrBfyqecGAqZSbISAr+ToV
	 e6y2SYMAncQinbgMs1mHPm9qNavD4SUrazq3QjsZrhmNIIVhO947ndDVKy2355T+0oers
	 q60zzd9F9fUsJz3we0aNFVYyswwtKitmE0OU46qjopQ1ZMOAzu7Ta6ycXUjHGjMAeEiEg
	 /b4BrkULHjgkgrjGKNFtJ75ztSBxorfhW0r6ywEOnU5vdo+83rT/TYzC3MsFfz6nnKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794737934;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=1BF2Bs9rqN0MniwVQkaS00LnVzUoMb3mDzrjuBYVGfU=;
	b=LOI+4wKRpUxbNvGwoFspXPwh8nVyOho/B2ICTqfTr2yQky7C58c4RtnBODBMBfqFQvWs
	 mX+4Dj1wgHGHqj0tkel8l6UUx/pQXUKe7KLOw5ieE8f4UGxsUoXspf/WpT8wGE5Zj8Kf9
	 e1nGhRyw5UmE2CdENp18sDejrPisYTtSPyIsx8DZ0t27eLjF0ZsTE2kuduYzIulq3rPGb
	 FYlH1KKI6peK+gv297jvalSK79BBVli38ZvkK8eQ4nH0pTaHvBa+QHp/tJWrBqcSSBtNi
	 VZxa3j9uV5kKepgnBvikKrdy1AlouiqSleO2R/A9pG75M2zRI4mC+hJeryq1WxJz7dA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=VR674hDP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968F8606A31D;
	Sun, 15 Nov 2026 10:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 968F8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=VR674hDP
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 569FC201E6E;
	Sun, 15 Nov 2026 11:18:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794737931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1BF2Bs9rqN0MniwVQkaS00LnVzUoMb3mDzrjuBYVGfU=;
	b=VR674hDPyxw70DPJ70LPPLqMNB3s0MYR0oZkB43/VMAW/WlvAwxZgXJL89hwXLd1GekLmb
	G7FdC3pUAjsdRdwh81jMswy72ETu11W4Pkr9ig4kbXsl1YIZqgLJVZX00Z/cDDNIycQX8p
	AYi3HVukkmx7NIJ7YZNnng60xnsvAHhrIYnmtFy67VqQWRl0brf5FihUJZYb6kzuoUgj7/
	FUTybIK8Rm1mHVD73WoLhxOtYwGJoi+hqWHUXBRNjuGT+r2veIKGLd79m19jG3PAC/n6V1
	6ohXIzJsgIvZMGREYflfGqcrH/H6i7kN7g9QQJ2CGAcpr9IQ0G8mOxePjvEcwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794737931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1BF2Bs9rqN0MniwVQkaS00LnVzUoMb3mDzrjuBYVGfU=;
	b=WWjvhKw/F1doJ4BRVnzqA/kNTPTzQ/4r5c3SijbHP/UtbZhZo8Iu42qdi/nM0aBJKm1nqc
	EAseocgMs/hYn8euiipG2LGRB35qDawhPLxKk8/NH8tYF7L2cH2at7O4llFZPRL9lXRxzb
	RqYMnU8EVMdgBDjY1eYQ6k7i1Vr+Cuy5ut02m4y6ODciVEVfp0EL0SM8L4vcO3U0xEqcrL
	rUVSVnjcpd2WBXN78qgMeqEHOifPOHba6OwfwGUHQUxCJRxjikdhQnpclNh2W+En/hwmoq
	vR1vcLbH0pzrjJszDSEYM9rqLghWq849Fn8J8xLHqx1J+SDxl80I4qPU43a7gQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794737931; a=rsa-sha256;
	cv=none;
	b=Fjn/mSd9SN6PvUVLv/wH3irra66gxEYdXeRN186U8AgLmqwTqG/apWEu42v4k7+DGvD+5V
	N8jfbJOEQySiLf9w7b1q5cSPBH3FpfTBS+peETiXOLzSY6h4M/70Wz+rya8VOtNMWf0ZmV
	4tZjJisHW4kCIH8QuqUSkfcPQi+J0IcEYTCFR8VmS4FueyBCnLAdajjXRwK9Br47xPtdQ7
	dwv0pRAPg1XA9aHXvRTpWn4tZi46SSPsp2pLlLyXJ2UMMgURMc2Oul+AcuclbaFHYGRcnu
	CdpYB7oro5DpIpUJOe70ZWJvh55vhdk+ZIp+XgwdyCVvAkHTGNzzlYjjF18JDQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSXJz-004GnZ-0k;
	Sun, 15 Nov 2026 11:18:51 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 012D85EC2E5;
	Sun, 15 Nov 2026 10:18:50 +0000 (UTC)
Date: Sun, 15 Nov 2026 11:18:50 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH net 0/9] pull-request: can 2026-11-15
Message-ID: <20261115-musical-garnet-turtle-de4539-mkl@pengutronix.de>
References: <20261115095746.709371-1-mkl@pengutronix.de>
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
	protocol="application/pgp-signature"; boundary="jfcr3vakt764zkhp"
Content-Disposition: inline
In-Reply-To: <20261115095746.709371-1-mkl@pengutronix.de>


--jfcr3vakt764zkhp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 0/9] pull-request: can 2026-11-15
MIME-Version: 1.0

On 15.11.2026 10:54:51, Marc Kleine-Budde wrote:
> Hello netdev-team,
>
> this is a pull request of 9 patches for net/main.
>
> this first 3 patches are by Zhu Ling and fix problems with the CAN
> netlink handling.
>
> A patch by my fixes a kernel memory information leak over USB in the
> gs_usb driver.
>
> The last 5 patches are by Oliver Hartkopp and avoid RTNL stalls in
> CAN_RAW, CAN_ISOTP and CAN_BCM protocols.

I described patches in topological order, which is intuitive when
looking at the git tree. However the linearized order of patches in this
email patch series is chronological :/ - Sorry, I've added the missing
"--topo-order" to my git send-email script.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--jfcr3vakt764zkhp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCavmHCAAKCRDMOmT6rpmt
0hRpAP0eGExsnEnJrYnQMv+QxaCB4ycJwL/p5j7TOy+MaJq1HAD+NA6lr+8TS+JJ
v8sRPnzWrx6ptCV7aows+kM20quVkw8=
=fWGZ
-----END PGP SIGNATURE-----

--jfcr3vakt764zkhp--
