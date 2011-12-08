From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: using j1939: userspace binaries
Date: Thu, 8 Dec 2011 14:32:13 +0100
Message-ID: <20111208133213.GB964@e-circ.dyndns.org>
References: <20111206104432.91170@gmx.net>
 <20111206121403.GB322@e-circ.dyndns.org>
 <loom.20111206T131950-88@post.gmane.org>
 <20111206131815.GD322@e-circ.dyndns.org>
 <loom.20111207T093827-478@post.gmane.org>
 <20111207143333.GD373@e-circ.dyndns.org>
 <20111207145032.GE373@e-circ.dyndns.org>
 <loom.20111208T120006-91@post.gmane.org>
 <20111208123004.GA964@e-circ.dyndns.org>
 <loom.20111208T134455-791@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:19173 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911Ab1LHNcR (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 8 Dec 2011 08:32:17 -0500
Content-Disposition: inline
In-Reply-To: <loom.20111208T134455-791@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Thu, Dec 08, 2011 at 12:48:53PM +0000, Wolfgang wrote:
> > > Where do I have to place this 2 folders now
> > all binaries in ..../usr/bin should go in /usr/bin on the target.
> 
> ok just copy and paste?
for example
> But from which directory the one generated 
> by can-j1939-utils or iproute2-j1939 because they contain both 
> all the same binaries.
that sounds not good.
can-j1939-utils should have binaries like candump, can..., jspy, jacd, ...

iproute2-j1939 should have (at least) ip.

what files (binaries) exist in your .../usr/bin ?

Kurt
