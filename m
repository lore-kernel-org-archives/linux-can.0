From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 0/5] prepare for release + add more clocks to can-calc-bit-timing
Date: Mon, 26 Nov 2012 21:54:24 +0100
Message-ID: <50B3D700.7040606@hartkopp.net>
References: <1353962689-18669-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:58591 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756643Ab2KZUy2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Nov 2012 15:54:28 -0500
In-Reply-To: <1353962689-18669-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, ulrich.escher@myvdr.de

On 26.11.2012 21:44, Marc Kleine-Budde wrote:

> this patch series prepares configure.ac for a release (adjusting bug report
> address  + enabling silent rules in autoools). Then some more refclocks for
> flexcan and mscan are added and support for ti_hecc to can-calc-bit-timing.


Hello Marc,

that's fine to me.

I also pushed the slcanpty fix from Ulrich with an appropriate commit message.

Thanks,
Oliver
