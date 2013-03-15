From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: iMX28 and CAN Error frames
Date: Fri, 15 Mar 2013 22:23:02 +0100
Message-ID: <20130315212302.GU28383@pengutronix.de>
References: <1EF5AE0C0C5487498E14A50D915B97933B0A4DB586@GBLONZ-PMSGEM05.emrsn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42735 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932531Ab3COVXD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 15 Mar 2013 17:23:03 -0400
Content-Disposition: inline
In-Reply-To: <1EF5AE0C0C5487498E14A50D915B97933B0A4DB586@GBLONZ-PMSGEM05.emrsn.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Tobias.Grueninger@Emerson.com
Cc: linux-can@vger.kernel.org

On Fri, Mar 15, 2013 at 04:16:08PM +0000, Tobias.Grueninger@Emerson.com wrote:
> I have trouble in receiving error frames on my freescale iMX28 board.
> Linux mx28 2.6.35.3-g880e772 #35 Mon Jul 30 15:04:31 CEST 2012 armv5tejl GNU/Linux

That sounds like a Freescale kernel, not mainline. The community mailing
lists usually only support the mainline kernel.

Please try your test again on 3.8.x. It should support most of i.MX28
nicely.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
