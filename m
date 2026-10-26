Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793034016;
	b=FtBBz9aR8yHxwWRooMMy3VrjvlLgXNnPs/fplylyTUFtDBzWZki0nDhF3m9vIxpiaz28
	 mxa4HIFMSNFcQpF/YCtvBxBuC+LKpV3uGmoh3VwBSFexTlwQyoyMujRGL2QEi5AqStxWL
	 QHz4cD1GQmov0QP04Yn7jUkR1LK407TgOzjzKyapLISr5/wcEv9uYrLweWnCgGlu/e2kq
	 yM60iNqjBhROqAKrWz36kyPfOyMI8mThRgzLR+531KMgrTNX154bTzxGnQBYRmtcC+yy3
	 Uf4/OFqXobgWJU6HImL5CycGiPnKm1ljQb9FPjPZRIJOYvz/2A3ghpIJkBuBD/vLk1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793034016;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=W8l7m+JnVPU25NGnvlH4v2VvR0Uy628mymn35NGj6CQ=;
	b=U5LzrC8IcBxUcdVvu5nlLsesibafyuaOPIr+qhUE42+DaIeAFsmZBpEtv+EHrYwXUS2b
	 XEHD3jS5L1r4AROLJSlXjA8CYhvbFb9xZDxG26MeCJEKteK57m1QSJ4ZlgseRxnoXyt7Y
	 55ct8Dw53TgzZsUUtk9jYod5bmpWfg+5MeNYdLFvhW92ix97OZmUgiG5mYl02MJURaijR
	 KxawS91k2MSgn3BNFurBAwfBVtfe1lB+z7kGxCK+264iZaFc0A1xd0cGJ9P75TP/l99aQ
	 OBr164ePh0DsYz/Cf8+6N62BdiNc5yB6CFG2rlnGd5DHppJ/5RCQw1hlKJFhf1B2VQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=KF6yxafP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFA9606A322
	for <linux-can@vger.kernel.org>; Mon, 26 Oct 2026 17:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FFA9606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=KF6yxafP
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 60310202859;
	Mon, 26 Oct 2026 18:00:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793034009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W8l7m+JnVPU25NGnvlH4v2VvR0Uy628mymn35NGj6CQ=;
	b=KF6yxafPERT6yqM63eOap1MT4kotkAEFeMWWHb4DQbcQa7kGfwQCMlRmk1x61Tnw7dmJKr
	e8nlPNdIKhJoe+pbZCIfrBccW1O+O/nzyo2ORwiWc2UsZd4w5qIpAxkvqm8UOXfqxnbYaz
	nGXUE30KGlWjyURq/tDoJphK+pwKYLG8BMYStQzlO+S6xvygMXZzaO6gwH3IVTo1ttKOHa
	NWFD9ZiSD1wcWKGs9PQp+/UlO5lzSeRWzXHYSXvqo7Nu+jtmXl+efOnylJSyfyc4MV4yng
	xFM1173c5GKgVkKqHkGddIYgWUoF43WcOHBNPfGg6tkVT3x/ah/7BN72HD+Xaw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793034009; a=rsa-sha256;
	cv=none;
	b=GRkphiJUpdN/oYZDJr9kLKMq65dyxNtD44QPRjqO8P6oh9qKXg9nvBhDv8w1t6QfYypAvh
	Hikj8KM9e2e3kB4oD4sX+gR+wMu+6XpeKvbMiu9fiL14KMVNoadOI4atifHdgRbgNs1Vj2
	8I4jz27yrf/FKQwrnUg29O9tY0Dv0vjdAdmr24CX1SP2mzJje6VxTbEI2iU2vwU5JJ4bH+
	ZaZGn6VXan+lcMzohWZdqHegFSqcJrigwAdkJPBZVf28HZPkrONcLLv6D9k2XCiyuS69wz
	zqUiEGpj34K6WHiKV27bw+dHMW8G8Uz2GTb4/wWgJqv4CS/MIx+358eThUz1Hg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793034009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W8l7m+JnVPU25NGnvlH4v2VvR0Uy628mymn35NGj6CQ=;
	b=ek/8WO71snaykh93RO9A4En+SlH5oY257zJ9iLTahVXzm/Mhr3oIue41K7GlGufp5ahDlb
	8R1HD4/aMBBAUFKr1US+YYV0Q5KK8BdRY0PF4gwIs1I+OzjKhTc3Us9+sOR1sgHXuNxkWL
	t6OF9E5bQx/F44ziWmZsTFWnsH1XDpK6om4hIF+5JPgt69/bkIJiAgY7xWglYwBOBvwhii
	z587xBHYTj/mLQIFY23lje9yq9CdENLjPxsiCutbgcfdvKAcKmEv6fJ74E34WGA+SvhNzF
	cdVU3xrLtmHfDeqlhMZH44nCJ6g8DB17bqPCfjFp5QhfcqaTFhIAjbwt1Rx6kA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xLO3N-001JGJ-0o;
	Mon, 26 Oct 2026 18:00:09 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 015FE5D71C6;
	Mon, 26 Oct 2026 17:00:09 +0000 (UTC)
