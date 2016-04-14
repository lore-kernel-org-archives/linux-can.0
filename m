From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939 Linux
Date: Fri, 15 Apr 2016 01:10:13 +0200
Message-ID: <20160414231013.GA5545@airbook.vandijck-laurijssen.be>
References: <4E8D1C61-042C-4AF2-99AF-410CEEBA6861@vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA87095C7B@POCITMSEXMB05.LntUniverse.com>
 <20160409114019.GA8567@airbook.vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA8709986A@POCITMSEXMB05.LntUniverse.com>
 <20160412082020.GA19875@airbook.vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA8709A50F@POCITMSEXMB05.LntUniverse.com>
 <20160412181540.GE19875@airbook.vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA8709B02E@POCITMSEXMB05.LntUniverse.com>
 <20160414100314.GB16018@airbook.vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA8709BB05@POCITMSEXMB05.LntUniverse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b03.edpnet.be ([212.71.1.220]:37772 "EHLO
	relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbcDNXNT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 14 Apr 2016 19:13:19 -0400
Content-Disposition: inline
In-Reply-To: <03B271BE48E2554EB34508DAB79DBABA8709BB05@POCITMSEXMB05.LntUniverse.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dinesh Velayudham <Dinesh.Velayutham@LnTtechservices.com>
Cc: gianluca <gianlucarenzi@eurek.it>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

> Kurt,
> Appreciate your time and getting a new branch. Using v3.19 I am able to build, install and reboot to the custom kernel. I am also able to load j1939 kernel module.
> Now I am facing an new issue. I was trying to compile the "test-can-j1939" test application and "make" gave an error that it is unable to find
> J1939.h header file under "include/linux/can/j1939.h".
> So explored both the kernel header file package (*.deb file) and also the source directory and I am unable to locate j1939.h file under "include/linux/can/j1939.h". Rather I can see j1939.h file under the following places
> 1. "include/config/can"
> 2. "include/uapi/linux/can"
> 3. "usr/include/linux/can"
> I tried to compare this path with installed kernel headers under "/usr/src/linux-headers-3.19.0-custom" and I could find them in
> 1. "include/uapi/linux/can/j1939.h"
> 2. "include/config/can/j1939.h"
> But not in "include/linux/can"
> Any suggestions?

in the kernel source (j1939d-v3.19), the command
	$ git ls-files | grep j1939
yiels
	include/uapi/linux/can/j1939.h

All other files are intermediate copies.
Unfortunately, I'm not so well qualified in the deb-pkg build process.
I'm not sure what to think of it.

IMO, any header file in include/uapi will be taken unconditionally with
	$ make headers_install

To fast-forward:
	cp <repository>/include/uapi/linux/can.h /usr/include/linux/
	cp <repository>/include/uapi/linux/can/j1939.h /usr/include/linux/can/

This should make things work.

You should note that the size of struct can_addr increases.
Both the old & new size are accepted by the new kernel, i.e. you do not
need to recompile binaries that use can_raw etc. like candump ...
They work unmodified.
The new size of struct can_addr is however not accepted by the mainline
kernel (yet). So, if you replace the can.h header file, and recompile
can-utils, then candump will not work properly on non-j1939 kernels.
So, make a copy of the existing can.h header!

Kind regards,
Kurt
