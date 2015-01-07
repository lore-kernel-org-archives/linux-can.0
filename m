From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: [PATCH v6] can: move can_stats.bus_off++ from can_bus_off into
 can_change_state
Date: Wed, 7 Jan 2015 16:36:53 +0000
Message-ID: <20150107163653.12684.92317@shannon>
References: <b032a1c3-b80d-41a4-998b-4fe0e5a8118b@GRBSR0089.marel.net>
 <54AD4F82.6030207@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-am1on0054.outbound.protection.outlook.com ([157.56.112.54]:7104
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753295AbbAGQhA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Jan 2015 11:37:00 -0500
In-Reply-To: <54AD4F82.6030207@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: wg@grandegger.com

Quoting Marc Kleine-Budde (2015-01-07 15:23:46)
> On 12/11/2014 03:15 PM, Andri Yngvason wrote:
> > In order to be able to move the stats increment from can_bus_off() into
> > can_change_state(), the increment had to be moved back into code that was using
> > can_bus_off() but not can_change_state().
> > 
> > As a side-effect, this patch fixes the following bugs:
> >  * Redundant call to can_bus_off() in c_can.
> >  * Bus-off counted twice in xilinx_can.
> 
> FTBFS:
> 
> > drivers/net/can/bfin_can.c: In function 'bfin_can_err':
> > drivers/net/can/bfin_can.c:355:8: error: 'struct net_device_stats' has no member named 'bus_off'
> 
Whoops, sorry. I'll fix that ASAP.

--
Andri
