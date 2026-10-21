Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792573994;
	b=I0N5ndYIjGgFj1bIFtsWerDoBP8tldd6v7jCCJ3MXsmqShtl3ZKaWcbeKxF0yikoUbFa
	 RkibSaKJjx7Lmwhbr0vDWRbC9Kqi9ydYJQD/xGbatgR+DyOzkvvKSfXjlwW88QVZPc9DF
	 V1NdUUkhBxUZGJ7686sZ4/ytoKZr4GhpiyXPEYKvxVWVK05rWMFyV6jmzvo+U/KrW1pzc
	 0y7AibhhGDgxLuPHSi0Pqpxjxc2GWPNd6YSZHezswyuveK2GYNUUBHBZOGRXQ9vstFK/1
	 JhzZXNglSBnf1dQ2+cSbH7p+KS6yqBpfklhM2CAy2R5JT5JVrZaxtrzAs3sE3UNWQ7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792573994;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=6UnyTE8YdVqXXHsmAqFhz9bW7tDaewkdAEnQTcsP4jA=;
	b=o3LKrsjUy7oKfiMCVbCzs+qMT5w4+proAqpEW+RRa/AtbJArTB47+MXYx50OJRqbY8v+
	 hvaZbll6lHpgMZPRh0BbBOT0gar3WUB767ejnCrA3EHr2sZPclt3hdB+wNOfR/GmEs4De
	 kGYnnFMX/fTv5fZBKSREKXfAeZuZAN0WOV5+FPji11ioesvxvx5xVk3zrkco60BetO62e
	 K30/VVIJHXCyTxqMCpst5LJtZ2RULcy8Ah4TiI3mmJJgKY4cN2O+P4sibLQQgRWdGZGRD
	 HT/BQMs/yv6Jc2Jcj9tWQwpqNWMZQJ8qLhHRr8aoEwiQxbfygUIUcZqlGl/YlOKCMUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="Kc/pkpd5";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962B5606A323;
	Wed, 21 Oct 2026 09:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 962B5606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Kc/pkpd5
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 14CF7201E7D;
	Wed, 21 Oct 2026 11:13:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792573992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6UnyTE8YdVqXXHsmAqFhz9bW7tDaewkdAEnQTcsP4jA=;
	b=Kc/pkpd5fZPJQ112+cJHKX1dwaPC3ZEVtIXBY8DW0g6XP/XiiGPhqxKrM5j9szpvNwc+DX
	BxCSFT13PSB5RUUo1nhfPKyLrSRofwOl1Qr1JCV9dz6IUFOINm4L6d0aGqhIdQsJ2E/54w
	GdLjx1NExDYBWlF88DGvxYJXbZAscAUR29ALm/1YqKyxfx852rbHr4uPyK5dSQfJ+80LRe
	lNQBJv764E+5GujXjXdjslBCnXHgO9tnqKOBnT4fBc+WI3Tr4n72jIQq2XKoIC47MaZN34
	UkF58gar0UoMGjSY0COWzU5636jWppYwyoMTGvfOKHFnMrTWUEkb/aBZ9QC4QQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792573992; a=rsa-sha256;
	cv=none;
	b=KCGDzIgrUov/aAz3NIyhjSnr+cVEI+jR+14wdbGXsp8p3ApxSgfI0y3fN2dQKIdYic1Te+
	C+yiVJ+xYMnwYVDwMYjQr/zpFEB0reeQP2e8YbDBqw7xQgN7NO31Hae2wsdeDI0usyARaI
	FgbF2aVc5x8RUKWcio+tZ2RixJ3gje+ma3878Y8IX8IfJxVI4siFNP3x126nPf8Q3h+m7b
	gbmo4f9nBfZrTlLRWagRQCsDANmzMqqvUjtucvHQGNgwvQq9dJ31Q2QJBqVDfI53pqjStM
	PGHUxKVXGM11Rhz86549xGPsA6PLQm92v5vrEgQa8ulCPA4KeixsUIfQ2O7ttQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792573992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6UnyTE8YdVqXXHsmAqFhz9bW7tDaewkdAEnQTcsP4jA=;
	b=Rs0OrXdeKpB/W6cXPVygQD53L1ewBoLTCYgJEyS/rWyIdIcq08rhfs5jCZvnRt1/Tkoa/2
	oHDdLCjYmB/8Da6I2Q5epTGqafCRgXlUc6/V9yO48u5Kiyoz1OOE5c6ugZTPwRkPD2SayG
	vjOdQSPgK3je8cSx8iFcf01hTW/1rXWdbwIFHjxLu5IWGk0CGhRW1cOW5wY2IOUzm2kadN
	MSuqIFz92GMNnHqktzorJ0JVLSyce2AQGaoz4224S982MjEgxTQUfx7JJpxPq8XfrSEwwR
	TOcLOFDHDJheox8oiT1dL1c6nMaCsXVlhj1JgQdR/wTjNqBt05g4ivJE1zi1jQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJSNj-000XIv-3B;
	Wed, 21 Oct 2026 11:13:12 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AC3B55CAEC4;
	Wed, 21 Oct 2026 09:13:11 +0000 (UTC)
Date: Wed, 21 Oct 2026 11:13:11 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?utf-8?B?U3TDqXBoYW5l?= Grosjean <s.grosjean@peak-system.fr>, 
	Liu Changjie <liucj1228@outlook.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
	Pengpeng Hou <pengpeng@iscas.ac.cn>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] can: peak_usb: accept short uCAN end-of-list records
Message-ID: <20261021-hospitable-gentle-sheep-a15164-mkl@pengutronix.de>
References: <CH5PR19MB997156AB3BE253C3BE445223B0AC992@CH5PR19MB997156.namprd19.prod.outlook.com>
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
	protocol="application/pgp-signature"; boundary="x7zd6t4z5njwzgor"
Content-Disposition: inline
In-Reply-To: <CH5PR19MB997156AB3BE253C3BE445223B0AC992@CH5PR19MB997156.namprd19.prod.outlook.com>


--x7zd6t4z5njwzgor
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net] can: peak_usb: accept short uCAN end-of-list records
MIME-Version: 1.0

St=C3=A9phane,

can you have a look at this?

On 19.10.2026 00:46:34, Liu Changjie wrote:
> A PCAN-USB FD v2 running firmware 3.2.0 sends a 16-byte status
> record followed by a four-byte zero-size end marker. These transfers
> cause repeated receive-buffer dumps while the interface is up.
>
> pcan_usb_fd_decode_buf() requires a complete 12-byte struct pucan_msg
> before checking the size field, so it rejects the end marker with
> -EBADMSG.
>
> Check that the size field is present before testing for an end marker.
> Require the full header for nonzero-size records and keep the remaining
> record and payload length checks.
>
> Fixes: 93fcab2c6968 ("can: peak_usb: validate uCAN receive record lengths=
")
> Assisted-by: LLM
> Signed-off-by: Liu Changjie <liucj1228@outlook.com>

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--x7zd6t4z5njwzgor
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatiCJQAKCRDMOmT6rpmt
0mpJAP9CGxn+/gDUYPSmZfAVorMBfXjvzX4ku2tz5nVgLW75FAEAuaWUX7qzKKt1
si/m+wrSKSGM1sc7dPlGti8onwzwqQs=
=rZgf
-----END PGP SIGNATURE-----

--x7zd6t4z5njwzgor--
