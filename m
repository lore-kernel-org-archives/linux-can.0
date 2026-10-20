Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792499249;
	b=yZ+w/SCQWiIz6v1yg7EKXdaDA+01N9eFInnKQ6spEA5qIYFLqCqRDrUJ4kd37TOnOHao
	 n40woR6XFbHui4GjAf2aeWWm+wm+d2GO4y+vj1T4AocLekISV0sU0h5gCGQVJtW6KjGDp
	 GzKfN6HkJA/nmHxPkJvfk2+tzbCdGdhB2Uy/xl3w0M3/wejIwcb/iWEaplNpDJuati827
	 gSAMJLVTV65EligFL1crNffIKc0E/0oKgwDEdbxkHlvt4cGPlG5v27+6I0g9KlZRKcoI6
	 UslqzE3zugqUJlofZT0tzshCbTOkwmu0g9CGA7TODUs04DeGtkQ4i4VaO6sa3WuqSkg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792499249;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=bQZrK2buUkdekqvwc7WqNNKf8yBuJZqVaItrIpWrTbo=;
	b=H67ZUn6dJ1oEGH0TZqCaLuSEHeRTQ2M+pyTa5OUiZr9cKpCqTp7FGRPUClTgOjJweW1Y
	 m/x4vwoxJoaUq0B4MVwbTnk50DazxaS7+4EVnI5jULBrnWyqziGABbYyqu9xRZk1YdoUw
	 uzwIHJfnCCUffaBNXFQd/xZFNoP5FkwAUfUsdBoi0X+eszK0VVFnpgMRUPIXOHKTGQnyx
	 GVjtoHi214XTWs6cMQJKBGH128NsrP0yBw8z6h/mXFQucmdAm4OMNcjKCIfCZXz4PPQD+
	 Ot+X3wHM5Kq60+SELYzQQh3e8w42NFiKfNlNtdSBYyasQJqDdaFjsYvHOXtCFt85CjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=KeOYH2qb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DAF60A2609
	for <linux-can@vger.kernel.org>; Tue, 20 Oct 2026 12:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13DAF60A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=KeOYH2qb
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4C282201EA4;
	Tue, 20 Oct 2026 14:27:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792499246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bQZrK2buUkdekqvwc7WqNNKf8yBuJZqVaItrIpWrTbo=;
	b=KeOYH2qbChX2rcLYcDB+66NBTHg7Iu1peYtJgu7912bHXbwk5bhTiz2U8Xs3If4+8AcjcC
	noSLorZWW826EgKF2MI3pO6Kz/l+GWCYlWrFJXJ578gEC6K/YGsu7JNtauGgLqpTLwJYJ6
	Tj5qCiX9GKrJl4iP//Ar/FjU2gr7O/EpLn0Qul3LNlkEPjD/smC/T4viwOMhp4k3D+dom+
	DoXsSSFX+gbjEF4rRi4lqsyv6UrVY12V7SZmIFb28FL0BZNFQvih1lAxczKcjmxC2xvWIE
	twyspzY8WtBXRLccZU+Sh3U4psaoCygd3iIWBTM5ryd0q+95jyCTJWMM2/+3cA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792499246; a=rsa-sha256;
	cv=none;
	b=YiLM5MEUT2Ob1rDTObTH446OXzPCLrBXNHjfBjky9MxaTElzN+XF9FeztShWR18dLAY8g7
	cKTyv31NTTnzwmljIf97YnFs4nDCKtV4aVK+NFc3cvNgtcVq5gWyYRZO4+4wffDT7TUYCC
	7jJ/b3X8eivpB02w0blvmJvNm3o6pdKx7KmigT5nWvUrjon1silbwO9Kwo6SzSuNA3qbLd
	mj4sQwTK7jHYw0leUwhb/SNikbobMBX5qaXqu4YVLrvkNCzYtyLFH3wRLjL0MhBc6xgDVy
	N98i6u3OykEJ72LjbZ4XW9f4Snqq7hyaZpDExnKzy07ppm4GvpnInLmY8+B1GA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792499246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bQZrK2buUkdekqvwc7WqNNKf8yBuJZqVaItrIpWrTbo=;
	b=XdyTce/HNfw+mXm8DuHThwP+Rzx0knH4NNca3oG4I5JEhBFFRPZmQOja4sLi3faJHZ8Jd2
	CYMakKaPowkk8Ji8VSZuVMzUNcWK6LlGhKGDhlp5FXF8jbstSm2zA4uOsesWEmGZ2APjjK
	aiNhFBj8vcJBSC7EPfsi9xERQfpu7T9yzG3SUwScUti1z0kB761iBbJkJwlSqYCSPbokxl
	annPqZ099rEvznSZGvvGxprHcJt7dGk3o7Q861KbKyVDzeEDMcb7iAeUCkzG9KFbDtrrjh
	mSjWp+dfWobJt8WvlMio3idSEwAmGxkepNrawzNsxYNnm6+eH3DADB6LWTlzGA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJ8wA-000N3c-0g;
	Tue, 20 Oct 2026 14:27:26 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E17E55CA10B;
	Tue, 20 Oct 2026 12:27:25 +0000 (UTC)
