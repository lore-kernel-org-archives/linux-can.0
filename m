From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: j1939 ACL
Date: Mon, 22 Jan 2018 19:26:41 +0100
Message-ID: <20180122182641.GB1943@airbook.vandijck-laurijssen.be>
References: <20180118094040.tkfgprblq5zxrzin@pengutronix.de>
 <53295b55-bf98-4a59-08d2-ce19516e9084@smile.fr>
 <dee45c8c-6816-aa18-4fde-fd5f2239c62d@pengutronix.de>
 <20180120212809.GB3515@airbook.vandijck-laurijssen.be>
 <239f9ce7-9a1d-1907-e714-c6a9cade80fe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b01.edpnet.be ([212.71.1.221]:36027 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751102AbeAVS0t (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Jan 2018 13:26:49 -0500
Content-Disposition: inline
In-Reply-To: <239f9ce7-9a1d-1907-e714-c6a9cade80fe@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: =?utf-8?B?UsOpbXk=?= Dziemiaszko <remy.dziemiaszko@smile.fr>, Oleksij Rempel <ore@pengutronix.de>, linux-can@vger.kernel.org

> On 01/20/2018 10:28 PM, Kurt Van Dijck wrote:
> >> after playing with jacd i have a bit more questions:
> >> - do any one already using kernel j1939? any suggestions or request for
> >> changes?
> > 
> > A linux 3.10 version runs in production. Since then, a few changes were
> > requested and implemented.
> > Recently, the stack had some serious retesting, you will find the
> > latest state in my github (only a few minor commits from Marc's
> > version).
> 
> Oleksij and Basti are now working on the j1939 kernel and userspace. I'd
> like to have top of development on the linux-can-next/j1939 branch.
> Which branch in your linux repo is the newest one?

can-next-j1939

It builds upon your can-next/j1939, so I invested into that.

> 
> Marc
> 
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 