Date: Mon, 26 Oct 2026 18:00:07 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: sashiko-bot@kernel.org
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Vincent Mailhol <mailhol@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH v3 2/4] can: gs_usb: gs_usb_probe(): init netdev
 completely before register_candev()
Message-ID: <20261026-persimmon-toucanet-of-cleaning-5f6789-mkl@pengutronix.de>
References: <20261026-gs_usb-fixes-v3-0-3a68f1f62813@pengutronix.de>
 <20261026-gs_usb-fixes-v3-2-3a68f1f62813@pengutronix.de>
 <sashiko-outbox-185562@kernel.org>
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
	protocol="application/pgp-signature"; boundary="gnzre6zu4c3hv6vn"
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-185562@kernel.org>


--gnzre6zu4c3hv6vn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/4] can: gs_usb: gs_usb_probe(): init netdev
 completely before register_candev()
MIME-Version: 1.0

On 26.10.2026 16:55:09, sashiko-bot@kernel.org wrote:
> [Severity: High]
> Can this dereference an error pointer in gs_destroy_candev() if
> gs_make_candev() fails during gs_usb_probe() in drivers/net/can/usb/gs_us=
b.c?
>
> When gs_make_candev() fails (for example, if usb_control_msg_recv() for
> GS_USB_BREQ_BT_CONST or GS_USB_BREQ_BT_CONST_EXT fails, or alloc_candev()
> returns NULL), it returns an ERR_PTR() value which gs_usb_probe() stores =
in
> parent->canch[i]:
>
> 	parent->canch[i] =3D gs_make_candev(i, intf, &dconf);
> 	if (IS_ERR_OR_NULL(parent->canch[i])) {
> 		/* save error code to return later */
> 		rc =3D PTR_ERR(parent->canch[i]);
>
> 		goto out_gs_destroy_candev;
> 	}
>
> In the out_gs_destroy_candev cleanup loop, the check only tests
> !parent->canch[i]. Because the failed slot holds a non-NULL ERR_PTR(), it=
 is
> passed to gs_destroy_candev(), which unconditionally dereferences dev via
> can_rx_offload_del(&dev->offload) and free_candev(dev->netdev).
>
> Should the cleanup loop check IS_ERR_OR_NULL(parent->canch[i]) instead of
> !parent->canch[i]?

Will fix.

pw-bot: cr

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gnzre6zu4c3hv6vn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCat+HFQAKCRDMOmT6rpmt
0sffAQCJt+mKtxFSDs3G8/W25lbsdtnLrmMya67zKVvlwoj1/wD/S7OoyNm3MSCP
c+vuR65so2XTHBMMkOVVZEw328yDkQk=
=z1gx
-----END PGP SIGNATURE-----

--gnzre6zu4c3hv6vn--
