From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: Bug#568303: can-utils Debian package
Date: Mon, 24 Feb 2014 10:18:44 +0100
Message-ID: <530B0E74.6010103@physik.fu-berlin.de>
References: <CAGm1_ktzQgs92L0RxoVYGVhbb88hZi9dQACF8=pazYHouXh-1w@mail.gmail.com> <4947876.WXEsvsyjiy@shelbyville.comnets.uni-bremen.de> <20140115200207.512cf5e8@snail> <20140123183951.GA20892@perseus.defre.xn--kleine-knig-yfb.de> <20140220095131.GG6988@pengutronix.de> <1444f73d090.27d4.77cf013f3ec6cb326b88fe89a2c6c054@cs.msu.su> <20140224104448.66d46355@snail> <20140224070825.GA31051@physik.fu-berlin.de> <20140224082529.GC27579@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:47724 "EHLO
	outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751175AbaBXJOv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 24 Feb 2014 04:14:51 -0500
In-Reply-To: <20140224082529.GC27579@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Alexander GQ Gerasiov <gq@cs.msu.su>, 568303@bugs.debian.org, Markus Becker <mab@comnets.uni-bremen.de>, Yegor Yefremov <yegorslists@googlemail.com>, linux-can@vger.kernel.org, debian-devel@lists.debian.org

On 02/24/2014 09:25 AM, Uwe Kleine-K=F6nig wrote:
>> You should also have asked yourself why Uwe had added those override=
s
>> and not just silently commented them out. If someone adds extra
>> overrides, he usually has very good reasons. You should have asked U=
we
>> about that.
> This is wrong, the overrides are not from me. d/rules seems to be
> Alexander's (well, or Joey Hess' and Craig Small's) work.

Ok, then I misunderstood your concerns. I apologize to Alexander
regarding this and take everything back ;).

>>> Package is in new queue right now and will be soon available in
>>> unstable repository.
>>
>> It's actually been set to not be reviewed before February 28th to be
>> able to discuss this matter first.
> I think the best will be when Alexander and I discuss the issue in
> private. I don't see a need to pull that conflict into public.

I agree. Still, you should post the results here.

Cheers,

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
