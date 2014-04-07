From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] genirq: Sanitize spurious interrupt detection of threaded
 irqs
Date: Mon, 7 Apr 2014 20:41:04 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1404072040320.14882@ionos.tec.linutronix.de>
References: <CANGgnMbszHzYe9pF2C6wag4MY_PfBG2qrMCC=rMmQnb-jyXXXw@mail.gmail.com> <52CAB05F.4010303@hartkopp.net> <CANGgnMZZu6tX0LyK4mQaYhixY9uhbQYee7XO5_HtNfT0REPghA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:53207 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755523AbaDGSkx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Apr 2014 14:40:53 -0400
In-Reply-To: <CANGgnMZZu6tX0LyK4mQaYhixY9uhbQYee7XO5_HtNfT0REPghA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Austin Schuh <austin@peloton-tech.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 7 Apr 2014, Austin Schuh wrote:

> Hi Thomas,
> 
> Did anything come of this patch?  Both Oliver and I have found that it
> fixes real problems.  I have multiple machines which have been running
> with the patch since December with no ill effects.

No, sorry. It fell through the cracks. Care to resend ?

Thanks,

	tglx
