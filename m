From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: J1939
Date: Thu, 14 Nov 2013 21:31:47 +0100
Message-ID: <20131114203147.GA7128@vandijck-laurijssen.be>
References: <1384388788.4066.16.camel@hp-dhlii>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay005.isp.belgacom.be ([195.238.6.171]:8387 "EHLO
	mailrelay005.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757425Ab3KNUcD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 14 Nov 2013 15:32:03 -0500
Content-Disposition: inline
In-Reply-To: <1384388788.4066.16.camel@hp-dhlii>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Cc: linux-can@vger.kernel.org

Hi David,

On Wed, Nov 13, 2013 at 07:26:28PM -0500, David H. Lynch Jr. wrote:
> I recently noticed that J1939 support has been incorporated into the
> Linux Kernel CAN stack. 

Well, the j1939 stack is not yet incorporated in mainline Linux.
It's API, which adheres to BSD socket semantics than raw CAN due
to the addressing concept, causes some resistance.

You are of course welcome to share your opinions about that matter.

Once the API is agreed, mainline should be easy.

> 
> I would be happy to help with testing that with some pointers. 

Great. I have performed only manual tests in the past to get
the stack right.
Some sort of automated test may be usefull to avoid
problems over time with refactoring or changing kernel
infrastructures.

A sample of the code got certified in an ISOBUS product.
At that time, the code proved to be functional, both for
the normal use case as for a lot of erroneous situations.

> 
> Any simple examples of sending/receiving specific PGN's ?

You can read Documentation/networking/j1939.txt.
The can-utils-j1939 package have some tools, but those do not expose
the easiest examples.

I will add some easier examples that are a bit closer to real-life
programs.

Kind regards,
Kurt
