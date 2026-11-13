Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794571347;
	b=R00qCy5016jL91HAmkjQQutd/Z/3UgTaJUPXsFQyG62gIwQqp3APuOg2Nup0b1KexwKW
	 rmtP/MgBduvheVRfr20I6z9uUYEvXtwttZoP6Buu04Zomixwn8p6P3BkFrhZv2E3x8Atm
	 5Z5/c2VdX1wC8xgxpKHSXT5lwZ/eq7asXOTmAYU4+V4K9YvGVp27Qnjk7Hv/tq8RUO6S1
	 Wsz4c1JmGh5uqQS8c+EjqbsnF3a7ylpLIX9def5swmS2AWwD6/CHNqdZVoTrYj/y/zDVM
	 cFcf9dm1nUmwR6dr2DBogqF+YgQyrXVGR3jT9cPtwGCkZNV1VowuxCXKt0d7R1Sz+MA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571347;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=vZ5HLurgjGR5+J9E9AMYXLhkFblPsct3yPoeVRfzIoY=;
	b=V5n5ShrGMXN7LDK4249M78Vyah01SddnJ/OkKRpptHhcn/DN//A75k7eFbKBSxIWS7k4
	 l7pFHWqcWH8PDvrzLYuh/yd15sqRAmz2KY6TbRMeH8rfqg9X0E0ntN8evbCL25CxxUyBy
	 58jsQRjUU0ETTPB1d2MPC+jU9Ffr9g0BPqqhhMzxgvRJKZwHCKnGBIAw5yeUmvuCBbeI6
	 NHsQYozBCW+7k+W0bLoAgW3WuUEGvAQ/RdZWY2e0ixBk6iPxOj9l2YB0fz9qFwIYzwOOv
	 5D/qtN/xtKIFDwkyZTSrEw7+Umyn0dc+na8GAVnKCt3DqdQT2pO63ry9CyoOLbmi1dA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=XlE3mWFI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED035606A8B6
	for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 12:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED035606A8B6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=XlE3mWFI
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C3AC8201544;
	Fri, 13 Nov 2026 13:02:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794571343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vZ5HLurgjGR5+J9E9AMYXLhkFblPsct3yPoeVRfzIoY=;
	b=XlE3mWFIPT8UeUvnsdQFLuj2r23a3dwuBJfaTQjJox+b0te6qvEPSdu65Kgs/8FS1b9ngZ
	TR74ywAJTH4p9ckB9iUUcrFsAEe2T/GyN4xhmlB44qeXcyHVZS5xMnRhgvAUfQoxcgk2is
	A8k4YLGNHv4zNbUImDJ5T6mWroS7ukY6Xh8skOlRhVvysR/zASR9jhNF+0HrQTv8P0ZIsS
	/yzzJ4KOiWGFQAffPrXXR0w4sk84WG3MpmOakaXULglgiVlfCW80BxQ2QQZajbeU/gZ8G6
	NjwzdQL2kl7gglvrJLkYrcBsqt2E45Rls3+fyazS8Al+/VU6o+U83voO3iR+mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794571343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vZ5HLurgjGR5+J9E9AMYXLhkFblPsct3yPoeVRfzIoY=;
	b=KQzxUzbheXJOms2KSf4d3mRaTffCsH0y8oAnhowpaWXKMjwoUhNfRGr4SeS4iJOQaKOwlc
	Tu7bv8f1LOeXmIblTZOkoc8otpSvYmyGiKXbd42V5N0Gr+MvY3uQtKmBBpguNe0s1Aw+F4
	XT2uSzMWMgqCyDO/zWEy5ZGRhloCfnfqvtu4wgkNWoOLX1D2xMuhlQzSsDxZqIF31byi9n
	dOMOTJXq06rJ24dI0eWghre2eI640VeUWx3M0tvvWjTyNKTeY4+MkxFsSZgIe5knETnJnn
	nt0Lr0Sxw8RksNLyXIcU2LFzrqu2uSE3ibegtY89CmoWPtoPRxP1goiD2BdTow==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794571343; a=rsa-sha256;
	cv=none;
	b=HPgbzMRxOxWmxNYQBB8KSekR132YIgDyu7sVsg7gleQQ52QFw0fIsMNF1/iOaDGY9B+10I
	EB/A6UaNrIwfKVHOSqVEmpWaJCmEsBO4HiYgRiypbQ/BvhTs6d0AC/a4lNQ8Q3oztKtn5n
	zmyD/I5rdRzre455C6SEhAyEwu99yy+wLF0weLr3V6gtmgBNeeC+1vI+JVFpKNKfwpaUvl
	xdxX7CHg8BZwk6ogtvMg3tfuKqEb/7qaaZrUNw6kvhcIGmz9ugk+Gzu/uijPc6DIKTkDJa
	2hZQDY+k2SwPBJp9P7MT/kp8jrxpEbAVFGKOYi0jHK/X0HXDPKA3VTiDBzc2mg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xRpz5-003z3o-2G;
	Fri, 13 Nov 2026 13:02:23 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6243B5EA99E;
	Fri, 13 Nov 2026 12:02:23 +0000 (UTC)
Date: Fri, 13 Nov 2026 13:02:23 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Filippo Storniolo <fstornio@redhat.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
	Robin van der Gracht <robin@protonic.nl>, Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
	Urs Thuermann <urs.thuermann@volkswagen.de>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Davide Caratti <dcaratti@redhat.com>, linux-can@vger.kernel.org
