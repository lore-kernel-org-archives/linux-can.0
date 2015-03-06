From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: MOVED TO GITHUB: Linux-CAN user space source repositories
Date: Fri, 6 Mar 2015 08:41:57 +0100
Message-ID: <20150306074157.GX12721@pengutronix.de>
References: <CAGm1_ksdokuRQ8kAfX+EsjYAzZj3UXn5XH2duS2TMX_NjaYnUg@mail.gmail.com>
 <54F8A933.1040309@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41580 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773AbbCFHl7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 6 Mar 2015 02:41:59 -0500
Content-Disposition: inline
In-Reply-To: <54F8A933.1040309@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Thu, Mar 05, 2015 at 08:06:27PM +0100, Oliver Hartkopp wrote:
> You can now find the Linux-CAN repositories at:
> 
> 	https://github.com/linux-can/

This is a good move.
 
> 	Firmware for supported CAN adapters
> 	https://github.com/linux-can/can-firmware/

The softing firmware in this package is lacking a license. Is it even
allowed to distribute it? If yes, the linux-firmware repository would be
a good place for it.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
