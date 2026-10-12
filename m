Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33860379EDA;
	Mon, 12 Oct 2026 13:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810581; cv=pass; b=ia/OGWLWVZgKKukYeSij3MPHZt43KCJm7kO/1SuLlqtvfa7kit1lD+gxApWXWYRyZulVzEmmwcT38rG0msby/CCTWKjTtqDBks7YU5pQiDP6UfN2zm5C39bN+08XfSuoJaCI4mJGerN7QixQALkZdhuIq1e+fXdq9/kPEHCYj/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810581; c=relaxed/simple;
	bh=ckJeH8UlOQcHS5tXYGtW+sbrMa6YcaXhaS2xfncKcw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQpupfBGOf01tnEedrctT8G08s5gC9l/xadEHMDXww0SCG8y4rdyb/QUqOhdL3uZPJd/t2laNZ+dDnMzzN9/BD5aKfq0D4mWPsXsOjWPViF5vY8ndLNTsmKTTcYAjC+22l+Ux7hcxgTZbOT3/mEdQuIoNBO3xoBz2M3v5k8nQeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Hw/GsrJ6; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Hw/GsrJ6"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2E23320233C;
	Mon, 12 Oct 2026 15:09:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791810577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cwLfHMPhcddlknPfwFZyF2QiFj37J+9JWjxKfVp6zXY=;
	b=Hw/GsrJ6wCt82+XJkvJ3ScDlDFjaKVa7K02GlWmupCFM5yQO6I2H81di3y6ud72d4aG7H+
	cavRqhGITm2mW5jw1b9GsFIwB+qAX3XXQqLyR8nsopG1AnRU5YgBeNw0VSrLPjvxhcFkix
	60u0XAC7KExz3gp1odCHbJgGNAPIM3gK++GW3LYgU+ICq99/NOvvr3fADBFdcuUPDSVnp7
	9RAmzVXoyQdhH1DBg4q3IZCW1Ivv3+Vk1UI2DQUI2JWu8grS6i5JSfuZxg4386Ut+k63Rh
	25cuKtxZIrbwiyzTKvTUzcxmxXgoLSGzHyk0VcQHAEYEGu44ZruU6OaeQdZ9mA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791810577; a=rsa-sha256;
	cv=none;
	b=Zt9YJ/9EgcKEVHIJKxeIN+ECEH2sT68Xx5EHBg6FCwMwgOKLuqmqUnEEJ0DTKLn00tGr7Y
	g37ugygMDBQb6bWFHQb26XnNTM10+tNzyt+Gl6jLRFxWQpp7NDvnnNgo2RhfcwSvKznr1m
	JM+xczi2rF9OuwdjV+rXI1hYw7vRMgdQanyo7xGx+VKMnKx7YJ8NX20cTsJ0/eW+wyEdJ/
	CV7GM/LKi8x4vUvCa/+o1/hbXUcvFQhtdVsSRUTi/8dNhpcb6lkIs/lcxiOnancvscN7gN
	/ylpVxD88AwDkL5A09Yt9m1sbRkvQb+DU2OGMBZdSxy1I+IVwN8Ui5sLsqTCNQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791810577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cwLfHMPhcddlknPfwFZyF2QiFj37J+9JWjxKfVp6zXY=;
	b=ALyaqma+UvezCoc5Y+O8HcY0CrOvEvV3tLgHJxzgAU1fulRDOj5z6EwbApuoQdozVAM5pX
	58WhSXEniFAbAKq4dp04dMiEkQfyFDchZXDJLuLxWarHbT5oITq2OXLOeQFo2Z5vS9nThZ
	xefiCcf8uIaBo2CkklYOI2zneiU9w8Trvq2O+0zA/MoXbQ11swNxZMepDHQdAZ87iezeXH
	KNDdt44oXEp1Q5zH1ajdb9V5Ule9MifXEl7oSPoAM91o2VcUwXzxvG2f8Umym/XGtwGeef
	1UrknBTOTcXjN7hUXfB+RTc4nA8jhRsD//4rckl328olLHR51mut7uEubYLVbA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xGFmb-005X5l-0G;
	Mon, 12 Oct 2026 15:09:37 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C209E5C208D;
	Mon, 12 Oct 2026 13:09:36 +0000 (UTC)
Date: Mon, 12 Oct 2026 15:09:36 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org, 
	kernel@pengutronix.de, hemanth.selam@gmail.com
Subject: Re: [PATCH net-next 03/37] can: convert unreliable ARPHRD_CAN type
 checks to robust can_get_ml_priv()
Message-ID: <20261012-victorious-sponge-of-progress-f32376-mkl@pengutronix.de>
References: <20261009134323.64064-4-mkl@pengutronix.de>
 <179164096840.434549.11863787117718202775@kernel.org>
 <135a3c74-078a-48eb-9c2a-ef1abe55cb5a@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r6uis5calrxcbkl3"
