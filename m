From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: using j1939: j1939.h
Date: Wed, 7 Dec 2011 15:33:33 +0100
Message-ID: <20111207143333.GD373@e-circ.dyndns.org>
References: <20111206104432.91170@gmx.net>
 <20111206121403.GB322@e-circ.dyndns.org>
 <loom.20111206T131950-88@post.gmane.org>
 <20111206131815.GD322@e-circ.dyndns.org>
 <loom.20111207T093827-478@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay008.isp.belgacom.be ([195.238.6.174]:61997 "EHLO
	mailrelay008.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756060Ab1LGOdj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Dec 2011 09:33:39 -0500
Content-Disposition: inline
In-Reply-To: <loom.20111207T093827-478@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Wed, Dec 07, 2011 at 08:55:58AM +0000, Wolfgang wrote:

I forgot to mention the modifications to your toolchain:
include/linux/can.h and include/linux/can/j1939.h must be taken
accordingly to what you'll find in can-j1939-modules (under
include/socketcan/{can.h,can/j1939.h}.

Otherwise, you will not build any of j1939 I think...

@Oliver,
How can one use the headers of an external can-modules
repository for CAN?


> > can-j1939-utils: (Similar to can-utils)
> > I think you need to do this:
> > $ ./autogen.sh
do not forget to
$ export PATH=$PATH:YOUR_PATH_TO_POWERPC_TOOLCHAIN_BIN
> > $ ./configure --host=powerpc-603e-linux-gnu --prefix=/usr
I see (using some arm compiler)
...
checking for strtoul... yes
checking for linux/can/gw.h... no
checking for linux/can/j1939.h... yes
...
> > $ make
...
canbusload.c:(.text+0x890): undefined reference to `pselect'
...
So, I edited GNUmakefile, and removed canbusload from the program list.
and then, all gets compiled.

> > $ make install DESTDIR=...
> 
> it is working but nothing is built in the directory /test
"/test" ?
> .......
> libtool: install: /usr/bin/install -c slcanpty /usr/bin/slcanpty
> make[1]: Nothing to be done for `install-data-am'.
> make[1]: Leaving directory `/can-j1939-utils'
> make: Nothing to be done for `/test'
Now I'm sure, you forgot the j1939 header in the toolchain.

I'm gonna work to indicate j1939.h status during ./configure ...
It's these kind of small problems that I never encountered during
development ...
> 

Kurt
