From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: iproute2-j1939
Date: Fri, 9 Dec 2011 12:03:48 +0100
Message-ID: <20111209110348.GF325@e-circ.dyndns.org>
References: <20111208123004.GA964@e-circ.dyndns.org>
 <loom.20111208T134455-791@post.gmane.org>
 <20111208133213.GB964@e-circ.dyndns.org>
 <loom.20111208T150123-262@post.gmane.org>
 <20111208151917.GE964@e-circ.dyndns.org>
 <loom.20111208T171058-366@post.gmane.org>
 <20111209080726.GA325@e-circ.dyndns.org>
 <loom.20111209T095640-685@post.gmane.org>
 <20111209094856.GC325@e-circ.dyndns.org>
 <loom.20111209T114335-991@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:35202 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751065Ab1LILDx (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 9 Dec 2011 06:03:53 -0500
Content-Disposition: inline
In-Reply-To: <loom.20111209T114335-991@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Fri, Dec 09, 2011 at 10:56:01AM +0000, Wolfgang wrote:
> > You can safely add "#define AF_CAN 29" and "#define AF_CAN PF_CAN" in
> "sys/socket.h"
> 
> Ok, I have, done that and it worked but now the next error occured, next thing
> was not declared. So I thought, I will build the newer oselas toolchain? Does
What was not declared?

> this make sense?
> 
> new one:                       old one:
> gcc-4.5.2                      gcc-4.3.2
> glibc-2.13-binutils-2.21       glibc-2.8-binutils-2.18
> linux-2.6.36                   linux-2.6.27
> 
I'm not aware of the integration of linux-can in glibc's headers.
Anyone experience with this configuration?

I'm asking myself, do you got regular iproute2 compiled (with CAN)?
I believe you facing problems not related to my j1939 port of them.

Kurt
