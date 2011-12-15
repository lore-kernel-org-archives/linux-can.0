From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: replacing iproute2 & can-utils with j1939 variants
Date: Thu, 15 Dec 2011 13:04:34 +0100
Message-ID: <20111215120434.GD321@e-circ.dyndns.org>
References: <20111213095312.GC430@e-circ.dyndns.org>
 <loom.20111213T155714-170@post.gmane.org>
 <20111213155110.GA314@e-circ.dyndns.org>
 <loom.20111214T140958-737@post.gmane.org>
 <20111214154351.GB6112@e-circ.dyndns.org>
 <loom.20111214T190347-790@post.gmane.org>
 <20111214204237.GC306@e-circ.dyndns.org>
 <loom.20111215T085023-710@post.gmane.org>
 <20111215092018.GB321@e-circ.dyndns.org>
 <loom.20111215T114301-18@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:27137 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751367Ab1LOMEk (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 15 Dec 2011 07:04:40 -0500
Content-Disposition: inline
In-Reply-To: <loom.20111215T114301-18@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Thu, Dec 15, 2011 at 11:24:13AM +0000, Wolfgang wrote:
> 
> but the kernel header path is .../built-target/linux-2.6.31 and the
> iproute2 path is ../built-target/iproute2-2.6.29-1 so they aren't 
> in touch, as I understand that.
Kernel does not alter the ABI in an incompatible way. So iprout2-2.6.29
will work with linux-2.6.29 and higher.

The other way (like iproute2-2.6.35 on linux-2.6.31) works as long
as iproute2 does not use features introduced since 2.6.31 :-)

> 
> But I hope I did it right!! So can I now copy and/or replace the 
> things which I created from compiling iproute2-j1939 and can-utils-j1939 
> to the target or all of it?
You can.
To be more precise, you :
* _must_ replace the original 'ip' with the one from iproute2-j1939
* _must_ add 'jacd', 'jspy' and 'jsr' from can-j1939-utils

You _may_ replace other binaries, but that is not necessary.

Kurt
