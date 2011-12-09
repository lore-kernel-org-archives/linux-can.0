From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: iproute2-j1939
Date: Fri, 9 Dec 2011 10:48:56 +0100
Message-ID: <20111209094856.GC325@e-circ.dyndns.org>
References: <20111207145032.GE373@e-circ.dyndns.org>
 <loom.20111208T120006-91@post.gmane.org>
 <20111208123004.GA964@e-circ.dyndns.org>
 <loom.20111208T134455-791@post.gmane.org>
 <20111208133213.GB964@e-circ.dyndns.org>
 <loom.20111208T150123-262@post.gmane.org>
 <20111208151917.GE964@e-circ.dyndns.org>
 <loom.20111208T171058-366@post.gmane.org>
 <20111209080726.GA325@e-circ.dyndns.org>
 <loom.20111209T095640-685@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:34161 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752944Ab1LIJtH (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 9 Dec 2011 04:49:07 -0500
Content-Disposition: inline
In-Reply-To: <loom.20111209T095640-685@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Fri, Dec 09, 2011 at 09:02:53AM +0000, Wolfgang wrote:
> > can.h got updated (struct can_addr extended), but I'm not sure
> > exactly which paths must be updated.
> 
> OK, so do you think I have to replace the existing can.h with the can.h from
> can-j1939-modules?
Yes, I think so.
> 
> Or is it possible that the af_can.h (found in can-j1939-modules/net/can)
> has to be included in the utils.c file (utils.c:518: error: 'AF_CAN'\
>  undeclared (first use in this function), it's just an idea?
No, you don't need CAN.

the macro AF_CAN for userspace applications is in bits/socket.h (of the toolchain),
included by sys/socket.h.
If AF_CAN is unknown, even when "#include <sys/socket.h>", you need to modify
bits/socket.h IMO. "#include <linux/socket.h>" would work, but feels a bit dirty.

You can safely add "#define AF_CAN 29" and "#define AF_CAN PF_CAN" in "sys/socket.h"

Kurt
