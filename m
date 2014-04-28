From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: am335x: d_can: rx issue
Date: Mon, 28 Apr 2014 16:37:55 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1404281510170.6261@ionos.tec.linutronix.de>
References: <CAGm1_ktbB6SOGd5PygOrh4FOZU1fofAK4omAur-VHeo1Tw9tJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38733 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755761AbaD1Ohm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 28 Apr 2014 10:37:42 -0400
In-Reply-To: <CAGm1_ktbB6SOGd5PygOrh4FOZU1fofAK4omAur-VHeo1Tw9tJQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>

On Mon, 28 Apr 2014, Yegor Yefremov wrote:
> I'm testing 3.15.0-rc3-00006-gd497c20-dirty with latest commit:
> 
> Merge tag 'linux-can-fixes-for-3.15-20140401' of
> git://gitorious.org/linux-can/linux-can
> 
>     linux-can-fixes-for-3.15-20140401
> 
>     Marc Kleine-Budde says:
> 
>     ====================
>     this is a pull request of 16 patches for the 3.15 release cycle.
> 
>     Bjorn Van Tilt contributes a patch which fixes a memory leak in usb_8dev's
>     usb_8dev_start_xmit()s error path. A patch by Robert Schwebel
> fixes a typo in
>     the can documentation. The remaining patches all target the c_can
> driver. Two
>     of them are by me; they add a missing netif_napi_del() and return value
>     checking. Thomas Gleixner contributes 12 patches, which address several
>     shortcomings in the driver like hardware initialisation,
> concurrency, message
>     ordering and poor performance.
>     ====================
> 
> TX is working, but rx not. Am I missing any patches, that fix this issue?

I bet, TX is not working either. You probably fall over the issue with
the startup logic.

Does the following patch fix your issue?

    http://patchwork.ozlabs.org/patch/342518/

Thanks,

	tglx
