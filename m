From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: Strange error with jspy utility: Bus problems
Date: Tue, 29 May 2012 09:40:39 +0200
Message-ID: <20120529074039.GB437@vandijck-laurijssen.be>
References: <CA+cPUuTWRQQ0qBnP1pE34wbMHF1OqXoBq5LkwQzkMgWFOyuzrA@mail.gmail.com>
 <4FB76279.6040201@hartkopp.net>
 <CA+cPUuTm72nWUcoK5QBEqZdKq9EjcSHcZrR1Z0s=pVV2gK25Ow@mail.gmail.com>
 <4FBEEB87.4060902@hartkopp.net>
 <CA+cPUuRwRE4A82AxL0LEOsPsKuu5XTR0wxcejhJMpOe3-ZpXPA@mail.gmail.com>
 <4FC0764D.5050900@hartkopp.net>
 <4FC07EC3.3000406@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:22035 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751253Ab2E2Hkk (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 29 May 2012 03:40:40 -0400
Content-Disposition: inline
In-Reply-To: <4FC07EC3.3000406@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Abdul Khan <akhan@symboticware.com>, linux-can@vger.kernel.org

On Sat, May 26, 2012 at 08:57:07AM +0200, Oliver Hartkopp wrote:
> 
> >>
> >> I don't know, Why sja1000_isa driver is giving "error warning
> >> interrupt" and "error passive interrupt" messages. As simulator
> >> supposed to be sent properly formatted j1939 frame to can1.
> >>
> >> What could be possible cause for this type of behaviour ?
> >>

I didn't focused on this at start, and lost the issue a bit.
J1939 is supposed (by norm) to run 250kbit. You're operating j1939
on 125kbit, which is (logically) possible, but beware interfacing
with others!
Are you sure your simulator is operating 125kbit?

Regards,
Kurt
