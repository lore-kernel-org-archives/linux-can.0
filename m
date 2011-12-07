From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC PATCH 00/14] consolidate and unify state change and bus-off
 handling
Date: Wed, 07 Dec 2011 21:30:57 +0100
Message-ID: <4EDFCD01.3010900@grandegger.com>
References: <1323269728-17491-1-git-send-email-wg@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:38853 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756579Ab1LGUa7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Dec 2011 15:30:59 -0500
In-Reply-To: <1323269728-17491-1-git-send-email-wg@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, socketcan-users@lists.berlios.de

On 12/07/2011 03:55 PM, Wolfgang Grandegger wrote:
> As already announced, here is my first patch series to consolidate the
> handling of CAN error state changes and bus-off.
> 
> I have also updated the Flexcan driver to behave like the other drivers,
> especially bus error reporting is now enabled via interrupt source. This
> works on my i.MX28 SOC. Marc, would be nice if you could test it on
> other SOCs as well (or somebody else). Hopefully we will not need to
> handle different hardware variants of the Flexcan controller.
> 
> I separated "consolidate error state handling" and "consolidate bus-off
> handling" to make the difference clear. The latter one is more delicate
> as it relys on the "back to error active" change to arrive to re-enable
> the TX queue.
> 
> I have also pushed these patches to my cloned Gitrorious repository
> "wg-linux-can-next". See:
> 
> https://gitorious.org/~wgrandegger/linux-can/wg-linux-can-next/commits/master

I have now recreated the repository and push the revised patches to the
"devel" branch:

https://gitorious.org/~wgrandegger/linux-can/wg-linux-can-next/commits/devel

Be aware that I will regularly rebase that branch.

Wolfgang,
