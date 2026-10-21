Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792593219;
	b=5O+81KQpKR1yjiPE0NdhKQh4xNCelTFJjffrZVe4x6BPtpXzk5MImwUpv5X86SLJZgDu
	 iBk0v/PjWOlrDl3btfz3PDssvNWc0mXbczDPQV/TXidbbvQUzUQ7EEn13yXkL+rTj1d/R
	 UxBOpqQ+mFZyef/o2/VYdSb0szTLhUZf74MHWh3AE0VJejD8Kt1w8P/GKsUxuY0XniGPx
	 6eNzY5UgS6CTyPsHsW9Nd3gr3aC2lJw94F4RxtHCKhWSYh8yiYYRFaalT4yktk7hLSeRz
	 yHLV57Kvr4JEPs0XD7t2RpTSKpAj/Y1f77kOj0r1V6O5yvvRwnGnLQsMRIVPCNQ0Alw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792593219;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=7ik/oiVjdkHBo7ElMCtTnZcFSpE3eIORkZ9pgCcWcjs=;
	b=piPD4XPgm2jIqYVecqmUhLqtYzwhd9rPCxTWBndmYz+YBw1KNWncXYJc186WM12XDddE
	 xfmoUE9A0m5I2mBWLG0RxC0DyxxcoonKyOb7nGMq018hjJzNps5bg/X1C4td9JMCByvmi
	 O4azBEt2dcU1yKFCVKfESZA2F8hbcUESmZuGhzPQ9pvpYVxmh2xZHqF1Cc/3r253YmimZ
	 o3cK1+V1L6bxYbgL8NVUNqqg7mXwbSYOPxyR2M4+JjoYbsA4WdtYnXtCq8yjYlkBEc59k
	 zEpt2QMK8J6cMokBAp2VR+z3kMALReYVrla4HPqHpGCn4vkZ7L7bxRz+343FNRKgGrw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=SR+G0Fys;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CAA606A319;
	Wed, 21 Oct 2026 14:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06CAA606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=SR+G0Fys
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C41F0200F26;
	Wed, 21 Oct 2026 16:33:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792593210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ik/oiVjdkHBo7ElMCtTnZcFSpE3eIORkZ9pgCcWcjs=;
	b=SR+G0FysfE69Ndd6CEhkgMGKnxVn/paFTue0PjcHJNquMB8fTFdJo5SCMvKardXtlAdiwW
	08/RTqNo6+B8YX1zpM5oEeuZjYKR+uRmnVkf7qplxY10AK/PW27x6gqNYyIi7erygvX+IG
	O1X9qg8dUpcXh4j6V5ITgWyYQ1XCKuzxxuU8Jgt5P1LnCwr1/FuItRv3NQnWNV5SVDekDh
	OwKWI9bZAm7mZ9shFFYq418Rrj3Qji7HBvofBgJ0yDMMqO++IzMJGZzw8jallW9wZE0R8e
	Q8MqzcvjuIIvMoxTn9fedIdgR+4jnco9oW4grbvXeSRXZpHojRBEd3Uk4abW8w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792593210; a=rsa-sha256;
	cv=none;
	b=D2Q49JIbbz1k8eZCfllgFBn6TfO7P7336B73LKtrwcfvmAuAXD28Zq+28nrPse8d4LcBnf
	VqFduH4vvqCTJ7f0/DeRsU64l9r37siEatciIf+K+yXR3dvYpA4qGJnDdAKc9dSWb1O6yj
	nC2uHd8Vb/pz23Bfci5yma2AyVI+eL0n0p/1UrrNGJ+aVz78vtlWvFybeStI9rXZXYRANz
	FeUW9AG/ayV/BNM8L9dMInB4ZNeS/cRmJB/xWzU0hxah7ms0jdTAyf/72iRBcnbR16+Jqo
	RC1E91SRu5lzGhblTZE5TiilmRtr8wyW62kg1lKFYYiWW4gXSAbtHv158skVyg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792593210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ik/oiVjdkHBo7ElMCtTnZcFSpE3eIORkZ9pgCcWcjs=;
	b=HbMvErN723eYYnN2A8MoTNqQ3PKExALb26xuxTpG+P1ZivyIL3gVr0VDUW0uPFD4VIa7H8
	cQq2b4IFGDEx2s5vIxjTbTidQDOU/fqmvj5OOZ/GfPZjFvW9wBai/HfKBBPRtVPqo21ek0
	fSnWCfzjEeKPbFVGD/sLX/8pmo77TsdSD5ffwz2NOjAk/R+mntrioPsRPx9YLXOi0vRHnX
	RzP6hjJmZjTgSPp4g9e5hYj9uQ9gu/HbP7mCmnrzEz7Q4k6nvPcFRHb1sK1BOYJzITxJMx
	cWEBPcPN3ABu/masP2nPgrhr6E+YZQe9O5waE2hOQhwvFRd/3rzTBHtYBkuDJw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJXNi-000ZPe-2I;
	Wed, 21 Oct 2026 16:33:30 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 680995D01AC;
	Wed, 21 Oct 2026 14:33:30 +0000 (UTC)
