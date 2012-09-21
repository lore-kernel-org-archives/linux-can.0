From: David Miller <davem@davemloft.net>
Subject: Re: [can:master 118/170] ERROR: "sysctl_llc_station_ack_timeout"
 [net/llc/llc2.ko] undefined!
Date: Fri, 21 Sep 2012 12:24:18 -0400 (EDT)
Message-ID: <20120921.122418.1595502576924307596.davem@davemloft.net>
References: <20120921112740.GA15164@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:49647 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346Ab2IUQYU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 21 Sep 2012 12:24:20 -0400
In-Reply-To: <20120921112740.GA15164@localhost>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: fengguang.wu@intel.com
Cc: ben@decadent.org.uk, kernel-janitors@vger.kernel.org, linux-can@vger.kernel.org

From: Fengguang Wu <fengguang.wu@intel.com>
Date: Fri, 21 Sep 2012 19:27:40 +0800

> Hi Ben,
> 
> FYI, kernel build failed on
> 
> tree:   git://gitorious.org/linux-can/linux-can-next master
> head:   029d8ada9150a1177f09148284b5cd27a30d4db7
> commit: 025e36332573177ecd7c12730e18a4390f994f05 [118/170] llc2: Remove dead code for state machine
> config: x86_64-allmodconfig
> 
> All related error/warning messages:
> 
> ERROR: "sysctl_llc_station_ack_timeout" [net/llc/llc2.ko] undefined!

The very next commit, written by me, after Ben's fixes this build
error.

It wasn't added by the CAN tree so bugging them is very inappropriate,
the change came from the net-next tree.
