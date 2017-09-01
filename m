From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 19/25] can/bcm: Replace hrtimer_tasklet with softirq
 based hrtimer
Date: Fri, 1 Sep 2017 17:56:23 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1709011755170.1857@nanos>
References: <20170831105725.809317030@linutronix.de> <20170831105827.099510718@linutronix.de> <bd72d6f1-ee96-821c-fbf3-766354728a40@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:37830 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751945AbdIAP4k (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 1 Sep 2017 11:56:40 -0400
In-Reply-To: <bd72d6f1-ee96-821c-fbf3-766354728a40@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Christoph Hellwig <hch@lst.org>, keescook@chromium.org, John Stultz <john.stultz@linaro.org>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On Fri, 1 Sep 2017, Oliver Hartkopp wrote:

> Hi Anna-Maria & Thomas,
> 
> thanks for the effort!
> 
> I'm really happy that the hrtimer becomes softirq capable as it basically
> reverts this ugly commit from January 2009:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=6e5c172cf7ca1ab878cc6a6a4c1d52fef60f3ee0
> 
> From the first look the changes seem to be correct.
> 
> I'll pick the entire patchset for a test and give a Acked|Tested-by then.
> 
> Best regards,
> Oliver
> 
> ps.
> 
> On 08/31/2017 02:23 PM, Anna-Maria Gleixner wrote:
> 
> (nothing here!)
> 
> Please send patches inline and not as attachments. Tnx!

PS:

Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=canbcm_Replace_hrtimer_tasklet_with_softirq_based_hrtimer.patch

Please get a proper mail client, which actually parses the
Content-Disposition tag correcly

Thanks,

	tglx