Date: Wed, 21 Oct 2026 16:33:30 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@free.fr>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
	Pengpeng Hou <pengpeng@iscas.ac.cn>, linux-kernel@vger.kernel.org, 
	=?utf-8?B?U3TDqXBoYW5l?= Grosjean <s.grosjean@peak-system.fr>, Liu Changjie <liucj1228@outlook.com>
Subject: Re: [PATCH net] can: peak_usb: accept short uCAN end-of-list records
Message-ID: <20261021-gopher-of-exotic-tempest-0ccc5d-mkl@pengutronix.de>
References: <20261021-hospitable-gentle-sheep-a15164-mkl@pengutronix.de>
 <942111184.1248111675.1792578029862.JavaMail.root@zimbra65-e11.priv.proxad.net>
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
	protocol="application/pgp-signature"; boundary="tz7dh2zsqqjrego6"
Content-Disposition: inline
In-Reply-To: <942111184.1248111675.1792578029862.JavaMail.root@zimbra65-e11.priv.proxad.net>


--tz7dh2zsqqjrego6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net] can: peak_usb: accept short uCAN end-of-list records
MIME-Version: 1.0

On 21.10.2026 12:20:29, St=C3=A9phane Grosjean wrote:
> On 19.10.2026 00:46:34, Liu Changjie wrote:
> > A PCAN-USB FD v2 running firmware 3.2.0 sends a 16-byte status
> > record followed by a four-byte zero-size end marker. These transfers
> > cause repeated receive-buffer dumps while the interface is up.
> >
> > pcan_usb_fd_decode_buf() requires a complete 12-byte struct pucan_msg
> > before checking the size field, so it rejects the end marker with
> > -EBADMSG.
>
> Right: the firmware may terminate a list of records with a short null
> record, and it doesn't need to be a full struct pucan_msg. Only its size
> field matters.

Thanks.

> The patch keeps all the record length checks added by 93fcab2c6968 and
> only accepts the end marker earlier, so:
>
> Reviewed-by: St=C3=A9phane Grosjean <s.grosjean@peak-system.fr>
>
> Marc, since 93fcab2c6968 has been backported to the 6.6, 6.12 and 7.1
> stable trees, could you add "Cc: stable@vger.kernel.org" when applying?

Done.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--tz7dh2zsqqjrego6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatjNNwAKCRDMOmT6rpmt
0iMqAP9eWM8Tr67SpjlIHkyTipV1+jqYO1sroNw4iUH/4HlKlAD/QuI/NNqh3ADI
PhMhp1kuSm7+eV2iV4qDvvetHTeizAo=
=vLFc
-----END PGP SIGNATURE-----

--tz7dh2zsqqjrego6--
