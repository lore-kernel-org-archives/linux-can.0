From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: socketCan build fails
Date: Mon, 27 Feb 2012 10:32:32 +0100
Message-ID: <4F4B4DB0.4060400@grandegger.com>
References: <4F4654F6.8010201@wegmannusa.com> <4F4675B7.4040605@hartkopp.net> <9642069.LSMGlbII5g@lisa>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:42366 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909Ab2B0Jce (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 27 Feb 2012 04:32:34 -0500
In-Reply-To: <9642069.LSMGlbII5g@lisa>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Steffen Rose <ro@emtas.de>
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, Gabriel Manriquez <gmanriquez@wegmannusa.com>

Hi Steffen,

On 02/27/2012 10:12 AM, Steffen Rose wrote:
> Hi,
> 
>> The content of the kernel/2.6 directory is mainly needed for older Kernels
>> that do not have SocketCAN support (which was introduced in 2.6.25).
> 
> differ the kernel socketCAN path from our used socketCAN?

Yes, if "our used socketCAN" means the out-of-tree "SocketCAN
repository" (formerly at BerliOS and now at gitorious.rog).

> Of course, I know, this both are different repositories. But I was the meaning, 
> that at the first the changes comes in our repository and later our patches are 
> copied to the kernel.

Unfortunately, that's not the case. The main focus is on providing
support for the mainline kernel. The intention is that patches/fixes are
backported from the kernel tree but also that did not always happen.
Both trees are not in full sync, sorry.

> Additional question:
> Are there a Kernel list with information, which socketCAN feature is included 
> (e.g. 3.2 - gateway functionality)?

"$ git log drivers/net/can" should provide that information.

> Is there a "TAG" in our repository to see, which software state was copied to 
> which kernel version?

No, see above.

Wolfgang.