Subject: Re: [PATCH can-next v4 3/3] can: add can diag interface
Message-ID: <20261113-prehistoric-wrasse-of-psychology-4ecfa7-mkl@pengutronix.de>
References: <20261113-feat-can-diag-v4-0-c28842c74c95@redhat.com>
 <20261113-feat-can-diag-v4-3-c28842c74c95@redhat.com>
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
	protocol="application/pgp-signature"; boundary="mzqfksvfvhspe334"
Content-Disposition: inline
In-Reply-To: <20261113-feat-can-diag-v4-3-c28842c74c95@redhat.com>


--mzqfksvfvhspe334
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v4 3/3] can: add can diag interface
MIME-Version: 1.0

On 13.11.2026 12:14:35, Filippo Storniolo wrote:
> +	memset(&can_addr, 0, sizeof(can_addr));
> +
> +	err =3D kernel_getsockname(sk->sk_socket, (struct sockaddr *)&can_addr);
> +	if (err < 0) {
> +		/* Some protocols (e.g. CAN_BCM) do not implement kernel_getsockname().
> +		 * No error returned because the netlink message is still valid.
> +		 */
> +		if (err =3D=3D -EOPNOTSUPP)
> +			goto exit_no_err;
> +
> +		goto cancel_nlmsg_err;
> +	}
> +
> +	rep->cdiag_ifindex =3D can_addr.can_ifindex;
> +
> +	switch (sk->sk_protocol) {
> +	case CAN_ISOTP:
> +	{
> +		canid_t tx_id;
> +		canid_t rx_id;
> +
> +		tx_id =3D can_addr.can_addr.tp.tx_id;
> +		rx_id =3D can_addr.can_addr.tp.rx_id;
> +
> +		err =3D nla_put(skb, CAN_DIAG_ISOTP_TX_ID, sizeof(canid_t), &tx_id);
> +		if (err < 0)
> +			goto cancel_nlmsg_err;
> +
> +		err =3D nla_put(skb, CAN_DIAG_ISOTP_RX_ID, sizeof(canid_t), &rx_id);
> +		if (err < 0)
> +			goto cancel_nlmsg_err;
> +	}
> +		break;
> +	case CAN_J1939:
> +	{
> +		name_t	j1939_name;
> +		pgn_t	j1939_pgn;
> +		__u8	j1939_addr;
> +

Since you re-spin: Nitpick: Don't align with spaces.

> +		j1939_name =3D can_addr.can_addr.j1939.name;
> +		j1939_pgn =3D can_addr.can_addr.j1939.pgn;
> +		j1939_addr =3D can_addr.can_addr.j1939.addr;
> +
> +		err =3D nla_put(skb, CAN_DIAG_J1939_NAME, sizeof(j1939_name), &j1939_n=
ame);
> +		if (err < 0)
> +			goto cancel_nlmsg_err;
> +
> +		err =3D nla_put(skb, CAN_DIAG_J1939_PGN, sizeof(j1939_pgn), &j1939_pgn=
);
> +		if (err < 0)
> +			goto cancel_nlmsg_err;
> +
> +		err =3D nla_put(skb, CAN_DIAG_J1939_ADDR, sizeof(j1939_addr), &j1939_a=
ddr);
> +		if (err < 0)
> +			goto cancel_nlmsg_err;
> +	}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +exit_no_err:
> +	nlmsg_end(skb, nlh);
> +	return 0;
> +
> +cancel_nlmsg_err:
> +	nlmsg_cancel(skb, nlh);
> +	return err;
> +}
> +
> +static int can_diag_dump(struct sk_buff *skb, struct netlink_callback *c=
b)
> +{
> +	int num =3D 0, s_num =3D cb->args[0];
> +	struct can_diag_req *req;
> +	struct net *net;
> +	struct sock *sk;
> +
> +	net =3D sock_net(skb->sk);
> +	req =3D nlmsg_data(cb->nlh);
> +
> +	lock_can_diag_mutex(net);
> +	sk_for_each(sk, &net->can.sklist) {
> +		if (num < s_num)
> +			goto next;
> +
> +		if (sk_diag_fill(sk, skb, req,
> +				 sk_user_ns(NETLINK_CB(cb->skb).sk),
> +				 NETLINK_CB(cb->skb).portid,
> +				 cb->nlh->nlmsg_seq, NLM_F_MULTI,
> +				 sock_i_ino(sk)) < 0)
> +			goto done;
> +next:
> +		num++;
> +	}
> +done:
> +	unlock_can_diag_mutex(net);
> +	cb->args[0] =3D num;
> +
> +	return skb->len;
> +}
> +
> +static int can_diag_handler_dump(struct sk_buff *skb, struct nlmsghdr *h)
> +{
> +	int hdrlen =3D sizeof(struct can_diag_req);
> +	struct net *net =3D sock_net(skb->sk);
> +	struct can_diag_req *req;
> +
> +	if (nlmsg_len(h) < hdrlen)
> +		return -EINVAL;
> +
> +	req =3D nlmsg_data(h);
> +	if (req->sdiag_protocol)
> +		return -EINVAL;
> +
> +	if (h->nlmsg_flags & NLM_F_DUMP) {

Nitpick:

invert the condition and exit early with -EOPNOTSUPP here.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--mzqfksvfvhspe334
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCavb8TAAKCRDMOmT6rpmt
0nEzAP4gH/FGQperyT6W+n6WqTVLR3h0BOnx1Q70sfzFx+okuAD5AUEBwTTn1WgC
4tUIUR6vJi4WJxXhIDC+76JQxf1ymQg=
=YTDB
-----END PGP SIGNATURE-----

--mzqfksvfvhspe334--
