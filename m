From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] c_can: Add support for eg20t (pch_can)
Date: Mon, 7 Apr 2014 14:34:17 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1404071433000.14882@ionos.tec.linutronix.de>
References: <1396534451-9654-1-git-send-email-alexander.stein@systec-electronic.com> <alpine.DEB.2.02.1404071405460.14882@ionos.tec.linutronix.de> <534294F9.8030102@pengutronix.de> <2082533.2A1719KrNC@ws-stein>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:51015 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755040AbaDGMeH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Apr 2014 08:34:07 -0400
In-Reply-To: <2082533.2A1719KrNC@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

On Mon, 7 Apr 2014, Alexander Stein wrote:
> On Monday 07 April 2014 14:07:21, Marc Kleine-Budde wrote:
> > On 04/07/2014 02:06 PM, Thomas Gleixner wrote:
> > > On Mon, 7 Apr 2014, Alexander Stein wrote:
> > > 
> > >> Hello Wolfgang,
> > >>
> > >> On Thursday 03 April 2014 20:41:24, Wolfgang Grandegger wrote:
> > >>> On 04/03/2014 04:14 PM, Alexander Stein wrote:
> > >>>> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> > >>>
> > >>> Acked-by: Wolfgang Grandegger <wg@grandegger.com>
> > >>>
> > >>> In my patch stack I have also th patch below. Could you please give it
> > >>> I try before I re-submit it. Thanks.
> > >>
> > >> With this patch the driver still works, at least MSI is working. The other problems still exist.
> > >>
> > > 
> > > Which problems do still exist?
> > 
> > IIRC:
> > Either potentially reordered frames or dropped frames.
> 
> I'm currently trying to locate problem causes. Using your new set of patches on the tag linux-can-fixes-for-3.15-20140401 I lot of lost messages.
> Using bisect it seems that c0a9f4d39 "can: c_can: Reduce register access" introduced this problem on my hardware. Before that I only see switched messages occasionally.
> 

Does the last patch which disables the RX buffer split still have that
issue?

Thanks,

	tglx
