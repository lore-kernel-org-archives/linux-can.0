From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: Bug#568303: can-utils Debian package
Date: Mon, 24 Feb 2014 10:31:27 +0100
Message-ID: <530B116F.8040203@physik.fu-berlin.de>
References: <CAGm1_ktzQgs92L0RxoVYGVhbb88hZi9dQACF8=pazYHouXh-1w@mail.gmail.com>	<4947876.WXEsvsyjiy@shelbyville.comnets.uni-bremen.de>	<20140115200207.512cf5e8@snail>	<20140123183951.GA20892@perseus.defre.xn--kleine-knig-yfb.de>	<20140220095131.GG6988@pengutronix.de>	<1444f73d090.27d4.77cf013f3ec6cb326b88fe89a2c6c054@cs.msu.su>	<20140224104448.66d46355@snail>	<20140224070825.GA31051@physik.fu-berlin.de> <20140224125933.44d8ab7b@snail>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:47632 "EHLO
	outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751391AbaBXJ1b (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 24 Feb 2014 04:27:31 -0500
In-Reply-To: <20140224125933.44d8ab7b@snail>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander GQ Gerasiov <gq@cs.msu.su>
Cc: 568303@bugs.debian.org, =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Markus Becker <mab@comnets.uni-bremen.de>, Yegor Yefremov <yegorslists@googlemail.com>, linux-can@vger.kernel.org, debian-devel@lists.debian.org

Hi Alexander!

On 02/24/2014 09:59 AM, Alexander GQ Gerasiov wrote:
> Unfortunately I missed to fixup pair of changes when build package,
> that's why second revision was uploaded right after first.
> You are talking about revision -1 which really had some issues.
> Please comment on the last version available.

Sure, I can have a look at the second revision. But you could also
just asked the FTP team to set the package on REJECT to be able
to sort out the issues, then do a clean upload.

I usually try to keep a clean package history.

>> If you had incorporated some of his changes, you'd just have use the
>> default rules file from the template.
>>
>> You should also have asked yourself why Uwe had added those overrides
>> and not just silently commented them out. If someone adds extra
>> overrides, he usually has very good reasons. You should have asked Uwe
>> about that.
> I think you did not get clean with this or that's Uwe who mislead you.

Yep. I misunderstood Uwe. From his first comments it appeared to me
that exactly that had happened. So, I apologize to you Alexander
and take my statements back.

> Those commented out overrides were left in rules file from my previous
> experiments, and not needed anymore. And they have nothing with Uwe's
> package, I believe.

Alright, thanks for the explanation.

> I can count all changes I took from his work:
> Arch: linux-any (totally forget that SocketCAN is Linux specific)
> Several strings in description field.
> 
> And that's all. =\

Ok, it appeared to me that the situation was the complete opposite of
that, i.e. you took Uwe's work and put your name onto it.

Thanks for the clarification.

>>
>> The package currently also includes the debian/README.source template
>> and git-related files (.gitignore, gbp.conf).
> Template README.source was also removed in -2 revision.

Good!

> As for .gitignore and gbp.conf, this package is maintained under git
> and git-buildpackage and I see no reason, why thees files should not be
> included in debian/

True. I am using gbp as well and I completely forgot about that. The
files shouldn't pop up in the actual package.

> I think some gbp related info should goes to README.source. One day
> I'll write it.

Good idea!

>>
>> As someone who is sponsoring very often and has some experience with
>> reviewing packages now, can-utils wouldn't have passed my quality
>> requirements in its current state.
> I could not agree with you if we speak about revision -2.

Well, unless you have fixed the copyright issues that Uwe has
mentioned, you will get a REJECT with absolute certainty.

Did you fix the copyright information? Are the sources from
Volkswagen actually covered by a free license?

> Conclusion:
> Looks like Uwe decided that I modified his package, removed him from
> Maintainer and broke all around. And he started offense instead of
> discussion.

Well, you see what poor communication leads to. When you decide
to let him join as a comaintainer, you should communicate such
changes, especially before doing uploads.

>>> Package is in new queue right now and will be soon available in
>>> unstable repository.
>>
>> It's actually been set to not be reviewed before February 28th to be
>> able to discuss this matter first.
> Well, I remember time when packages were held in new for 2-3 months =)

They still are. Depends on the package, Look at zfs-utils which has
been in NEW for 6 months now. Obviously no one dares to touch it.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
