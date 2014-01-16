From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v5 5/5] include: Move includes copied from the Linux
 kernel into include/linux
Date: Thu, 16 Jan 2014 20:28:18 +0100
Message-ID: <20140116192818.GC25911@pengutronix.de>
References: <1389888754-23013-1-git-send-email-mkl@pengutronix.de>
 <1389888754-23013-6-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41701 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbaAPT2T (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 16 Jan 2014 14:28:19 -0500
Content-Disposition: inline
In-Reply-To: <1389888754-23013-6-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Hello Marc,

On Thu, Jan 16, 2014 at 05:12:34PM +0100, Marc Kleine-Budde wrote:
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> This makes it possible to update the copies more easily, e.g.:
>=20
> 	cd $path_to_linux_repo
> 	make headers_install
> 	rsync -a --delete --exclude .\* usr/include/linux/can* $path_to_can_=
utils/include/linux
>=20
> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
I want to have pointed out in the commit log that it was you who added
isotp.h to the move. I don't care that much for your split into two
patches to fix the #includes first, but IMHO that should be documented,
too.

Otherwise thanks for picking up my work
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
