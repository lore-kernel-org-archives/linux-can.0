Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF072F7EF1
	for <linux-can@vger.kernel.org>; Thu,  6 Aug 2026 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786034477; cv=none; b=B3jJqdS1Nkhl+wpzuul+UvSgCh363lQ1sEJ2Rpk8MdIUCNmlndSFn2oZRnJodhHn2TjwJOuDJ3KGO2I74KLDKhYKzRDYjtfWy0a+Sm0KRFJA2HFJ7aZe4HYmA+VyOJcNCMGYKmDiNFx35jOSHSGCLDoh9TWvNOGREK9zm5hWarI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786034477; c=relaxed/simple;
	bh=Smmd+DtH0WdGJlocGNWlidjBgEDwCa2wP+60+Coyu8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vC5GCeE7wUlsNKpVMW6Y/3ibKakOcLTvWDk5OkZRBlMEQswb5f2Zo3Dcn6ZM84UApU6i+Bu8Y3oxFxIhtTuXhgOvGwWK2MVLv05b8LRsGn8TVLxgYJXN2woFJqWAfe+CDBOqCdIPXB+FgYFT4rc7Utn6wWRNKr+xl4HaVRE7jiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2C8F6201FAA;
	Thu, 06 Aug 2026 18:41:08 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ws19Y-0007VL-0F;
	Thu, 06 Aug 2026 18:41:08 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BEC0557D323;
	Thu, 06 Aug 2026 16:41:07 +0000 (UTC)
Date: Thu, 6 Aug 2026 18:41:07 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Filippo Storniolo <fstornio@redhat.com>, 
	Robin van der Gracht <robin@protonic.nl>, Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
	Urs Thuermann <urs.thuermann@volkswagen.de>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-can@vger.kernel.org
Subject: Re: [PATCH can-next v2 2/3] af_can: store socket pointers in struct
 netns_can
Message-ID: <20260806-rebel-debonair-teal-254bbd-mkl@pengutronix.de>
References: <20260806-feat-can-diag-v2-0-832597ee4cb9@redhat.com>
 <20260806-feat-can-diag-v2-2-832597ee4cb9@redhat.com>
 <20260806-eminent-shark-of-patience-1f612d-mkl@pengutronix.de>
 <f89084c5-b98d-442c-8f70-59f07e3b926c@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lh6actqe2l64w6h2"
Content-Disposition: inline
In-Reply-To: <f89084c5-b98d-442c-8f70-59f07e3b926c@hartkopp.net>


--lh6actqe2l64w6h2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v2 2/3] af_can: store socket pointers in struct
 netns_can
MIME-Version: 1.0

On 06.08.2026 17:15:51, Oliver Hartkopp wrote:
>
>
> On 06.08.26 16:16, Marc Kleine-Budde wrote:
> > On 06.08.2026 15:14:14, Filippo Storniolo wrote:
> > > AF_CAN sockets need to be stored in the netns_can structure
> > > in order to be retrieved by the CAN diagnostic module when
> > > a netlink request message is issued by the userspace.
> > >
> > > On socket creation (`can_create()`), add the pointer to the
> > > new socket to `netns_can::sk_list`. During socket release
> > > (`isotp_release()`, `raw_release()`, `j1939_release()`,
> > > `bcm_release()`), remove the corresponding pointer from
> > > this list.
> > >
> > > Since this is a prerequisite of the CAN diagnostic module,
> > > deletes and insert operations are conditioned by
> > > IS_ENABLED(CONFIG_CAN_DIAG).
> > >
> > > Signed-off-by: Filippo Storniolo <fstornio@redhat.com>
> > > ---
> > >   include/linux/can/core.h | 11 +++++++++++
> > >   include/net/netns/can.h  |  6 ++++++
> > >   net/can/af_can.c         | 50 +++++++++++++++++++++++++++++++++++++=
+++++++++++
> > >   net/can/bcm.c            |  2 ++
> > >   net/can/isotp.c          |  2 ++
> > >   net/can/j1939/socket.c   |  2 ++
> > >   net/can/raw.c            |  2 ++
> > >   7 files changed, 75 insertions(+)
> > >
> > > diff --git a/include/linux/can/core.h b/include/linux/can/core.h
> > > index 3287232e3cad..5132f5c89b7c 100644
> > > --- a/include/linux/can/core.h
> > > +++ b/include/linux/can/core.h
> > > @@ -61,4 +61,15 @@ extern int can_send(struct sk_buff *skb, int loop);
> > >   void can_set_skb_uid(struct sk_buff *skb);
> > >   void can_sock_destruct(struct sock *sk);
> > >
> > > +/* function prototypes for the CAN diag module */
> > > +#if IS_ENABLED(CONFIG_CAN_DIAG)
> > > +void lock_can_diag_mutex(struct net *net);
> > > +void unlock_can_diag_mutex(struct net *net);
> > > +void can_add_sock_sklist(struct sock *sk);
> > > +void can_remove_sock_sklist(struct sock *sk);
> > > +#else
> > > +#define can_add_sock_sklist(sk)
> > > +#define can_remove_sock_sklist(sk)
> >
> > Please add static inline functions for these.
>
> AFAIK "inline" is not wanted anymore and checkpatch complains about it.

I'm only talking about the no-op functions. no-op functions must be
"static inline".

With defines we don't have any type checking, with static inline no-ops,
we do.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--lh6actqe2l64w6h2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCanS5IQAKCRDMOmT6rpmt
0sq3AQCEtewzGNZDFKlO7lY4HjcjRJJI/uvuz+GhKzKKRUpc4wEAnfzve5nl56bP
6y0jzKbw3bCzhdjQ1mLkN6KlZdBLxAw=
=b67K
-----END PGP SIGNATURE-----

--lh6actqe2l64w6h2--
