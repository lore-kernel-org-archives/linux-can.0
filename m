From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 04/13] ARM: dts: dra7: Add syscon regmap for CORE CONTROL
 area
Date: Mon, 8 Sep 2014 10:47:03 -0700
Message-ID: <20140908174702.GJ3238@atomide.com>
References: <1410185442-907-1-git-send-email-rogerq@ti.com>
 <1410185442-907-5-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62973 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbaIHRrQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 8 Sep 2014 13:47:16 -0400
Content-Disposition: inline
In-Reply-To: <1410185442-907-5-git-send-email-rogerq@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Roger Quadros <rogerq@ti.com>
Cc: wg@grandegger.com, mkl@pengutronix.de, tglx@linutronix.de, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

* Roger Quadros <rogerq@ti.com> [140908 07:11]:
> Display and DCAN drivers use syscon regmap to access some registers
> in the CORE control area. Add the syscon regmap node for this
> area.

Please repost the .dts changes in a separate series to avoid
conflicts.

Thanks,

Tony
