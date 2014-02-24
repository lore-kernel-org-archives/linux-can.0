From: Alexander GQ Gerasiov <gq@cs.msu.su>
Subject: Re: Bug#568303: can-utils Debian package
Date: Mon, 24 Feb 2014 12:59:33 +0400
Message-ID: <20140224125933.44d8ab7b@snail>
References: <CAGm1_ktzQgs92L0RxoVYGVhbb88hZi9dQACF8=pazYHouXh-1w@mail.gmail.com>
	<4947876.WXEsvsyjiy@shelbyville.comnets.uni-bremen.de>
	<20140115200207.512cf5e8@snail>
	<20140123183951.GA20892@perseus.defre.xn--kleine-knig-yfb.de>
	<20140220095131.GG6988@pengutronix.de>
	<1444f73d090.27d4.77cf013f3ec6cb326b88fe89a2c6c054@cs.msu.su>
	<20140224104448.66d46355@snail>
	<20140224070825.GA31051@physik.fu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from eol.lvk.cs.msu.su ([158.250.17.73]:34625 "EHLO
	eol.lvk.cs.msu.su" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568AbaBXI7g (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 24 Feb 2014 03:59:36 -0500
In-Reply-To: <20140224070825.GA31051@physik.fu-berlin.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: 568303@bugs.debian.org, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>, Markus Becker <mab@comnets.uni-bremen.de>, Yegor Yefremov <yegorslists@googlemail.com>, linux-can@vger.kernel.org, debian-devel@lists.debian.org

Mon, 24 Feb 2014 08:08:25 +0100
John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:

> Hello Alexander!
> 
> On Mon, Feb 24, 2014 at 10:44:48AM +0400, Alexander GQ Gerasiov wrote:
> > Thu, 20 Feb 2014 17:30:05 +0400
> > Alexander Gerasiov <gq@cs.msu.su> wrote:
> > 
> > > Sorry guys. I'm totally busy with other tasks last month :-(. As I
> > > remember your package is quite ready for upload, so I'll do it
> > > tomorrow (without my changes, just add myself as an uploader if
> > > you don't mind). Ok?
> > 
> > As Uwe is worried about correctness I'd like to mention, that I did
> > not use his package as the base for last upload, but incorporated
> > some of lines he wrote into my package.
> 
> That doesn't sound plausible to me given the fact that you imported
> his debian/rules file and commented out his overrride_dh_* statements
> [1].
Unfortunately I missed to fixup pair of changes when build package,
that's why second revision was uploaded right after first.
You are talking about revision -1 which really had some issues.
Please comment on the last version available.

> 
> If you had incorporated some of his changes, you'd just have use the
> default rules file from the template.
> 
> You should also have asked yourself why Uwe had added those overrides
> and not just silently commented them out. If someone adds extra
> overrides, he usually has very good reasons. You should have asked Uwe
> about that.
I think you did not get clean with this or that's Uwe who mislead you.

Those commented out overrides were left in rules file from my previous
experiments, and not needed anymore. And they have nothing with Uwe's
package, I believe.

I can count all changes I took from his work:
Arch: linux-any (totally forget that SocketCAN is Linux specific)
Several strings in description field.

And that's all. =\

> 
> The package currently also includes the debian/README.source template
> and git-related files (.gitignore, gbp.conf).
Template README.source was also removed in -2 revision.
As for .gitignore and gbp.conf, this package is maintained under git
and git-buildpackage and I see no reason, why thees files should not be
included in debian/
I think some gbp related info should goes to README.source. One day
I'll write it.

> 
> As someone who is sponsoring very often and has some experience with
> reviewing packages now, can-utils wouldn't have passed my quality
> requirements in its current state.
I could not agree with you if we speak about revision -2.

> 
> I can therefore fully understand that Uwe is upset and I think it
> would be best if you asked the FTP Masters to have the package set to
> REJECT in NEW and get into touch with Uwe to coordinate improving the
> package.
[spend 15 minutes, explaining situation, but as Uwe prefer to continue
privately, I removed it]

Conclusion:
Looks like Uwe decided that I modified his package, removed him from
Maintainer and broke all around. And he started offense instead of
discussion.

Ok, I disagree, but understand why did he react like this. I think it's
possible to discuss this privately.

> 
> > Package is in new queue right now and will be soon available in
> > unstable repository.
> 
> It's actually been set to not be reviewed before February 28th to be
> able to discuss this matter first.
Well, I remember time when packages were held in new for 2-3 months =)

-- 
Regards, Alexander
