From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Several sockets on one interface in Python
Date: Fri, 31 May 2013 18:38:58 +0200
Message-ID: <51A8D222.8000206@hartkopp.net>
References: <51A87391.6010308@black-photon.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:60418 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780Ab3EaQjB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 31 May 2013 12:39:01 -0400
In-Reply-To: <51A87391.6010308@black-photon.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Joachim Jaus <jaus@black-photon.de>
Cc: linux-can@vger.kernel.org, Yegor Yefremov <yegorslists@googlemail.com>

Hi Joachim,

On 31.05.2013 11:55, Joachim Jaus wrote:
> Hi all,
> this is my first email to this list, therefore I want start with a big "thank
> you" to all the people involved in the Linux CAN socket development, which has
> opened up a lot of interesting possibilities for sensor and machine control
> for me and my colleagues.

Great! Mind-expansion without drugs but only through SocketCAN :-)

> 
> We would like to bind several sockets with different filter settings to one
> single CAN interface within the same application. Is that generally a safe
> thing to do (both in C and in Python)?

Yes, it's a safe thing to do.

E.g. the candump programm does it in this way.

You may create multiple sockets having each multiple filters.

The only potential drawback that you need to put a select() statement around
it, to manage to read from all created sockets/filedescriptors.

> Is there a way to set filters on a CAN socket in Python similar to the
> implementation in C?

I don't know exactly.
But "CAN_RAW_FILTER" is defined in the Python patch:

http://bugs.python.org/file23234/socketcan_v5.patch

http://libbits.wordpress.com/2012/05/22/socketcan-support-in-python/

so you can hope that the filters are configurable in some way.

Perhaps Yegor knows more about this.

Best ragards,
Oliver


