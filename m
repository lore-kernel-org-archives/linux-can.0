From: Fengguang Wu <fengguang.wu@intel.com>
Subject: [can:master 118/170] ERROR: "sysctl_llc_station_ack_timeout"
 [net/llc/llc2.ko] undefined!
Date: Fri, 21 Sep 2012 19:27:40 +0800
Message-ID: <20120921112740.GA15164@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:35203 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440Ab2IUL1r (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 21 Sep 2012 07:27:47 -0400
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org

Hi Ben,

FYI, kernel build failed on

tree:   git://gitorious.org/linux-can/linux-can-next master
head:   029d8ada9150a1177f09148284b5cd27a30d4db7
commit: 025e36332573177ecd7c12730e18a4390f994f05 [118/170] llc2: Remove dead code for state machine
config: x86_64-allmodconfig

All related error/warning messages:

ERROR: "sysctl_llc_station_ack_timeout" [net/llc/llc2.ko] undefined!

---
0-DAY kernel build testing backend         Open Source Technology Centre
Fengguang Wu, Yuanhan Liu                              Intel Corporation
