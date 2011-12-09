From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: iproute2-j1939
Date: Fri, 9 Dec 2011 12:47:40 +0100
Message-ID: <20111209114740.GG325@e-circ.dyndns.org>
References: <20111208133213.GB964@e-circ.dyndns.org>
 <loom.20111208T150123-262@post.gmane.org>
 <20111208151917.GE964@e-circ.dyndns.org>
 <loom.20111208T171058-366@post.gmane.org>
 <20111209080726.GA325@e-circ.dyndns.org>
 <loom.20111209T095640-685@post.gmane.org>
 <20111209094856.GC325@e-circ.dyndns.org>
 <loom.20111209T114335-991@post.gmane.org>
 <20111209110348.GF325@e-circ.dyndns.org>
 <loom.20111209T120741-948@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:35787 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752113Ab1LILro (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 9 Dec 2011 06:47:44 -0500
Content-Disposition: inline
In-Reply-To: <loom.20111209T120741-948@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Fri, Dec 09, 2011 at 11:12:30AM +0000, Wolfgang wrote:
> > I'm asking myself, do you got regular iproute2 compiled (with CAN)?
> > I believe you facing problems not related to my j1939 port of them.
> 
> Do you mean the iproute2 which is included in the BSP?
Yes.
It must have been compiled, and I assume it carries CAN support.
The j1939 port of iproute2 does fail on things like AF_CAN etc.
Something must be different.

Kurt
