Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794469708;
	b=WMVFHur34oyVGSFntuGFKuu5sg+Y0IiirhLNdinVMmRMD8rG/hc7iKAsMMQ5CGCnxi5F
	 fWnhQkrOqZN+MpFJZhqY8KgktYwJtG8Fr46JfBI2D7pcDGVK+rCABFbKfSgMkDL+fAW+r
	 9Jz0aOqco499i4w3IdmP4dhhag1koQp7BjZRLyLAJfApw36r+JC1V31jD5l8FNinsDVST
	 sFcwJrW+jQTV3G0+9EihUkO5QMWFlwCUT8nyxPhrba+Px2e+lqX/YTWYCwvqKa+TLGRJ3
	 7mS+dF4CDLTUS/AB28IPbLF0MUonUzNv6GN4lzt3L3NP+oE6tZ86h83+f+CFZE8OCUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794469708;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=esxd/9sLOSpGoMqXGfKabFqq52K/StC20xJ5PydSlMI=;
	b=UGn9+kRDZVEy2Qdtg+hQDCNq/a5ZLcu7oatUgGCyhBFu61Ru34mwNSidvoxCVNUMIsWU
	 OkbMe5PYzxXYaH+3I0yFmWkv++pQ1uQL+0cIghjxboqGI7KQ93NjByXxFYo6OwNnWPXHB
	 iLLA+Znn+LthcS+op++arRNcN9eLluvlInxdnWABVcdv15UGjB0LDTQ3JZqVf/kD76tLP
	 +94RmW3S3fPfuMqeVPAKbXbQ4pC60j/0efiryE1QtOpEcSDMY08yx8hur4wFRwus4eu4W
	 4z/HtBsvHVPPvVIwCwAkkRUg76dfnPqLojYDnSBCdKWofDu3ZmbqooVDuVBdPYcZz6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=XhOJa7K1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C17606A31C;
	Thu, 12 Nov 2026 07:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9C17606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=XhOJa7K1
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 7BC78201A86;
	Thu, 12 Nov 2026 08:48:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794469704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=esxd/9sLOSpGoMqXGfKabFqq52K/StC20xJ5PydSlMI=;
	b=XhOJa7K1ppi9m5gol6fiYbdkVe7nGmIozHFOPKcq/+l9QHAtvuP8zfb3RpKsrDycPMhTFq
	FTB/7J2uEnAiW2FWlF234tS1xLW429HZCIPFiyfknZ15ZppgCw69MugW2VhQwrB1mGfeSH
	oY7Drd/CugvdxDBFvKX7KXb2ERXOTF0/+ZSUsBye4ahhlfDTOZ7kzZ/+GvW91lwrD7CQas
	etSx+4Mg+axoYeb8TR4bjPjW6jL82JFRJFc/xiqvOkuK8U9rilut9Aj0KtGTvFZjepqP7z
	dG5YRnYQLhIYswiZkv3cJPyd0mP9fhgZ4QMhAY12Ht4P7aJrRLxdH/xFdu/OdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794469704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=esxd/9sLOSpGoMqXGfKabFqq52K/StC20xJ5PydSlMI=;
	b=UMe27jIxxJ0F9WltgkteHnR/eyeOcgz0bUazaUvETkx6YtLZlaf2+4tPJKE+4/RsG4u9jq
	ns2OIAvGwzWFARjiY/+ZGWoMf5kR10RdoEsMoJ/05AMuKPd1C7Y3G8Lr9x5tLbY0GX7eiZ
	RJpo2bxTCMjaLmxg60e4QzSzBjkFdmtVaSnAHXvzsmPdDmNZNyfywouunuAKh47oxkeJwn
	YNl+qUZkrNOXAcU/QqqGOItMI1R8k6HEYxY+wJClkntqPo6cqXyAkdryoGQSQDitGVH1sF
	BF1G0lwg2coxAD9kW6FJ1MkteR40Ym+kQbiJab83cJRFnD0gYqpVDgysvMO4Nw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794469704; a=rsa-sha256;
	cv=none;
	b=O1Gg1jlZGVjaMjeRiFx3doZlj7mbsWxxsd6pqu4HONe7HyoRqYKpM1tF6fHvDL1OHZmaTF
	rLgjze+jG2S7cevZW/hhDzQJnK4bJN4tUIVxhWuuI62p+8I5Mgn6DuVevVPzYNlH0j6MKA
	J4ysIBsXzHZyGZVBAYxzzmvkOiI7SaEO9kryYFdQScKfuXRPU/MUcdjqA43bCBYlXLjqRa
	Yc1+wZoy0eyDqCki5jTZ9++itK+DQk1tR60EkLAIvW/Cjx5NaKPPf1igdgg4SBxCEP0hn5
	vWfnFsQX9DI3UJYMwHOlv1okQ7sPLknMkJ+ROxHW8/84NWcD+UPlz13X64HsPw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xRPXk-003lV4-1G;
	Thu, 12 Nov 2026 08:48:24 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 05CDE5E8A31;
	Thu, 12 Nov 2026 07:48:23 +0000 (UTC)
