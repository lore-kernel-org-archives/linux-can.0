From: Torsten Lang <torsten.lang@uweschneider.de>
Subject: Re: can: flexcan: implement workaround for FIFO overruns (based on
 code by David Jander)
Date: Thu, 09 Jul 2015 11:26:22 +0200
Message-ID: <559E3E3E.7080603@uweschneider.de>
References: <559D35CA.2050402@uweschneider.de> <CAOpc7mGxD7PF97jA3qfcty5P14=JHd4KS7Ks0HUPF8foTavMLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from groat.dascon.de ([195.225.198.185]:52827 "EHLO groat.dascon.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986AbbGIJ1G (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 9 Jul 2015 05:27:06 -0400
In-Reply-To: <CAOpc7mGxD7PF97jA3qfcty5P14=JHd4KS7Ks0HUPF8foTavMLQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Holger Schurig <holgerschurig@gmail.com>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

Hi Holger,
regarding the formal things - I already reformatted my work according to the CodingStyle guidelines in the kernel documentation folder, but actually I didn't see a hint regarding the check script, otherwise I would've let run it over my code.

As the kernel has heavily grown since the last time I wrote drivers (which was for the Atari - at that time we were around kernel 0.6..0.8 for the M68K architecture while the mainline kernel just hitted 1.0 AFAIR) it's quite easy to miss something.

My patch is based in commit 0f57d86787d8b1076ea8f9cbdddda2a46d534a27 (tag v4.1-rc8) but wasn't created with git as I had a bit trouble with my tools...

Regards,
Torsten

Am 09.07.2015 um 08:33 schrieb Holger Schurig:
> Wow, I'm very interested into your work because I too had RxFIFO overruns.
>
> So, have here some first "review" remarks:
>
> * But for a review it's much better to send patches in-line (i.E. not
> as an attachment)
> * And because your "Signed-off:" is missing, we don't know what the
> release status is. As is, the patch cannot added ever to the kernel!
> * try to fix the things that scripts/checkpatch.pl
> patches/flexcan_kernel_4.1-rc8.patch say, e.g. it found
> ** CHECK: Alignment should match open parenthesis
> ** CHECK: Blank lines aren't necessary before a close brace '}'
> ** CHECK: if this code is redundant consider removing it
> ** CHECK: Logical continuations should be on the previous line
> ** CHECK: spaces preferred around that '&' (ctx:ExO)
> ** CHECK: spaces preferred around that '+' (ctx:VxV)
> ** WARNING: line over 80 characters
> ** WARNING: Missing a blank line after declarations
> ** WARNING: networking block comments don't use an empty /* line, use
> /* Comment...
> ** WARNING: please, no space before tabs
> ** WARNING: please, no spaces at the start of a line
> ** ERROR: code indent should use tabs where possible
> ** ERROR: Missing Signed-off-by: line(s)
> ** ERROR: space prohibited after that open parenthesis '('
> ** ERROR: space prohibited before that close parenthesis ')'
> ** ERROR: spaces required around that '&&' (ctx:ExO)
> ** ERROR: spaces required around that '||' (ctx:ExV)
> ** ERROR: spaces required around that '&&' (ctx:ExV)
> ** ERROR: that open brace { should be on the previous line
> ** ERROR: trailing whitespace
> * All of this is written in Documentation/SubmittingPatches and
> Documentation/CodingStyle
>
> Other remarks:
> * after your patch, FLEXCAN_CTRL2_EACEN is defined twice.
> * You change crl2 to ctrl2, but in Linux git this is already done
> (commit 6f75fce1ea81b1d91f6f1a8e3dd00b0ce8e83982). So your patch
> doesn't apply to Linux git. I have such problem also from time to
> time, because I tend to run stable Linux kernel (and not linux-git) on
> my customers hardware. But then I look at what happened to this driver
> in linux-git and backport the patches into my local
> quilt-stack-of-patches. This essentially brings this one driver to
> linux-git level, and any patch I do would also apply to linux-git.
> * I like your descriptive comments!  I just don't know why you
> describe the FIFO-Modes after cantxfg and before _reserved4?
> * you add a "struct net_device *dev". I doubt that this is really
> needed, the old flexcan could do without ...
> * please remove debugging code, e.g. "#if 0"  sections. I personally
> do this by having them in a second quilt patch, e.g.
> "flexcan-debug.patch". So I can roll them in fast when I need them,
> but keep the to-be-submitted patch clean.
>
>
>
> BTW, you can remove a good amount of latency in an i.MX6 kernel if you
> remove CONFIG_MMC_CLKGATE. That introduces a latency of 1 ms every
> second ... urgh.

