Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795524396;
	b=CPbnkXZs6D7EwlF/QC/VFTXyv5qM9suaXsJ4ctiP8552VKuAwkEVc0/ccS0X4tq39Ua4
	 LSBsbgUg+M+CoTJqRUHbIba2IMmztO/yLfsmQe/wpcJxBTdhEGnO5dWSXOJvEt91JC4j6
	 ticXRCp5wvqFWyJOZlyaQYcg35NlwyRgtdo1XQFzDgVu5blWpoWweFY7P0QQRu9CPlpeW
	 vANEYW+Wyn704bHcf0HaKqDsy+v5k2oMRhm5n6v5zLjASjFh199ug79UpFvXqBuV3hLGm
	 OPZYkttO4nFIFl3cN7YD5ORDzQaqgZO59nTZT41zFuXIKCp9f31FX+M71pcJRjQ762g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795524396;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=PrE/2EutqnuvtKyH9pmay9A73YFzmvHWuTlKzL38kgM=;
	b=doNE7vrh75OaSCL+XtWwdRIXik9yp0HNwZIw8Kif+EYBM5KOwloKL5GrOHxb+yswj49D
	 Rh3f9BlDBENKceB+RJzaAUg/qyHFASkQu4hixB86uwqBOms5Gb958AY1JndYZel2vC/1w
	 6376nPHfe7OlC3tXFuWhWELq2fehVqaRri6RcM/1hcZcBVFwlgysZjyq+RFqjLR8xtj9v
	 m++YcJw3utxpPDsHNhA15XsV/5FFDJp7KYqKEAiI+ZOIa8vSlp1KZV1DkQBZpbj7gvjcv
	 KOku5WSBAelBLM1O6HLmCRZ3Q5oQ2OWa+uwYUqZDJIk3rQ56eSu7/AB2MuxLJOoJDHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=HvVwzEGz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D41606A322;
	Tue, 24 Nov 2026 12:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49D41606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=HvVwzEGz
Received: from pengutronix.de (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 1591B2001A0;
	Tue, 24 Nov 2026 13:46:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795524393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PrE/2EutqnuvtKyH9pmay9A73YFzmvHWuTlKzL38kgM=;
	b=HvVwzEGzR/eV4scS6pIaYOYgBpz3BCQzFz3h6F/bBN4U2Jv1QXzOSCdGcfH9abrnXJQCxq
	uXP9N9V5srusRQrV8zK6zp0eLbba9G6yHMSMj8OcVe+vKcouxwJ/ltAWV2IdUSlP+MG/0p
	qtVHa/eLKbsWbAIXYM+xDRZ4cz3wW7yb2TAV9IvXwog67OZEvis7WKy0JDpb3kCwiCSsoK
	2YERZfUax4hsMZdMBxJFuxqn6o1UTYIA2rE7YIFwso80zyYlfAwRqvTpR9mfLA/n6NAOsh
	6AbDWCn11P3+Ql49TRdTufBBlhPwP5pC20YVtn+E/BdNL4hKEaWMUv1ZA6I3OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795524393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PrE/2EutqnuvtKyH9pmay9A73YFzmvHWuTlKzL38kgM=;
	b=HWF1Ob8DVxs2rp1O7E5VktcBufJAdmiaJRVd07LMOkPPCGpTC3hANMs6TeQUvYKJPu0D1C
	Fh6J0bAEZF7wNdfXSiKBJxV0KTbhjHRHmAaC+iNE433STyvTMV9Oq30EmiIMbCMf0jHmRi
	58Qnk8wwEEdLj27tfKY0vXTEhTeGMo4zQ3HO135Ip2Kix73Lr4mZy39pVuGVUUf4VmxL5V
	NGOxr23BJvLZzFRtdaN+MG5k823P09Px6X7nQOkFTamXOLTQJ7lTa4JoHykPgBvdzzqqsr
	fLMLfbTL/7R2ENsn3XHnURmhmJK3nhh3tLh95q10YtT2KcY7YlwYq+TydobGRQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795524393; a=rsa-sha256;
	cv=none;
	b=N5ctTLONOLEapJFTG4NHceOG7MGQi8v0fsk6Myu2CvORGIRBj1owFEVd8Woi6IRtymbaim
	SubjJHrFXzJQmWEDDZgBkJV1AtnB5OKlc6NI89E+gC7knEiXgnNk0Kv9W+MBCfpaLfdXHz
	ssgQtSAP+gjsjkrR1XDywvzcx4VhMC/+vQkPeZmh+8TEIC7g21HapChAdB6nSJF2amguaE
	KyCpRisO2eB/tSJE78/kd8rQMreZPLaeWAO4V0r4Q9suQYh4mas7Wet9qD0W918YvgeqOv
	u3O4ZZDpd2rasU9EYJcIzpbdw2bsrlhWaj0woSkFltDxDu2/7/40zEsdGEDGXw==
Date: Tue, 24 Nov 2026 13:46:32 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Kendall Willis <k-willis@ti.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, 
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>, s-kochidanadu@ti.com, a-kaur@ti.com, s-tripathi1@ti.com, 
	vishalm@ti.com, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v9 0/2] can: m_can: introduce ti,am62-mcan compatible for
 out-of-band wakeup
Message-ID: <20261124-maroon-taipan-of-cookies-2d9113-mkl@pengutronix.de>
References: <20261117-temp-v9-0-1d094ff918c6@ti.com>
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
	protocol="application/pgp-signature"; boundary="ygwwdgt7z67h2i6w"
Content-Disposition: inline
In-Reply-To: <20261117-temp-v9-0-1d094ff918c6@ti.com>


--ygwwdgt7z67h2i6w
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v9 0/2] can: m_can: introduce ti,am62-mcan compatible for
 out-of-band wakeup
MIME-Version: 1.0

On 17.11.2026 15:22:13, Kendall Willis wrote:
> This series introduces the "ti,am62-mcan" compatible which adds support
> for out-of-band wakeup capability in m_can devices.
>
> A corresponding DTS series enabling this feature on TI K3 AM62 family
> of devices has been submitted separately:
> "arm64: dts: ti: use ti,am62-mcan compatible for m_can devices" [1]

This series looks good, but it depends on Markus' work. But LLM based
review has found some issues ranked medium.

| https://sashiko.dev/#/patchset/20261016-v7-3-topic-mcan-suspend-fix-fix-v=
2-0-7efa2b172cce@baylibre.com
| https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016-v7-3-topic-m=
can-suspend-fix-fix-v2-0-7efa2b172cce@baylibre.com

Without any comments by the author, Upstream will not take any patches
with "medium" open issues.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ygwwdgt7z67h2i6w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCawWHJgAKCRDMOmT6rpmt
0mZDAP4+xP661BQH3gc8cnY01JgJSp7Gu4QLt4YaenIUCqmWEAEAhwDjEIyQY/Zl
5udjh/5pvJWBiQYFlAp2vKaX6ZzDkgU=
=gMnn
-----END PGP SIGNATURE-----

--ygwwdgt7z67h2i6w--
