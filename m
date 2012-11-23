From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: J1939 support: plans for integration?
Date: Fri, 23 Nov 2012 06:52:40 +0100
Message-ID: <20121123055240.GA17495@vandijck-laurijssen.be>
References: <50AE12C5.2070501@ilv.uni-kiel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay012.isp.belgacom.be ([195.238.6.179]:38289 "EHLO
	mailrelay012.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751697Ab2KWFwh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 23 Nov 2012 00:52:37 -0500
Content-Disposition: inline
In-Reply-To: <50AE12C5.2070501@ilv.uni-kiel.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Christoph Appel <cappel@ilv.uni-kiel.de>
Cc: linux-can@vger.kernel.org

Hi,

> are there any plans for a "streamlined" integration of J1939 support
> into linux-can i.e. the kernel main line?
This has always been the target, and still is.
The number of known users is very small, and do not convince linux-can maintainers
yet that the approach of the stack is a good approach.

You're welcome to join this effort.

How do you use the current J1939 stack?
Do you use Transport Protocol, Address Claiming, ....
Do you use it only on developer PC, or on production items.
Mr. Hartkopp & I are very interested in feedback of other users.

Kind regards,
Kurt
