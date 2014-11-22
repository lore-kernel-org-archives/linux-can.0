From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: [PATCH v2 1/4] can: dev: Consolidate and unify state change
 handling.
Date: Sat, 22 Nov 2014 18:15:23 +0000
Message-ID: <20141122181523.GA15366@shannon>
References: <5425AF94.5000206@marel.com> <5470C38D.9070209@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db3on0092.outbound.protection.outlook.com ([157.55.234.92]:12832
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751933AbaKVSr1 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sat, 22 Nov 2014 13:47:27 -0500
Content-Disposition: inline
In-Reply-To: <5470C38D.9070209@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

On Sat, Nov 22, 2014 at 06:10:37PM +0100, Marc Kleine-Budde wrote:
> On 09/26/2014 08:25 PM, Andri Yngvason wrote:
> > The handling of can error states is different between platforms.
> > This is an attempt to correct that problem.
> > 
> > I've moved this handling into a generic function for changing the
> > error state. This ensures that error state changes are handled
> > the same way everywhere (where this function is used).
> > 
> > What's changed from the last version of this patch-set is that
> > can_change_state() now relies on the individual states of the rx/tx
> > counters rather than their individual count values.
> > 
> > Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
> 
> What's the status on this series?
> 

I'm working on this right now.

--
Andri
