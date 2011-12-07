From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next v6 4/4] powerpc: tqm8548/tqm8xx: add and
 update CAN device nodes
Date: Wed, 07 Dec 2011 02:39:16 -0500 (EST)
Message-ID: <20111207.023916.980093028693181777.davem@davemloft.net>
References: <1322732481-2255-1-git-send-email-wg@grandegger.com>
	<1322732481-2255-5-git-send-email-wg@grandegger.com>
	<1323243268.660.71.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:38756 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753196Ab1LGHld (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Dec 2011 02:41:33 -0500
In-Reply-To: <1323243268.660.71.camel@pasglop>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: benh@kernel.crashing.org
Cc: wg@grandegger.com, netdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-can@vger.kernel.org, linuxppc-dev@ozlabs.org, socketcan-users@lists.berlios.de

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 07 Dec 2011 18:34:28 +1100

> Let me know if I should just remove them from powerpc patchwork.

These are DT entries for CAN devices for which drivers only exist in
the net-next tree, I already included this patch into the net-next
tree so you do not have to.