Date: Tue, 20 Oct 2026 14:27:25 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Filippo Storniolo <fstornio@redhat.com>, 
	sashiko-reviews@lists.linux.dev, Vincent Mailhol <mailhol@kernel.org>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	linux-can@vger.kernel.org
Subject: Re: [PATCH can-next v3 3/3] can: add can diag interface
Message-ID: <20261020-reliable-loris-of-typhoon-255038-mkl@pengutronix.de>
References: <20260904-feat-can-diag-v3-0-bdcebf07b373@redhat.com>
 <20260904-feat-can-diag-v3-3-bdcebf07b373@redhat.com>
 <20260904142606.6FB371F00A3D@smtp.kernel.org>
 <atJHPuFD8dZyoDaj@storniolo-redhat>
 <20261017-delectable-mackerel-of-calibration-1fad6d-mkl@pengutronix.de>
 <20261019134500.58a76643@kernel.org>
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
	protocol="application/pgp-signature"; boundary="clppbbwzt7xn6bra"
Content-Disposition: inline
In-Reply-To: <20261019134500.58a76643@kernel.org>


--clppbbwzt7xn6bra
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v3 3/3] can: add can diag interface
MIME-Version: 1.0

On 19.10.2026 13:45:00, Jakub Kicinski wrote:
> On Sat, 17 Oct 2026 12:10:21 +0200 Marc Kleine-Budde wrote:
> > > I understand the concern, but as far as I can tell no other diag
> > > handler implements this.  Does it make sense to add it only here rath=
er
> > > than as a follow-up done uniformly across all the diag handlers?
> > >
> > > @Marc Kleine-Budde @Oliver Hartkopp what do you think about this?
> > > If you think it could be worth adding this feature, I can do a respin.
> >
> > Let's ask Jakub (Cc'ed), who is the author of these 2 files:
> >
> > | Documentation/userspace-api/netlink/intro.rst
> > | Documentation/core-api/netlink.rst
>
> Sort of up to you, TBH. The AI loves to point this out,
> but I think the fact most Netlink families don't handle
> the inconsistency for 20 years almost proves that we're
> fine without it?

Ok, I think we accept these, too. Filippo, can you update the patch
description with this information to make the bots happy.

pw-bot: cr

Can you fold in this patch that adds context-analysis (and removes not
needed "depends on CAN"). Compile with >=3D clang-23, see
Documentation/dev-tools/context-analysis.rst for details.

Also pleae adjust the subject to always start with "can:".

regards,
Marc

