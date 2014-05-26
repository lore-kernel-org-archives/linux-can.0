From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: j1939 for linux 3.12 problem
Date: Mon, 26 May 2014 10:07:33 +0200
Message-ID: <20140526080733.GB479@vandijck-laurijssen.be>
References: <CALoSW66s1aWz6g=RRLebh_Le6j7Br1Phet_tuisC2oWbGwQzJA@mail.gmail.com>
 <CALoSW65MXVzugeZVyi7q1znDWgbxxLiUE-apUcgSLRU+XmN9Bw@mail.gmail.com>
 <20140525181834.GB1055@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay003.isp.belgacom.be ([195.238.6.53]:39823 "EHLO
	mailrelay003.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751767AbaEZIHi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 May 2014 04:07:38 -0400
Content-Disposition: inline
In-Reply-To: <20140525181834.GB1055@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Nimai Mahajan <nimaim@gmail.com>
Cc: linux-can@vger.kernel.org

Hey,

On Sun, May 25, 2014 at 08:18:34PM +0200, Kurt Van Dijck wrote:
> > 
> > My problem is merging your j1939-v3.8 branch to the 3.12.13 kernel (3.8 is no
> > longer supported and kernel.org states that 3.10.x and 3.12.x are the latest
> > longterm supported kernels, so it would be great if I can get it to work on one
> > of these). The merge works fine, here is the result of that:
> 

I created a j1939-v3.12-rc1 branch, that does compile (on my system).
I fixed the compile-time problems due to procfs & rtnetlink, without
altering too much of the code or functionality.
I was unable to test yet.

Can you:
* undo your j1939-v3.8 merge
* merge j1939-v3.12-rc1
* verify that it not crash your system?

Kind regards,
Kurt
