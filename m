From: Julian Calaby <julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 2/2] can: Allwinner A10/A20 CAN
 Controller support - controller code
Date: Mon, 14 Sep 2015 09:51:57 +1000
Message-ID: <CAGRGNgU-j2E40Q7PzTfEmhCi8gaRawWvaE6f--+B5V45UXR6nQ@mail.gmail.com>
References: <1442144632-4541-1-git-send-email-info@gerhard-bertelsmann.de>
 <1442144632-4541-3-git-send-email-info@gerhard-bertelsmann.de>
 <20150913124501.GS9885@lukather> <f8eea0f544eb6367142bbc1c2ab35964@mail.rdts.de>
Reply-To: julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDQIP76OUQLBBMMY3CXQKGQE77WW7GA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <f8eea0f544eb6367142bbc1c2ab35964-6XUBc1GShDsOIzVOb1FTxg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: info-La43T0Mi4bH5xCKuJOYmCvaTkwRoYoCU@public.gmane.org
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-can-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-can.vger.kernel.org

Hi Gerd,

On Sun, Sep 13, 2015 at 11:42 PM, Gerhard Bertelsmann
<info-La43T0Mi4bH5xCKuJOYmCvaTkwRoYoCU@public.gmane.org> wrote:
> General remark:
>
> Somebody asked me to add linux-sunxi dev list. Seems to be not a good idea
> before the driver was ready. Seems to be hard to fulfill the differentness.
>
> I will remove linux-sunxi for the next patch set. I will try to get
> linux-can
> people satisfied and then I'm done with it. I'm doing this in my spare time,
> but it seems to get an endless story. I'm not offended in any kind, my spare
> time is just limited.
>
> The driver is working so far and the patches also apply to 4.3.

You misunderstand, the sunxi people (who's mailing list I follow) are
the experts on the hardware platform you're writing this driver for.
If you don't include them and don't solicit their advice, your driver
may end up doing things which aren't correct for the platform (e.g. it
might work for you but break something else) and this will seriously
impact it's chances of getting included in the kernel at some point.
You also can't get the driver "ready" before asking for their comments
as what might have been small tweaks to get stuff "right" at the start
may end up being big changes at the end. (Stitch in time and all
that.)

Including the linux-sunxi mailing list also means that there's more
visibility to your efforts, more people looking over the code,
(potentially) more testers and less duplicated effort as all sunxi
related stuff is referred to in one place. (Thankfully in your case
nobody else was working on a CAN bus driver, but there have been cases
of multiple people independently working on drivers for the same
hardware and only discovering this late in the development process.)

As an occasional Linux developer, I don't see Maxime's questions as
being "hard": he makes some good points about your clock handling -
which is important for power management - and asks a couple of other
good questions. Those questions and issues are stuff that has to be
answered to get this driver into the kernel. In particular, the
question about the interrupt handling was an "explain why you're doing
this" question not a "this is broken and needs changing" question. And
as for the changing things only to change them back issue, this is
likely to be the last time that happens.

My reading of his comments indicates that you should check over what
and how stuff is handled over the "lifetime" of the device /
connection / socket. I.e. are all your resources "freed" after they're
no-longer needed? Are you switching off everything you turn on? etc.
This is the sort of analysis that I'm sure you've done already, but it
never hurts to do it again. I find issues like this all the time in
the development I do.

Finally, I strongly urge you to stick with the driver at least until
it's merged. The fact that Maxime only had a few comments indicates
that you've written a good driver which is a few tweaks away from
being merged - which is something you should be very proud of. I see
drivers being submitted that have much more serious issues and that
prompt much more debate than yours has. (For instance I've seen some
changes on another mailing list go through 6 full rewrites without
everyone being happy.)

Excellent work, keep it up.

Thanks,

-- 
Julian Calaby

Email: julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Profile: http://www.google.com/profiles/julian.calaby/
