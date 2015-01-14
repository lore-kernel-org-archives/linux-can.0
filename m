From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: c_can: (newbie) high system load when frame not acked?
Date: Wed, 14 Jan 2015 09:55:04 +0000
Message-ID: <20150114095504.16836.68273@shannon>
References: <9c72f211-becc-4c0f-94f6-0700dfb1195e@GRBSR0089.marel.net>
 <alpine.DEB.2.02.1501121751530.28201@login> <1735533.0yOonAfCy1@heinz>
 <alpine.DEB.2.02.1501121948370.28201@login>
 <54B472B2.4010300@optusnet.com.au>
 <alpine.DEB.2.02.1501131523290.12789@login>
 <20150113153243.26859.47218@shannon> <54B5C7F2.3060702@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db3on0074.outbound.protection.outlook.com ([157.55.234.74]:28216
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752045AbbANJzN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 14 Jan 2015 04:55:13 -0500
In-Reply-To: <54B5C7F2.3060702@optusnet.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: tom_usenet@optusnet.com.auTom Evans <tom_usenet@optusnet.com.au>, Viktor Babrian <babrian.viktor@renyi.mta.hu>
Cc: linux-can@vger.kernel.org

Quoting Tom Evans (2015-01-14 01:35:46)
> On 14/01/15 02:32, Andri Yngvason wrote:
> > Quoting Viktor Babrian (2015-01-13 15:10:29)
> >
> > Note: The FlexCAN driver does actually respect berr-reporting for i.MX6.
> > However, it does not respect it for some older chips.
> 
> The flexcan.c driver behaves differently depending on whether it has 
> "FLEXCAN_HAS_BROKEN_ERR_STATE" set (on for MX25, MX35, MX53 and off for MX28 
> and MX6). I don't think this distinction actually helps, or improves matters 
> enough to be worth the CPU loading this causes in these disconnected/solo CAN 
> states.
> 
I agree.

> ... 
> Does "FLEXCAN_HAS_BROKEN_ERR_STATE" do anything useful that I've missed? If 
> not then that code should be removed. I've done that in the old (Linux 3.4) 
> version of the driver I'm using.
>
The first step towards making that change is posting patches. ;)

--
Andri
