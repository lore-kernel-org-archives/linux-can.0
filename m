From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: Informations About CAN API of the Linux Kernel
Date: Fri, 8 Mar 2013 13:51:23 +0100
Message-ID: <20130308125123.GA28383@pengutronix.de>
References: <2B7D120CFC15DC438D721B998AD9D9E9097105AB@SEGOTNC5180-N2.vcn.ds.volvo.net>
 <513763CC.1070507@pengutronix.de>
 <20130307124012.GC603@vandijck-laurijssen.be>
 <5139A78D.9060005@pengutronix.de>
 <20130308100548.GA496@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54783 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753461Ab3CHMv0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 8 Mar 2013 07:51:26 -0500
Content-Disposition: inline
In-Reply-To: <20130308100548.GA496@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Sako Youssouf <youssouf.sako@renault-trucks.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Kurt,

On Fri, Mar 08, 2013 at 11:05:48AM +0100, Kurt Van Dijck wrote:
> Could I just mark j1939 as "EXPERIMENTAL" in Kconfig.
> I think that is what I've seen most for 'unstable concepts'.

EXPERIMENTAL is considered to be deprecated and might be removed from
the kernel, so I wouldn't go down that road. Staging sounds right.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
