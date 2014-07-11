From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: skbuff panic
Date: Fri, 11 Jul 2014 07:58:26 -0700
Message-ID: <CANGgnMYJ+eLGeMiLuTXQONpC6B1GSW6gPkk-u=ATcVNijLN5rA@mail.gmail.com>
References: <CANGgnMbu511sgePeix3hjitO+xEazCw1j7Ya_81SA1GsN6W+QA@mail.gmail.com>
 <53B7D63B.2060108@hartkopp.net> <CANGgnMYu7DOWr5Zy934GkrGW=+FcaVKRCgZejMcugx0DCyN83A@mail.gmail.com>
 <53B8504C.4070808@hartkopp.net> <CANGgnMZHumyQNz3Z2ULYJWeNaqnbtenbSaL7gm=OwDjPnfdGcw@mail.gmail.com>
 <53B93D45.5090505@hartkopp.net> <53B97598.50400@hartkopp.net>
 <53B9A5AD.8050403@pengutronix.de> <CANGgnMZdKsB6WhorMMnLTNTB=rSq78ZEbMkH69x=FxGE_BXyCw@mail.gmail.com>
 <CANGgnMbb+2OodO7a4L5CSgn2wKTjwbu1tnZ8wAa=5RME_S_Nyw@mail.gmail.com>
 <CANGgnMY4+PTnkd9CBUSS4EM6ZjP9r1wp8JYDJ4fYv+P1Qg6-vg@mail.gmail.com> <53BFE637.2030905@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:64873 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbaGKO6r (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 Jul 2014 10:58:47 -0400
Received: by mail-ie0-f169.google.com with SMTP id tp5so982917ieb.28
        for <linux-can@vger.kernel.org>; Fri, 11 Jul 2014 07:58:47 -0700 (PDT)
In-Reply-To: <53BFE637.2030905@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On Fri, Jul 11, 2014 at 6:27 AM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> Thanks for testing, Austin!
>
> I'll cook a patch for stable to add these settings.
> Even if we do not know why someone requests obviously all netdev skbs and
> treats them to be Ethernet/IP packets we should fix it in our code.
>
> If we fix it somewhere else it will last one year until some of the
> is-there-anything-else-than-ethernet-networking guys will break it again.
> ;-)

Is it worth debugging why as well?  Defense in layers?

Austin
