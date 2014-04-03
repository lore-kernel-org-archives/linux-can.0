From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: Regarding  J1939 support on freescale imx6 BSP
Date: Thu, 3 Apr 2014 15:39:34 +0200
Message-ID: <20140403133934.GA449@vandijck-laurijssen.be>
References: <533BAD63.80202@tataelxsi.co.in>
 <20140402183759.GA4780@vandijck-laurijssen.be>
 <533CFFB7.3020300@tataelxsi.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay007.isp.belgacom.be ([195.238.6.173]:4406 "EHLO
	mailrelay007.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752052AbaDCNjl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Apr 2014 09:39:41 -0400
Content-Disposition: inline
In-Reply-To: <533CFFB7.3020300@tataelxsi.co.in>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ratheendran <ba.rsrajeshwaran@tataelxsi.co.in>
Cc: linux-can@vger.kernel.org

Hi Ratheendran,

On Thu, Apr 03, 2014 at 11:59:11AM +0530, Ratheendran wrote:
> Hi Kurt,
> 
> Thanks for your response,
> 
> I just confirmed from my team ,we want j1939  stack into our
> socketCAN layer.

Great.

> 
> is j1939  stack part of mainstream kernel?

no, you can find it at 
git@gitorious.org:linux-can/linux-can-j1939.git ?

> do I need to manually
> update my Linux BSP with the source code and resolve the conflicts.

If you already develop your kernel with git, then
you would do something as:
	$ git remote add j1939 git@gitorious.org:...
	$ git remote update j1939
	$ git merge j1939/j1939-v3.0b

The latter command merges the j1939-v3.0b branch into your git repository.
Several similar branches exists, which only differ in the mainline version
that they forked off.

> 
> Going further, I want to implement this as a patch with the yocto
> build, what is the best way to move ahead.

I'm not enough familiar with Yocto to answer that.

Kind regards,
Kurt
> 
> 
> Thanks,
> Ratheendran
> 
> On 4/3/2014 12:07 AM, Kurt Van Dijck wrote:
> >Hi Ratheendran,
> >
> >On Wed, Apr 02, 2014 at 11:55:39AM +0530, Ratheendran wrote:
> >>Hi All,
> >>
> >>I am new to Linux CAN module, want to know the how I can include
> >>this J1939 support in my free-scale imx6 BSP. do you have a
> >>ready-made patch.
> >>
> >>Please note, there is no requirement that the driver handle J1939
> >>protocol, it must simply allow J1939 to be fully functional.
> >Do you refer to my J1939 stack in the linux kernel tree that you can find at
> >git@gitorious.org:linux-can/linux-can-j1939.git ?
> >
> >Or is it something else that you seek?
> >That is not clear to me.
> >
> >Kind regards,
> >Kurt
> >.
> >
> 
