Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1E547ECC8
	for <linux-can@vger.kernel.org>; Wed, 14 Oct 2026 21:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792014804; cv=pass; b=OQtRrGYj8GslEXMkEEbwmwQru/poXe/UN67DY3ZZ/hBGW59B60fvQBkEmp/dYdhqTb+oS4AccClDwUfpH+P3rrjWxL0SHjcNQv8sO02CycxXspXTfB7htgktkOiYaipfJ4axf10rU+mBzOimeUPl3OUYCUWIkXuzZaljKlNXkJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792014804; c=relaxed/simple;
	bh=6Ai/iIIf6owAq6ULE+AZwSxP27YPpIATv9c0C1EINno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMEZua9NUZcH0rFO3quf3E3NGaadRAoArYR212TLCHgqWAnRMN8VlmMH2rzPYt3gydtAMXBo6DP2rH5uJedzrazGQvKuN3Bm6WLZ4XmMhEEQpKY73P0ex1nl3GPhGobykKfS2qiuceb05iVxiS/JzmXrMOfk2Q0vJFHzSTw6iGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=HfQNJV/r; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="HfQNJV/r"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D519A2004FC;
	Wed, 14 Oct 2026 23:53:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792014796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mfwkA5tQs+Odui/uCrR84AenC3MJU3pCHsxeWgINuwg=;
	b=HfQNJV/rJqmOzbI8YXUJjYII0yvsNZja9wL7kFtZX3hzlA+UXfvLOSnjM9uw4XgKwRkpy7
	6jGrEtGftQpb1IZWO0Fj5dTdCPp2gjQYQNlChRzhvUv//ORkLmVf+OydiOSHJSm6oU3jPD
	zGoz7rkGu7B+byGkFc+QZrK+oVdOZYr2FRO2W9+e95H5oHYicJcNPb5BeFFsGdLqeQBsNB
	vn3mQnZMxouIhlLW1lkIkwaGWhcl1bOvZMFXMg1W2ghQykr9Azz7ChaqSNthMkxy3OXODO
	l/KjzUBZzvxr+J0QCT31MMazFEZUKEFnbUQUSIZvxjhhEgTS4IdE3XnQK/7xDA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792014796; a=rsa-sha256;
	cv=none;
	b=AXTekrtm/OWLZCJuj5zO62YMB3gnpfl1uy+ssqfYSoI8gJAz7Ne5Zq/Kc6J6IbqjlXJFRw
	7e8M3lMKXBiVa8nbtwda9R7d9HmZsa0A3B2JMO+p9k00QLpYs8iXh4tZLbmxvBO6j1ZMfE
	BJQ9ZNHkWxR3P+ovesE1jXLL/g2PdL+h+O9oUq5onbTBfxtvOcC4C9uQ70JzB9hSWVMVI4
	2oHHpT904wVw7FZak+Oc8JB1qj5gos+tyRcFGJFH33Ghzsfi14ERWZvFLYF2zxPQ0gIdhr
	rm801MuJVwjfULSp82iK/c9q9RpBTcAXX/4VWCM078r2yiESVh5VPOEgw2Tn8A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792014796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mfwkA5tQs+Odui/uCrR84AenC3MJU3pCHsxeWgINuwg=;
	b=SSGwBgPTITm73+3GAneMliwm5nf/eZ/gBZ9TyrSWdO2afcwv5BtE2ZhliYH6cqWdPMBnmK
	Ncj484c5xZqvdYaQfo1xd86cVPfxRg+kyUdcLHQWRs+xAPdTue9QtwTBGXJziCFJZc5AlL
	EGp12+Soqnnw/nurhZBZGThz+R9TEpsNtja4bcgvB/E17hAX+OKBKj5ilgDbfHY+urzDTB
	kdvv/G+NyEwNGo7eI2d1kYP7GFgrzw1qhw9ist2hRdKKpkXJXV+zY8OSvI5K7e6y4zuBj+
	O6hvxhQi2fQsk2VaiNEzIvEOhC1o70vFhQXdAw+PkuSAuBfzbwmcF1RTKing5g==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xH6uS-005vBK-2V;
	Wed, 14 Oct 2026 23:53:16 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8DD8B5C45DA;
	Wed, 14 Oct 2026 21:53:16 +0000 (UTC)
Date: Wed, 14 Oct 2026 23:53:16 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH v4 0/3] CAN netlayer fixes for stable
Message-ID: <20261014-noble-augmented-flounder-adb53f-mkl@pengutronix.de>
References: <20260929154125.3298-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2536exlsf4hr6pvo"
Content-Disposition: inline
In-Reply-To: <20260929154125.3298-1-socketcan@hartkopp.net>


--2536exlsf4hr6pvo
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 0/3] CAN netlayer fixes for stable
MIME-Version: 1.0

On 29.09.2026 17:41:22, Oliver Hartkopp wrote:
> This patch set aggregates the open stable fixes for the CAN netlayer.

pw-bot: cr
--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2536exlsf4hr6pvo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCas/5ygAKCRDMOmT6rpmt
0vk/AP9P/inj5W7c7bkKPorQSaS1j+SrZNdeRzbskRLNi4EZ5wD/QUnVX1njBY5l
sWxtYuJnJkT6QWQbGhfR9vpz/VAB1Ak=
=waN3
-----END PGP SIGNATURE-----

--2536exlsf4hr6pvo--