Content-Disposition: inline
In-Reply-To: <135a3c74-078a-48eb-9c2a-ef1abe55cb5a@hartkopp.net>


--r6uis5calrxcbkl3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 03/37] can: convert unreliable ARPHRD_CAN type
 checks to robust can_get_ml_priv()
MIME-Version: 1.0

On 12.10.2026 14:58:09, Oliver Hartkopp wrote:
>
>
> On 10.10.26 16:02, netdev-bot+sashiko@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found more severe
> > issue(s) in other patches of this series. This mail is only an FYI, in =
case
> > you want to address the nit picks below when you respin.
> >
> > Low priority / nit picks for your consideration:
> >
> > - [Low] The commit message calls the change a conversion of 'unreliable'
> >    ARPHRD_CAN checks to 'robust' can_get_ml_priv() checks.
> >
> > Pre-existing issues:
> > - [Medium] This problem wasn't introduced by this patch, but isotp_bind=
()
> >    in net/can/isotp.c ignores the return values of both can_rx_register=
()=E2=80=A6
> >
> > --
> >
> > can: convert unreliable ARPHRD_CAN type checks to robust can_get_ml_pri=
v()
> >
> > This patch replaces the remaining dev->type !=3D ARPHRD_CAN checks in
> > af_can, bcm, gw, isotp and raw with can_get_ml_priv(). The reason given=
 is
> > that TUNSETLINK can switch a down TUN/TAP device to ARPHRD_CAN while its
> > ml_priv stays NULL.
> >
> > Link: https://patch.msgid.link/20261009121115.61012-1-socketcan@hartkop=
p.net
> >
> > > diff --git a/net/can/af_can.c b/net/can/af_can.c
> > > index 34fe3b28d576f..dc27ace43719d 100644
> > > --- a/net/can/af_can.c
> > > +++ b/net/can/af_can.c
> >
> > [ ... ]
> >
> > > @@ -519,7 +519,7 @@ void can_rx_unregister(struct net *net, struct ne=
t_device *dev, canid_t can_id,
> > >   	struct can_rcv_lists_stats *rcv_lists_stats =3D net->can.rcv_lists=
_stats;
> > >   	struct can_dev_rcv_lists *dev_rcv_lists;
> > > -	if (dev && dev->type !=3D ARPHRD_CAN)
> > > +	if (dev && !can_get_ml_priv(dev))
> > >   		return;
> >
> > [Severity: Low]
> > The commit message describes this change as replacing "unreliable" chec=
ks
> > with "robust" ones. Should it also say that the change closes a NULL
> > pointer dereference that a user can trigger?
> >
> > Before this patch, the sequence looks like this:
> >
> >    ioctl(TUNSETLINK, ARPHRD_CAN) on a down tun device
> >      tun->dev->type =3D (int) arg;      /* ml_priv stays NULL */
> >    isotp_bind()
> >      old dev->type !=3D ARPHRD_CAN check passes
> >      can_rx_register() returns -ENODEV, return value ignored
> >      so->bound =3D 1; so->dev =3D dev;
> >    isotp_release() or isotp_notify()
> >      can_rx_unregister(net, so->dev, ...)
> >        old dev->type !=3D ARPHRD_CAN guard passes
> >        can_dev_rcv_lists_find()
> >          can_ml =3D can_get_ml_priv(dev);   /* NULL */
> >          return &can_ml->dev_rcv_lists;
> >        hlist_for_each_entry_rcu() walks the near-NULL pointer
> >
> > dev_rcv_lists sits at offset 0 of struct can_ml_priv, so the returned
> > pointer is near-NULL and the list walk oopses.
> >
> > Triggering this only requires owning a tun device, or CAP_NET_ADMIN ins=
ide
> > an unprivileged user namespace.
> >
> > The patch carries a Cc: stable tag. Could the message name the oops in
> > can_rx_unregister() (reached through isotp_release() or isotp_notify())=
 and
> > the privilege needed to trigger it?
>
> Hi Marc,
>
> do you want me to rephrase the commit message?
>
> The referenced "Fixes" commit from Oleksij
> 4e096a18867a5a989b ("net: introduce CAN specific pointer in the struct
> net_device") was introduced in Linux 5.12 but is available in stable 5.10.

please go ahead!

regards,
Marc

pw-bot: cr

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--r6uis5calrxcbkl3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaszcDgAKCRDMOmT6rpmt
0mSsAQDuelT0HxUcHTamM4nKWPRFKQrKACOMxAknDjR1uiVF4wEA4BFVdRRdc17N
7GSZTUmkyKEIlaff9JGFWtU8UCqdoAM=
=+AaR
-----END PGP SIGNATURE-----

--r6uis5calrxcbkl3--
