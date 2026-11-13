Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=116.203.23.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794554273;
	b=xWmHuAnRn60W1ag7SaRiZ3XsY7V8AOmSawVRQRwCYvhOCk17KDpEhI6YzT8EwpE8RuEx
	 GDltmn05R/kJfh2ptJMlMZo44frr5TqB8pkSH/KEZgu0zbvVd5ttSONR8ydJsg/8lGtdF
	 sgRPZmEgsBbT6I7lyJZmMDlavkGDu/+4zbkM93LhNjInf4HuJ2g2jhIylFDNgAe9WHBHf
	 Rc0ytK5HZ5UtiyLWpACyuVdRfYQvIbmPIEzMzm4rI4BQp401iDXXwxu2n/fZfcJazJOiU
	 LX33esgugyju/x5tJLdPdoFUqm8udqrRZ5GC4moutt4wSpoJSqeYnHpkSAE2j2nCdlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794554273;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+PvlK30IsPvyDmdVzBsctIGAzhTBquDxEsbqbTaHXwg=;
	b=5HlGMp8Oe9uo2MQByHf/VCXLOKvYiAv1NFkG5c7HoqdNiPgg7EyBJXl1Zk+92f0lmzdS
	 wgVs0g58lzM0lJlZUbujGq8uA4YtBVQhhGHxvnK1LcZycPK4HzYIyzdUAdRkCLSoC7/fr
	 ZcYL+eFU6jx5lU71U3YnwBQPxsM9k0w6iBv9QZue9RrQRkTQh0IHtxfqZGzcBm8SF6wwI
	 TJcquvOTSFw/H7WgQDXp4XFUfzQo3FPoML4qHk0n1YA159AJI7MA3TE9774P4YfEURXyd
	 w65C0vJQARABi6a0fA5u6KtToR7TRNjzDzKueYtblPqBI2MAXXxdpDy1O+NQK1p4JQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackshift.org;
	spf=pass smtp.mailfrom=blackshift.org;
	arc=none smtp.remote-ip=116.203.23.228
Received: from glittertind.blackshift.org (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B1F606A32D;
	Fri, 13 Nov 2026 07:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69B1F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackshift.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blackshift.org
Received: from bjornoya.blackshift.org (unknown [IPv6:2003:102:af17:cb00:cf3e:e168:1a5d:8293])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "bjornoya.blackshift.org", Issuer "YR2" (not verified))
	by glittertind.blackshift.org (Postfix) with ESMTPS id 43FCB79E6C0;
	Fri, 13 Nov 2026 07:17:48 +0000 (UTC)
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AA4D25EA5C4;
	Fri, 13 Nov 2026 07:17:47 +0000 (UTC)
Date: Fri, 13 Nov 2026 08:17:47 +0100
From: Marc Kleine-Budde <mkl@blackshift.org>
To: netdev-bot+sashiko@kernel.org
Cc: o.rempel@pengutronix.de, robin@protonic.nl, socketcan@hartkopp.net, 
	mkl@pengutronix.de, shuah@kernel.org, kernel@pengutronix.de, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	fmaurer@redhat.com, mailhol@kernel.org, alexander.hoelzl@gmx.net, 
	quchaosheng000406@163.com, penguin-kernel@i-love.sakura.ne.jp, kuba@kernel.org
Subject: Re: [PATCH can-next v2 2/9] selftests: can: add J1939 test helper
 header and library
Message-ID: <20261113-classy-evasive-mule-559cfd-mkl@blackshift.org>
References: <20261104-j1939-selftests-v2-2-cf797c83317b@pengutronix.de>
 <179394331774.488853.9726002978646630085@kernel.org>
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
	protocol="application/pgp-signature"; boundary="ri4qm6tshdojjwng"
Content-Disposition: inline
In-Reply-To: <179394331774.488853.9726002978646630085@kernel.org>


--ri4qm6tshdojjwng
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v2 2/9] selftests: can: add J1939 test helper
 header and library
MIME-Version: 1.0

On 06.11.2026 05:35:17, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>
> Low priority / nit picks for your consideration:
>
> - [Low] selftests: can: silent skip in j1939_test_main() when protocol is
>   missing

pr-bot: cr

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ri4qm6tshdojjwng
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCava5mAAKCRDMOmT6rpmt
0hvaAP9vUxyGuySMNG4POpe13CNvZdJujh4Bjs5N1ffj9YFqXQD9FAbTZ6gTgFjt
84gHs7uZzUPaloLGa8OhmYfgCbQlzQ8=
=Jp/F
-----END PGP SIGNATURE-----

--ri4qm6tshdojjwng--
