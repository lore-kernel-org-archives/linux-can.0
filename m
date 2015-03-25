From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3] can: ems_usb: mark timestamp as little endian
Date: Wed, 25 Mar 2015 11:15:17 +0100
Message-ID: <20150325101517.GC32677@pengutronix.de>
References: <1427278417-22705-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58190 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005AbbCYKPT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 25 Mar 2015 06:15:19 -0400
Content-Disposition: inline
In-Reply-To: <1427278417-22705-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, haas@ems-wuensche.com

On Wed, Mar 25, 2015 at 11:13:37AM +0100, Marc Kleine-Budde wrote:
> The struct ems_cpc_msg describes the a message received from the USB =
device,
> which uses little endian byte order. This patch marks the timestamp i=
n struct
> ems_cpc_msg accordingly.
>=20
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

> ---
> chagnes since v2:
> - even better description (thanks again to Uwe)
:-)

Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
