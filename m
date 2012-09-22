From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [can:master 118/170] ERROR: "sysctl_llc_station_ack_timeout"
 [net/llc/llc2.ko] undefined!
Date: Sat, 22 Sep 2012 08:24:26 +0800
Message-ID: <20120922002426.GB5959@localhost>
References: <20120921112740.GA15164@localhost>
 <20120921.122418.1595502576924307596.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:2335 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757497Ab2IVAYb (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 21 Sep 2012 20:24:31 -0400
Content-Disposition: inline
In-Reply-To: <20120921.122418.1595502576924307596.davem@davemloft.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: ben@decadent.org.uk, kernel-janitors@vger.kernel.org, linux-can@vger.kernel.org

On Fri, Sep 21, 2012 at 12:24:18PM -0400, David Miller wrote:
> From: Fengguang Wu <fengguang.wu@intel.com>
> Date: Fri, 21 Sep 2012 19:27:40 +0800
> 
> > Hi Ben,
> > 
> > FYI, kernel build failed on
> > 
> > tree:   git://gitorious.org/linux-can/linux-can-next master
> > head:   029d8ada9150a1177f09148284b5cd27a30d4db7
> > commit: 025e36332573177ecd7c12730e18a4390f994f05 [118/170] llc2: Remove dead code for state machine
> > config: x86_64-allmodconfig
> > 
> > All related error/warning messages:
> > 
> > ERROR: "sysctl_llc_station_ack_timeout" [net/llc/llc2.ko] undefined!
> 
> The very next commit, written by me, after Ben's fixes this build
> error.

OK..

> It wasn't added by the CAN tree so bugging them is very inappropriate,
> the change came from the net-next tree.

Yup, I got an idea to fix it! :)

The root cause is the CAN tree get tested before the net-next tree
that it bases on, and I'm CCing the CAN list because it "seems" to be
testing the CAN tree.

The fix is to

a) Test the trees as soon as they are published, which will naturally
   result in upstream trees being tested first. Currently some of the
   build threads are overloaded, which leads to out-of-order testing
   and some missed tests.

b) Use the pair (committer, git tree) to find the related mailing list.
   The git tree alone is not reliable information, because one tree
   can pull from the others, in which case the committer is actually
   more reliable than the git url.

Thanks,
Fengguang
