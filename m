Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794171518;
	b=O7GuwsYkw8yXlrX1y/mh99URRi10KGPY6OayD4Ru1oLtmUp/71Ii48Oq8hINDdhqEXpL
	 ZeExj3JnLKyO9lRcruU542OUZ7npD7L6H2MaH6xDARB2D/M/Fz9gs3QA++i1Biy+9R24c
	 zBPoOmSo9Lrro7skpuRxekJH5xutsDc7YPfU9rqvkiC0ThzMlfBPZeAu/jYOGVwcfi2VJ
	 tRjniOwU0/GtG/ngbkQluNUXPKD7ddLn3RbSq+xv+TB3TTu3hjhiqvVGZ0bldKwtr9NS0
	 1n6sF0/ht5RDcjUAunWCZ9w3F0agT57DbgDimOfwVwCRb/ufyZ+Fgy3lTWHxjeB+LzQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794171518;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=De6238UD/S0H2bvHCMlalSxRZnbovN/xIQQ9FupkF58=;
	b=WrvRD8oniXNFGnWE5w8SsJPO92P2UvEqiIbuflbhVrsOj4ceDCIvZ6oAEM+61Hes9WJI
	 7X604gqqk291YPBB1OAdF4g8e5JW/FBDHH4qkLbYV5ml/rY+Xl709Aki/dkp28+Gw+doG
	 4Rm4wH+SPEoJ9ZJ3dfi9erwYPHBv1jd9m5NcHF5dSZeNnyacK7kJkpMS06AdtwGcqcBTW
	 1k0SWGZW4CUGaSaXefhbz3rfGE1npT8fNXmVuUSj3O2DBQdOw355qaKQdboB3qLfCW0lK
	 3sZyABswUWbO0sokYk2lBBdMgPOlAlTS7CIcsgQZBtHinBDscvFTmfZ/b15fmx3LPyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=FWxdw4O7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E6A606A320
	for <linux-can@vger.kernel.org>; Sun,  8 Nov 2026 20:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46E6A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=FWxdw4O7
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A672C201583;
	Sun, 08 Nov 2026 21:58:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794171515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=De6238UD/S0H2bvHCMlalSxRZnbovN/xIQQ9FupkF58=;
	b=FWxdw4O78gaoFMVrRz5boAUy1d26GfZ5+7pLLuAfJbRMkpiM1FCRcy2jCB7FsKMg/JT3do
	tWdvhHDX1woMHjbyw1HQH+c/A2FEXE/UgWjDICSta2doSvOVkgfcCYgBXssi2gSKBT8oUy
	1/yIU9u6wHQcu905KMU9jJngF1gKfO4HRe/wau1E6D4hAEKmsSfS31sy1Agq1F8LzD3/iT
	7BPoKCQpyQkFBPImqns3KKM8khAehLhMJ9FnqGSeZIyT8LCUb1RItZP0N1e+Hw8hQYoORW
	R063XMPEl2z7ah606WE/ZWh327VSnFsPnBaXzqAqy81IkdnBj3GAqD/M0twuzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794171515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=De6238UD/S0H2bvHCMlalSxRZnbovN/xIQQ9FupkF58=;
	b=KrdfIPhQUkwytxMKyXcEiYoys1J+XneALRLqF1K0uac9AKVA+TZVNxQjjOX1Dvojba3fln
	26QYxg9STl+YY/V7edwYrhr8KdJT4LybBdIu8lF/43sqzLZdwKOeIFPthpBfZIrEk467fE
	+xRwixoblrkpCpPp9my8ekco5R3A3/PpOyIOuTKNoeJU+uiqHQp8pzm/Mi/jUb//useiJP
	cX2GCQPLsGkbZW+P1POzgp1n1S8PQN5ZyQhpcBMgU/rcHj6ZqDw6mLDhIjq+AdfSkxmywf
	4ktI1w1orLL4o4oy+OdOghgMh+W4AIe3nEsXpP5NzmRIutl4npRcvVlGHVqjVA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794171515; a=rsa-sha256;
	cv=none;
	b=RdeY+6Tugd9GAw7gsFMaGtPvcUfR7BdXvHHDCxYHGBsf6xYo624cS3jIaphePeOH57pcql
	pd69a1UasPtkpq4Vy8pGFbIKtM80o1w4V58jIIKj3B8ZNjSlou/+FqBCk3+RxPZrYpuYJW
	7Z6Fu+gD8lp1uPwZdczdY8wYxYSiXtX6qIfThOkjiEmguVuzJdNSbXis6AbCSIxXQSBbjY
	v59b/Ud5cXHCppwltTlV0O2Pi1GOCgCYhrs8aUO7Lk+va6xjA9P6Oq+QQpf132Q03AsY/r
	0MLHSdhKW1y4xw+p3vFoUfzYeTZNVbE7ru6c76gf13v/VGTWtWbLo9sUtFzgfQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xQ9yF-003En0-1o;
	Sun, 08 Nov 2026 21:58:35 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 48C325E3EB4;
	Sun, 08 Nov 2026 20:58:35 +0000 (UTC)
Date: Sun, 8 Nov 2026 21:58:35 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Cc: kernel@pengutronix.de, Heiko Stuebner <heiko@sntech.de>, 
	Cunhao Lu <1579567540@qq.com>, linux-can@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH net v8 09/10] can: rockchip_canfd: prevent timestamp work
 from rearming after bus-off
Message-ID: <20261108-rebel-cicada-of-modernism-a932b9-mkl@pengutronix.de>
References: <20261108-rockchip-canfd-restart-close-v8-0-3e7a23fd9eae@qq.com>
 <20261108-rockchip-canfd-restart-close-v8-9-3e7a23fd9eae@qq.com>
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
	protocol="application/pgp-signature"; boundary="6alp7n7ew5v4jhsp"
Content-Disposition: inline
In-Reply-To: <20261108-rockchip-canfd-restart-close-v8-9-3e7a23fd9eae@qq.com>


--6alp7n7ew5v4jhsp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net v8 09/10] can: rockchip_canfd: prevent timestamp work
 from rearming after bus-off
MIME-Version: 1.0

On 08.11.2026 19:33:36, Cunhao Lu via B4 Relay wrote:
> From: Cunhao Lu <1579567540@qq.com>
>
> The bus-off IRQ cancels timestamp work asynchronously. If the worker
> is already running, it can requeue itself after cancellation and keep
> polling while the controller remains bus-off.

What about using disable_delayed_work(), which avoids re-scheduling.

For an example see:
https://lore.kernel.org/all/20261108-gs_usb-fixes-v5-6-d52dd4940d46@pengutr=
onix.de/

regards,
Marc

pw-bot:cr

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--6alp7n7ew5v4jhsp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCavDieQAKCRDMOmT6rpmt
0go4AQDvfv69d/SgdvzUHkdYIBUAuzrmLg89+epkPjptvUJlzAD/cOOphLrFTukx
daIkmgKAWp0Xe+tp5igQ5rE+KhzU7Aw=
=L28c
-----END PGP SIGNATURE-----

--6alp7n7ew5v4jhsp--
