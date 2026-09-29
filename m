Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737593B42F2;
	Tue, 29 Sep 2026 21:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716386; cv=pass; b=k+bFhWli83hoKozFG4PdT7DUEGfTQvo2CzQP46VxMOp2WIbISRdm6iLcbGtS+wMd5exSrMIGpJ++XKktij3fvKZm+KtjUUbjNwnbD8qHdKT/lCftU9d++16A3wLlDFeUPnGoFTqyN5fzPS3ty50LafUuHQ4+3JSUIeN8ROoXaSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716386; c=relaxed/simple;
	bh=7+H9Ou2D9fOK2sS2x8KJ9HIJAgERrHSGd2ZfQnsqGhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QknnK+ZKCr73DE4n3UbyFPPNcyZQT4U/+M4T1Iq9+IAphq3YMRZiJ6eujsfvh4evscbahXVKexrhfpVj3voCrns11trLSlH+vU067cbn/2T/L0+yTwJ9XgzHAXSS1nTJmUXQVv7NdSPb8JaojFYiddQ0dsjNawGjYyZ7+G7uzAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=fYXWu1jK; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="fYXWu1jK"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 559F1200576;
	Tue, 29 Sep 2026 23:12:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790716377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V/D0lBp8iwuDrWzMwq0DnLmSmiMQxEl0yctjwVxCAw8=;
	b=fYXWu1jK7bp9xnngqyw5whpOzVMNW6TfC7Slme5Y3CGjEKRXd+UkAychU688W1A3AKqAvR
	s15Z0v9IONA4L4nNPyxAG4SEmrreGjbUi2d6UuSqW+i9lrsVrZAhTPCaltOKxEdBanKW1T
	Sm92MaCXBd+Jl+sQK+rI7W3gKufbGDFNoesHHD8zd2mNY32AgKhH+cj2K6Hk4/Is0E5qzJ
	8Pr4hEiYHteHfkl1iGKw5bV7MOLDmzpyk+2gmk0bAAhp/hMyT7/FtB0o9+Ft9Id6MP9sID
	hW/S5Th/NGKBeFROLYyn9xHg0lMp11uwpxIyj3uwOjlYP3RMXZzHvb64SbcdYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790716377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V/D0lBp8iwuDrWzMwq0DnLmSmiMQxEl0yctjwVxCAw8=;
	b=fmHzOq+9jNpvJairtP6O9SSKEyFQpmb+zp4OvYj7pviUmHQon8w18+PJykFrHxir3Vqh88
	vPiRjwa5Rz77PplFEl+apDxFGxOZyQ1m5wVXnjpQFgGgT2ZcoaYE0SVyNxsD3NXJW4oDOF
	iYIyuLLVe+DYimX/d+h1sQHCtZnbnc/ektN3JVFgErZKk0CIAQtkGpmg5PdTDas6HHIZ9Q
	625wgelp9tMKEjxY6/1qCy2o99/pwKWha6vLm4asdwRtTrmesOK2TCV5bJXGm2ziBNp0Pq
	tj7hUH4SGps9oOxfmCfhesSy5Q6uX8GZlr0rmVzKklz7eDTeFDwaZENjCsJQQQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790716377; a=rsa-sha256;
	cv=none;
	b=gRCNgp/ADpppeiAF2R4HqeDC4FjuSBwwxMBLBstKbX8lAcT957XDgPiv/kcFIOW8kIG9k9
	j31FeqnOJPWjJyaanPDVliNe7+I4+gyWHvDIrRJPfikWoBrR5a2HmfQ6JkW8LLKNCsRZv+
	EBHYeqd9Ch7BvnHo8vUOY5qv4F7wN0XJjOD48Np7G1bFOhp3nu0pNoXhEkDFYwRzQCPCYB
	njNSs4rW5J3ChGSi4Ro5smPplUvIFWNMRi2gAm90ap0ykengqd8i3aQWQK6ExFX3VQz4iY
	8qQT8T5QIXe7oh/iKWkJtU/NdwZrxyGcZD16g8KY9zQ5orVUSkBsAWkpAfX2Mg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBf8D-003S55-0n;
	Tue, 29 Sep 2026 23:12:57 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EC3365B4D5A;
	Tue, 29 Sep 2026 21:12:56 +0000 (UTC)
Date: Tue, 29 Sep 2026 23:12:56 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH net 0/22] pull-request: can 2026-09-28
Message-ID: <20260929-towering-phenomenal-anteater-e5a6a5-mkl@pengutronix.de>
References: <20260928193312.553632-1-mkl@pengutronix.de>
 <20260928180921.4200d711@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="27rtote3mvl6lmm4"
Content-Disposition: inline
In-Reply-To: <20260928180921.4200d711@kernel.org>


--27rtote3mvl6lmm4
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 0/22] pull-request: can 2026-09-28
MIME-Version: 1.0

On 28.09.2026 18:09:21, Jakub Kicinski wrote:
> On Mon, 28 Sep 2026 20:45:07 +0200 Marc Kleine-Budde wrote:
> > this is a pull request of 22 patches for net/main.
>
> Oof, Linus just shouted at us for pulling too many LLM-driver fixes
> late in the release cycle. Could you whittle this down a little bit?

Sure

> At a glance the skb freeing from IRQ, and propagating impossible init
> time failures (patch 8) can probably go? 9, 10, 13, 16 too?

yes - I've moved the ones w/o sashiko regressions to the can-next queue.

> Driver init error paths and remove races are things I commonly apply
> to net-next these days, 'cause those patches usually come from LLM
> jockeys and nobody cares in practice.

sigh :/

> I pushed the Sashiko review to high prio, so pls wait for it to pass
> judgment before you respin:
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928193312.553632=
-1-mkl%40pengutronix.de

Thanks - it stopped on patch #9, which is "In progress..." for several
hours now. While the header shows a big red #Failed.

> Up to you what you keep and what you toss, FWIW, I mostly want to avoid
> obvious egg-on-face conditions, which I think the driver init error
> paths could bring about.

Here's the updated PR:
https://lore.kernel.org/all/20260929210700.1183036-1-mkl@pengutronix.de/

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--27rtote3mvl6lmm4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCarwp1gAKCRDMOmT6rpmt
0kHSAP4uWKPWsNu/Ux66OrKxv9tz7K7bINwUV2NTZzrTlJJp6wD/f1uivtznA+kv
xpDwVma/RHvo0Ps4WkBOVHpTUwX3ugQ=
=fuNa
-----END PGP SIGNATURE-----

--27rtote3mvl6lmm4--
