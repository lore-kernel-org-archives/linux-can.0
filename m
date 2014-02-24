From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: Bug#568303: can-utils Debian package
Date: Mon, 24 Feb 2014 08:08:25 +0100
Message-ID: <20140224070825.GA31051@physik.fu-berlin.de>
References: <CAGm1_ktzQgs92L0RxoVYGVhbb88hZi9dQACF8=pazYHouXh-1w@mail.gmail.com>
 <4947876.WXEsvsyjiy@shelbyville.comnets.uni-bremen.de>
 <20140115200207.512cf5e8@snail>
 <20140123183951.GA20892@perseus.defre.xn--kleine-knig-yfb.de>
 <20140220095131.GG6988@pengutronix.de>
 <1444f73d090.27d4.77cf013f3ec6cb326b88fe89a2c6c054@cs.msu.su>
 <20140224104448.66d46355@snail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <bounce-debian-devel=debian-devel=m.gmane.org@lists.debian.org>
Content-Disposition: inline
In-Reply-To: <20140224104448.66d46355@snail>
Sender: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Resent-Message-ID: <S71BRPmiXZN.A.yZB.cAvCTB@bendel>
List-URL: <http://lists.debian.org/debian-devel/>
List-Post: <mailto:debian-devel@lists.debian.org>
List-Help: <mailto:debian-devel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-devel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-devel-request@lists.debian.org?subject=unsubscribe>
To: Alexander GQ Gerasiov <gq@cs.msu.su>
Cc: 568303@bugs.debian.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Markus Becker <mab@comnets.uni-bremen.de>, Yegor Yefremov <yegorslists@googlemail.com>, linux-can@vger.kernel.org, debian-devel@lists.debian.org
List-Id: linux-can.vger.kernel.org

Hello Alexander!

On Mon, Feb 24, 2014 at 10:44:48AM +0400, Alexander GQ Gerasiov wrote:
> Thu, 20 Feb 2014 17:30:05 +0400
> Alexander Gerasiov <gq@cs.msu.su> wrote:
> 
> > Sorry guys. I'm totally busy with other tasks last month :-(. As I
> > remember your package is quite ready for upload, so I'll do it
> > tomorrow (without my changes, just add myself as an uploader if you
> > don't mind). Ok?
> 
> As Uwe is worried about correctness I'd like to mention, that I did not
> use his package as the base for last upload, but incorporated some of
> lines he wrote into my package.

That doesn't sound plausible to me given the fact that you imported
his debian/rules file and commented out his overrride_dh_* statements
[1].

If you had incorporated some of his changes, you'd just have use the
default rules file from the template.

You should also have asked yourself why Uwe had added those overrides
and not just silently commented them out. If someone adds extra
overrides, he usually has very good reasons. You should have asked Uwe
about that.

The package currently also includes the debian/README.source template
and git-related files (.gitignore, gbp.conf).

As someone who is sponsoring very often and has some experience with
reviewing packages now, can-utils wouldn't have passed my quality
requirements in its current state.

I can therefore fully understand that Uwe is upset and I think it
would be best if you asked the FTP Masters to have the package set to
REJECT in NEW and get into touch with Uwe to coordinate improving the
package.

> Package is in new queue right now and will be soon available in
> unstable repository.

It's actually been set to not be reviewed before February 28th to be
able to discuss this matter first.

Cheers,

Adrian

> [1] http://anonscm.debian.org/gitweb/?p=collab-maint/can-utils.git;a=blob;f=debian/rules;h=cfd19c845d1fa085679931a9817e4cfd8b23c481;hb=9f50da4df75f5ea00620f94f01cf1205ef16fdc5

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
