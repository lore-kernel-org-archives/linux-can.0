From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: make user of struct of_device_id.data const
Date: Fri, 13 Jul 2012 15:35:23 +0200
Message-ID: <20120713133523.GG592@pengutronix.de>
References: <1342184664-10720-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36326 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756809Ab2GMNfZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 13 Jul 2012 09:35:25 -0400
Content-Disposition: inline
In-Reply-To: <1342184664-10720-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de

Hello,

On Fri, Jul 13, 2012 at 03:04:22PM +0200, Marc Kleine-Budde wrote:
> my coworker Uwe just posted a series to make of_device_id.data const =
[1].
> This series changes the users of of_device_id.data to const in the CA=
N tree.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Note that even if the series doesn't go in as is (because more users
might need fixing) these two patches by Marc are nice independently of
actually making of_device_id.data const.

Thanks and best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