Date: Thu, 12 Nov 2026 08:48:23 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	mailhol@kernel.org, socketcan@hartkopp.net, robin@protonic.nl, 
	o.rempel@pengutronix.de, kernel@pengutronix.de, max@enpas.org, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Cunhao Lu <1579567540@qq.com>
Subject: Re: [PATCH net] MAINTAINERS: exclude CAN documentation from general
 networking
Message-ID: <20261112-polite-nano-peccary-fdf491-mkl@pengutronix.de>
References: <20261112-exclude-can-docs-from-netdev-v1-1-b5eb3ba4ae86@qq.com>
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
	protocol="application/pgp-signature"; boundary="lgjyhat5ekftt3sc"
Content-Disposition: inline
In-Reply-To: <20261112-exclude-can-docs-from-netdev-v1-1-b5eb3ba4ae86@qq.com>


--lgjyhat5ekftt3sc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net] MAINTAINERS: exclude CAN documentation from general
 networking
MIME-Version: 1.0

On 12.11.2026 13:50:25, Cunhao Lu via B4 Relay wrote:
> From: Cunhao Lu <1579567540@qq.com>
>
> The SocketCAN, ISO-TP, J1939 and ELM327 documents are already covered by
> CAN maintainer entries, but also match the broad Documentation/networking/
> pattern in NETWORKING [GENERAL]. This makes get_maintainer.pl select
> netdev and the general networking maintainers for these CAN-specific
> documentation changes.
>
> Exclude these four documents from NETWORKING [GENERAL], as is already
> done for net/can/ and the CAN selftests.
>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Link: https://lore.kernel.org/all/20261111161459.4879a82d@kernel.org/
> Signed-off-by: Cunhao Lu <1579567540@qq.com>
> ---
> CAN documentation changes currently match NETWORKING [GENERAL], causing
> get_maintainer.pl and b4 prep --auto-to-cc to select general networking
> recipients for CAN-specific changes.
>
> This patch excludes the SocketCAN, ISO-TP, J1939 and ELM327 documents from
> that entry. All four already have CAN maintainer entries.
> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 222b7fc2c3aa..cb1fec8ec5f5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19600,6 +19600,10 @@ F:	samples/pktgen/
>  F:	tools/net/
>  F:	tools/testing/selftests/net/
>  X:	Documentation/networking/batman-adv.rst
> +X:	Documentation/networking/can.rst
> +X:	Documentation/networking/device_drivers/can/can327.rst

Why not exclude the while "can" subdir?

> +X:	Documentation/networking/iso15765-2.rst
> +X:	Documentation/networking/j1939.rst
>  X:	Documentation/networking/mac80211-injection.rst
>  X:	Documentation/networking/mac80211_hwsim/
>  X:	Documentation/networking/regulatory.rst

Marc

pw-bot: cr

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--lgjyhat5ekftt3sc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCavVvRAAKCRDMOmT6rpmt
0hHvAPwKCOR8CfkY8/pW8HZ84qEN0q5XoUcNS2Z0nHSfDj1yXgD8Dk4w5K9qcoQe
xI9LeAYgRMidSw1qk39indiI23+0Xgc=
=aaNm
-----END PGP SIGNATURE-----

--lgjyhat5ekftt3sc--
