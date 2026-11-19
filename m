Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795109564;
	b=UfnNgsLGCFe+9mKlL3ZlK9DC9EnsYhZSruC+fT/kWtNGMADhpnBh/qBwq4D2PfLitEMg
	 wgduNQ0NBqkHjxTHuCNzLbB/JaTa/WcEK1RKBO3G7WIe6tQ3A23rugUK0Y4U9xgoNZb+S
	 C5wcxBgAimc3XjfbR8bkrSBD5NX3e3tClD1i0Vnt783nCCRVMfqwQ/0Hne3UbIla+DDOx
	 zHSQ2RPQ4PYVskDz24jga4Z9l+l1BKJ8fJf+kMYpFMkLH2wUEqFZwm3lOAsakWnPIXzC/
	 YIQn3DqhQgqMjrr3YACzBr+DnE9uCI9nxre6EvbRopf84uJRbMQ/S/CwYp99l8xh9wQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795109564;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=z4LFR8sPTaldPIfzeLWs+kUKX/gW8Rxi8H+3V2no91c=;
	b=IcmK2/nB5RWN66c3tv8k5WiMn05OYlvkojFcsDc8XR7jUEfoGjka/gMgjByUZ0abDklW
	 IHKEIsDgO8HFb9xYAnYD31PgyWyY2fUp441qHQTvBEQ+/fAYIed1nnBiMcNX9sPRf6YNs
	 oFiXlnfmwUvm4oVSkw3P+ZcUZoPffP7odCSVUDJw51y09Dq229T5kSjsBimQCb2vQ78zg
	 95HiPT1yUnIMUavGUVBzyNHDt1nA3WfCtvvTfLPeSHTDd4jwW5DFaBmw32TSjU7mn+PLU
	 hPX0wKdo5gckp41qReNpmlxvoDQt6MMsF52ifxFr3jom7dXE35Os2Ro7WrBa2f6kaCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Dylj0VmD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE4A606A320;
	Thu, 19 Nov 2026 17:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EE4A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Dylj0VmD
Received: from pengutronix.de (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 51D2A2059D4;
	Thu, 19 Nov 2026 18:32:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795109557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z4LFR8sPTaldPIfzeLWs+kUKX/gW8Rxi8H+3V2no91c=;
	b=Dylj0VmD0AxcxdcIpn4dhnMgUcRQoqzARgwe4ovJ21yKD8iPd0yU/YGKlu9/U4Vp25eEBo
	6PC7jZ+3L+jmmfHzRYOaZlAUJRqW4ybBH/y+Kb1DZZUrMDGedgli+NYta5UAW+Sx6D9I6X
	0lsEmtYFRJad2T5Nr0fpfxQ5WNxDppPz4tDir7PHJVoHKVGn2vhvdqK4sTpNuVTeFRrrQV
	JAZ+c0iMBTf9OvQf6ZWlMgZaanJhcsROmvGevJL/svjXzA5Ivbdqny0+p9bvZpV2Talt4G
	LosN9gM3PiJVBY+JTVQkPz75zKcSGSIrp4RRTPIDnlf0Bw9p00ykDDMSkuskmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795109557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z4LFR8sPTaldPIfzeLWs+kUKX/gW8Rxi8H+3V2no91c=;
	b=Zp3rdxB+++gIZ93q4ne3Tuz0SSlfY0/91QM5LPiDOBTpRsG9wh1zrkwyEWeXDdTc1DkOaI
	OuQMlTxbi+BeQKQfF5Su/uns4xz1tCDlNIZKuvZRSkbTrZ5K7WUw2f6IE13lMF2nJePsS5
	YVeO+hgNtRj/YxzdmX8wgtbvEkwWNA+invG44cn8ccdHLAKA4YyaFsRZtRw9vcV1UmeIJT
	nbkV6nxebNzNoj6oEX6H5Cqe+MRMsu0bcTuYsx3xLqg+HDrkjbi5ePIHFXYnLbcVnSotnO
	ndI8U6Ff0Lc8KnEZynNNYwz0dDtvJ//e7T7pRzBJCX4R6nHP0F62HpMAwUm8bA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795109557; a=rsa-sha256;
	cv=none;
	b=KdzSC7R/VPogBAd3UClopzznGvFgBNmCEfIEBtjNRldg9kvAVh6phQNecj95w3QZiC9NHe
	3f2kQfFLhim17lowHoegW//eMBg/7jY87pY6TCMYAcCl7kgSWTWb6qtfDZrvWkYWePC2vs
	25vbJknT4hsaRVhpqQIk6VRzdPBjjIFz3C4x5l88ATQM2nNPLBjZyihuVWiM2HRc2HUqwb
	ni9rBAIVzu/qXADq/PHb5TQwH+bnh3BEa1RHsW1HQKtrHKkXaYSPUJn2mdUN/ScPZYvfbR
	48UJ4YU+7Zw5ePQpf5g9v+B7e35IxA5Gnf1kuHnPV1Gbkn9mxGwrvV75MguIxw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Date: Thu, 19 Nov 2026 18:32:37 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	linux-can@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH net 0/11] pull-request: can 2026-11-17
Message-ID: <20261119-gifted-tapir-of-courtesy-408880-mkl@pengutronix.de>
References: <20261117220818.1142581-1-mkl@pengutronix.de>
 <f29308ea-4493-4146-bb28-506522040ce8@hartkopp.net>
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
	protocol="application/pgp-signature"; boundary="gunyr36roytbrewh"
Content-Disposition: inline
In-Reply-To: <f29308ea-4493-4146-bb28-506522040ce8@hartkopp.net>


--gunyr36roytbrewh
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 0/11] pull-request: can 2026-11-17
MIME-Version: 1.0

On 19.11.2026 17:53:14, Oliver Hartkopp wrote:
> unfortunately we did not make it into the net-PR for -rc4.
>
> Do you want me to re-spin my series to address the Sashiko remarks and
> commit rewordings for this PR?
>
> If so I would answer one of the reviews with a pw bot cr tag.

make it so

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gunyr36roytbrewh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCav8yrgAKCRDMOmT6rpmt
0prpAQDkhTEdwmg4aFItagLk27UJ6xEZ3Qk+B3PYlnvMUv9UUQD8DRYVlzzbP21Z
htuLtC/mIZZ0Sj3wnp6U8Zze2nnRwQM=
=23nH
-----END PGP SIGNATURE-----

--gunyr36roytbrewh--