=46rom 843a635efd03a0846a23605ed6a025d8a339de6a Mon Sep 17 00:00:00 2001
=46rom: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 20 Oct 2026 14:07:40 +0200
Subject: [PATCH] can: diag: add context-analysis

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/net/netns/can.h | 2 +-
 net/can/Kconfig         | 1 -
 net/can/Makefile        | 2 ++
 net/can/af_can.c        | 9 ++++++---
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/net/netns/can.h b/include/net/netns/can.h
index d60273d8a95d..da2d1fc8a172 100644
--- a/include/net/netns/can.h
+++ b/include/net/netns/can.h
@@ -40,7 +40,7 @@ struct netns_can {
 #if IS_ENABLED(CONFIG_CAN_DIAG)
 	/* CAN diag support */
 	struct mutex sklist_lock;
-	struct hlist_head sklist;
+	struct hlist_head sklist __guarded_by(&sklist_lock);
 #endif
 };

diff --git a/net/can/Kconfig b/net/can/Kconfig
index bbab2c70326b..6766efe83630 100644
--- a/net/can/Kconfig
+++ b/net/can/Kconfig
@@ -72,7 +72,6 @@ config CAN_ISOTP

 config CAN_DIAG
 	tristate "CAN socket monitoring interface"
-	depends on CAN
 	default m
 	help
 	  Support for CAN socket monitoring interface used by the ss tool.
diff --git a/net/can/Makefile b/net/can/Makefile
index c0ddeb9a012c..7c375220c57f 100644
--- a/net/can/Makefile
+++ b/net/can/Makefile
@@ -3,6 +3,8 @@
 #  Makefile for the Linux Controller Area Network core.
 #

+CONTEXT_ANALYSIS :=3D y
+
 obj-$(CONFIG_CAN)	+=3D can.o
 can-y			:=3D af_can.o
 can-$(CONFIG_PROC_FS)	+=3D proc.o
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 9bade176315a..9e11e9fe9a3d 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -113,12 +113,14 @@ static inline void can_put_proto(const struct can_pro=
to *cp)

 #if IS_ENABLED(CONFIG_CAN_DIAG)
 void lock_can_diag_mutex(struct net *net)
+	__acquires(&net->can.sklist_lock)
 {
 	mutex_lock(&net->can.sklist_lock);
 }
 EXPORT_SYMBOL(lock_can_diag_mutex);

 void unlock_can_diag_mutex(struct net *net)
+	__releases(&net->can.sklist_lock)
 {
 	mutex_unlock(&net->can.sklist_lock);
 }
@@ -866,8 +868,8 @@ static int can_pernet_init(struct net *net)
 	spin_lock_init(&net->can.rcvlists_lock);

 #if IS_ENABLED(CONFIG_CAN_DIAG)
-	mutex_init(&net->can.sklist_lock);
-	INIT_HLIST_HEAD(&net->can.sklist);
+	scoped_guard(mutex_init, &net->can.sklist_lock)
+		INIT_HLIST_HEAD(&net->can.sklist);
 #endif

 	net->can.rx_alldev_list =3D kzalloc_obj(*net->can.rx_alldev_list);
@@ -915,7 +917,8 @@ static void can_pernet_exit(struct net *net)
 	kfree(net->can.rcv_lists_stats);

 #if IS_ENABLED(CONFIG_CAN_DIAG)
-	WARN_ON_ONCE(!hlist_empty(&net->can.sklist));
+	scoped_guard(mutex, &net->can.sklist_lock)
+		WARN_ON_ONCE(!hlist_empty(&net->can.sklist));
 #endif
 }

--
2.53.0

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--clppbbwzt7xn6bra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatdeKwAKCRDMOmT6rpmt
0kQ8AQCMyX9/69v5SpsQ3EFx2blpurW8J5TYJ4EXT+KN8XqQrwD/azQiQe5GrfSZ
4I5+7SLroN7+xlIk2CfwU9c9TYln6g8=
=ovAX
-----END PGP SIGNATURE-----

--clppbbwzt7xn6bra--
