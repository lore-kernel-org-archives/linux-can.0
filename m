From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: j1939 - mainline problems
Date: Thu, 21 Mar 2013 07:05:16 +0100
Message-ID: <20130321060516.GB1419@vandijck-laurijssen.be>
References: <514787AD.50303@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay003.isp.belgacom.be ([195.238.6.53]:9085 "EHLO
	mailrelay003.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752298Ab3CUGFU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 21 Mar 2013 02:05:20 -0400
Content-Disposition: inline
In-Reply-To: <514787AD.50303@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Mon, Mar 18, 2013 at 10:31:25PM +0100, Oliver Hartkopp wrote:
> Hi Kurt,
> 

> E.g. why don't you add a j1939_priv pointer to struct dev_rcv_lists when
> CONFIG_CAN_J1939 is enabled?

This would allow to lookup a j1939_priv struct from a netdev directly.
That is a great idea!
I had not thought about that yet. Partly because I did start out-of-tree :-)

I'll just go in that direction.
Btw, It would be a struct j1939_segment * currently.
I consider
	s/j1939_segment/j1939_priv/g 
if that makes things more clear.
> 
> Looks like j1939_segment_find() is a frequently used walkthrough function ...
> 
Your idea of dev_rcv_lists solves that.

Kind regards,
Kurt
