From: Federico Vaga <federico.vaga@gmail.com>
Subject: Re: [PATCH] can: c_can_pci: fix compilation on non HAVE_CLK archs
Date: Thu, 21 Jun 2012 20:11:32 +0200
Message-ID: <3448621.2MXBam7O19@harkonnen>
References: <1340187910-3437-1-git-send-email-mkl@pengutronix.de> <1549020.T54Yk82Gkk@harkonnen> <4FE35EE2.2010601@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:51422 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359Ab2FUSIB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 21 Jun 2012 14:08:01 -0400
Received: by bkcji2 with SMTP id ji2so856674bkc.19
        for <linux-can@vger.kernel.org>; Thu, 21 Jun 2012 11:08:00 -0700 (PDT)
In-Reply-To: <4FE35EE2.2010601@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

> >> I've already sent the patch to David. However please test it.
> 
> He already had applied it, however testing is still a good idea.

Sure

> > My development board don't boot. I'll test the patch when I can boot
> > my board or use a different one (hopefully soon).
> 
> Is the boot problems related to the patch?

No, it is a different problem. I explained why I didn't tested the patch 
yet.

-- 
Federico Vaga
