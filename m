From: Holger Schurig <holgerschurig@gmail.com>
Subject: Re: CAN question: how to trace frame errors?
Date: Fri, 12 Jun 2015 16:24:39 +0200
Message-ID: <CAOpc7mG5nD1daKSkGdqoR84=W_A11s+oQfzc_i4pUsHoVd42Tw@mail.gmail.com>
References: <CAOpc7mFv6ePXqkCZxRkCOC+BuY-PC14nAopZyFpEKHvj5gN_tw@mail.gmail.com>
	<557AA7BE.6040004@pengutronix.de>
	<CAOpc7mH-xD+eesJNjhpFwUSeMwGCdsRK8Q9AZSjmE2uw=cBgsw@mail.gmail.com>
	<557AD18D.8010807@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:36006 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbbFLOYl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 12 Jun 2015 10:24:41 -0400
Received: by wigg3 with SMTP id g3so19109210wig.1
        for <linux-can@vger.kernel.org>; Fri, 12 Jun 2015 07:24:40 -0700 (PDT)
In-Reply-To: <557AD18D.8010807@optusnet.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Tom Evans <tom_usenet@optusnet.com.au>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

Thanks for the thorought answer.

> so I rewrote the 3.4 FlexCAN driver to unload the FIFO into a ring buffer
> during interrupts and to have the NAPI routine unload tha

Can you publish it?  I might mangle it into a form so that I can sent
it as a patch to Linux HEAD (and use it by myself, LOL)

> Since the CPU is running at 800MHz, that's only 560,000 instructions

I'm running with 1 GHz, but that's still not stellar. I think I'll
look into the things you mentioned (e.g. I'm using the framebuffer
from staging, CONFIG_FRM_IMX, but I don't have the debug things
enabled you mentioned).
