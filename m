From: David Jander <david@protonic.nl>
Subject: Re: MCP2515 implementation is slow
Date: Thu, 27 Nov 2014 08:46:27 +0100
Message-ID: <20141127084627.6888dc6b@archvile>
References: <84a1d29551f84f5494b309e1ad1e0840@SGPMBX1004.APAC.bosch.com>
	<5474B2BD.1030901@eurekelettronica.it>
	<2E9F00CBB66AB544A1ACDC59627518BA4F02C96C@mailserver>
	<20141126123242.13254.31551@shannon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:26840 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbaK0Hq0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 27 Nov 2014 02:46:26 -0500
In-Reply-To: <20141126123242.13254.31551@shannon>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Rost, Martin" <Martin.Rost@tonfunk.de>

On Wed, 26 Nov 2014 12:32:42 +0000
Andri Yngvason <andri.yngvason@marel.com> wrote:

> Quoting Rost, Martin (2014-11-26 12:02:13)
> > Hi all,
> > 
> > > this VERY POOR chip.
> > As the mcp251x is voted down by the list members regularly, is there an
> > alternative you guys would recommend?
> > 
> Well, sja1000 is pretty solid. They're used for example in the peak_pci.

It is actually pretty sad that one still tends to mention this old dinosaur.
It has a terribly slow parallel multiplexed bus-interface that works on 5V. If
you want to connect it to a modern ARM SoC, you will have to implement some
quite expensive level-shifting and then probably bit-bang the interface via
GPIO's or use an (even more expensive and complicated) CPLD or FPGA to do the
bus-translation. You are kidding, right?

To go back to the sad reality of CAN interfaces: No, there seems to be no
good alternative whatsoever.

If you want SocketCAN on an embedded system, choose a SoC that has built-in CAN
controllers or connect a supported commercial CAN interface via USB or (if you
have it) PCIe. Please note that many commercial (USB-) CAN-interfaces are not
capable of producing 100% bus load at higher bitrates. USB has too much
latency and the dongles tend to have too little buffer-space (there's often a
SJA1000 crammed up inside).

Best regards,

-- 
David Jander
Protonic Holland.
