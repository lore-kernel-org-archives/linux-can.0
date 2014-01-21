From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v7 08/10] include: can.h: update comment about introduction
 of __kernel_sa_family_t
Date: Tue, 21 Jan 2014 15:28:45 +0100
Message-ID: <52DE841D.5070705@hartkopp.net>
References: <1390309204-19854-1-git-send-email-mkl@pengutronix.de> <1390309204-19854-9-git-send-email-mkl@pengutronix.de> <20140121132055.GB26766@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:53315 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754053AbaAUO2s (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Jan 2014 09:28:48 -0500
In-Reply-To: <20140121132055.GB26766@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org



On 21.01.2014 14:20, Uwe Kleine-K=F6nig wrote:
> Hello Marc,
>=20
> On Tue, Jan 21, 2014 at 02:00:02PM +0100, Marc Kleine-Budde wrote:


> I'd make this:
>=20
> -// typedef unsigned short __kernel_sa_family_t;
> -// introduced in Linux 3.2 commit 6602a4baf4d1a73cc4685a39ef859e1c5d=
df654c
> +/*
> + * This typedef was introduced in Linux v3.1-rc2
> + * (commit 6602a4baf4d1a73cc4685a39ef859e1c5ddf654c) in <linux/socke=
t.h>.
> + * It must be duplicated here to make the can headers self-contained=
=2E
> + */
> + typedef unsigned short __kernel_sa_family_t;
>=20
> and then drop the following hunk. That should work as intended also o=
n
> systems that have kernel headers newer than v3.1-rc2 because a
> duplicated typedef shouldn't hurt. (Note I didn't test that or tried =
to
> find a proof in my C book.)
>=20

Good idea!

I double checked this by simply adding two identical typedefs:

--- a/include/socketcan/can.h
+++ b/include/socketcan/can.h
@@ -126,6 +126,10 @@ struct canfd_frame {
 // typedef unsigned short __kernel_sa_family_t;
 // introduced in Linux 3.2 commit 6602a4baf4d1a73cc4685a39ef859e1c5ddf=
654c

+
+typedef unsigned short __kernel_sa_family_t;
+typedef unsigned short __kernel_sa_family_t;
+
 /**
  * struct sockaddr_can - the sockaddr structure for CAN sockets
  * @can_family:  address family number AF_CAN.

It compiles without problems (and warnings).

Tnx!

Oliver

